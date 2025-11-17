from django.shortcuts import render , get_object_or_404
from django.http import HttpResponse
#app/view.py
from rest_framework import generics, permissions
from django.db.models import Count
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .models import Task,Tag,Category, Note
from .serializers import TaskSerializer, TagSerializer, CategorySerializer ,NoteSerializer
from rest_framework.generics import ListCreateAPIView , RetrieveUpdateDestroyAPIView
from rest_framework.viewsets import ModelViewSet
from rest_framework.exceptions import PermissionDenied
from rest_framework.views import APIView
from rest_framework import status
from django.contrib.auth.models import User


from task import models

# class VerifyOTPView(APIView):
#     def post(self, request):
#         username = request.data.get("username")
#         otp = request.data.get("otp")

#         try:
#             user = User.objects.get(username=username)
#         except User.DoesNotExist:
#             return Response({"error": "User not found"}, status=status.HTTP_404_NOT_FOUND)

#         profile = user.profile
#         if profile.otp == otp:
#             profile.is_verified = True
#             profile.otp = None
#             profile.save()
#             return Response({"message": "Email verified successfully"}, status=status.HTTP_200_OK)
#         else:
#             return Response({"error": "Invalid OTP"}, status=status.HTTP_400_BAD_REQUEST)

# task/views.py
from rest_framework.permissions import AllowAny

#last class VerifyOTPView(APIView):
#     permission_classes = [AllowAny]

#     def post(self, request):
#         email = request.data.get("email")
#         otp = request.data.get("otp")

#         if not email or not otp:
#             return Response({"error": "Email and OTP are required"}, status=status.HTTP_400_BAD_REQUEST)

#         try:
#             user = User.objects.get(email=email)
#             profile = user.profile
#         except User.DoesNotExist:
#             return Response({"error": "User not found"}, status=status.HTTP_404_NOT_FOUND)

#         # Check OTP
#         if profile.otp == otp:
#             if user.is_active:
#                 return Response({"error": "Account already verified"}, status=status.HTTP_400_BAD_REQUEST)

#             # ✅ Activate user account
#             user.is_active = True
#             user.save()

#             # ✅ Mark profile verified and clear OTP
#             profile.is_verified = True
#             profile.otp = None
#             profile.save()

#             return Response({"message": "Account verified successfully"}, status=status.HTTP_200_OK)

#         return Response({"error": "Invalid OTP"}, status=status.HTTP_400_BAD_REQUEST)

class VerifyOTPView(APIView):
    permission_classes = [AllowAny]

    def post(self, request):
        email = request.data.get("email")
        otp = request.data.get("otp")

        if not email or not otp:
            return Response({"error": "Email and OTP are required"}, status=400)

        # Find all users with that email
        users = User.objects.filter(email=email)
        if not users.exists():
            return Response({"error": "No user found with this email"}, status=404)

        matched_user = None
        for user in users:
            profile = getattr(user, "profile", None)
            if profile and not profile.is_verified and profile.otp == otp:
                matched_user = user
                break

        if matched_user:
            profile = matched_user.profile
            profile.is_verified = True
            profile.otp = None
            profile.save()

            matched_user.is_active = True
            matched_user.save()

            return Response({"message": "Account verified successfully"}, status=200)

        return Response({"error": "Invalid or already used OTP"}, status=400)

class TaskGeneric(generics.ListCreateAPIView) :
    queryset = Task.objects.all()
    serializer_class =TaskSerializer 
    permission_classes = [permissions.IsAuthenticated]
    
    #get method
    def get_queryset(self):
        if(self.request.user.is_superuser):
            return Task.objects.all()
        return Task.objects.filter(user=self.request.user)
    
    def perform_create(self, serializer):
        serializer.save(user=self.request.user)
    
class TaskDetailGeneric(generics.RetrieveUpdateDestroyAPIView) :
    queryset = Task.objects.all()
    serializer_class =TaskSerializer 
    
    def get_object(self):
        obj = super().get_object()
        if not (self.request.user.is_superuser or obj.user == self.request.user):
            raise PermissionDenied("You do not have permission to access this task.")
        return obj


# class TaskViewSet(ModelViewSet):
#     queryset = Task.objects.all()    
#     serializer_class =TaskSerializer
    
#     def get_queryset(self):
#         queryset = models.Task.objects.all()
#         category_id = self.request.query_params.get('category')
#         tag_id = self.request.query_params.get('tag')
#         if category_id is not None : 
#             queryset = models.Task.objects.filter(category_id = category_id)  #Each .filter() replaces the queryset with a new one.
#         if tag_id is not None : 
#             queryset = models.Task.objects.filter(tag = tag_id)               #If both category=1 and tag=2 are provided, only tag=2 is applied. category=1 gets ignored.
#         return queryset

# class TaskViewSet(ModelViewSet):
#     queryset = Task.objects.all()
#     serializer_class = TaskSerializer

#     def get_queryset(self):
#         queryset = models.Task.objects.all()
#         category_id = self.request.query_params.get('category')
#         tag_id = self.request.query_params.get('tag')

#         if category_id is not None:
#             queryset = queryset.filter(category_id=category_id)

#         if tag_id is not None:
#             queryset = queryset.filter(tag=tag_id)  # ✅ continues filtering the current queryset

#         return queryset

    
class TagViewSet(ModelViewSet):
    queryset = Tag.objects.annotate(
        tags_count = Count('tasks')
    )
    serializer_class =TagSerializer
    
class CategoryViewSet(ModelViewSet):
    queryset = Category.objects.annotate(
        tasks_count = Count('tasks')
    )
    serializer_class =CategorySerializer
class NoteViewSet(ModelViewSet):
    queryset = Note.objects.all()
    serializer_class = NoteSerializer
    
    def get_queryset(self):
        return Note.objects.filter(task=self.kwargs['task_pk'])
    
    def perform_create(self, serializer):
        task = Task.objects.get(pk=self.kwargs['task_pk'])
        serializer.save(task=task)
        # return super().get_queryset()
# # Create your views here.
# class TaskView(ListCreateAPIView):
#     queryset = Task.objects.all()
#     serializer_class = TaskSerializer
    
    
    # def get_serializer_class(self):
    #     return TaskSerializer
# @api_view(['GET' , 'POST'])
# def task(request) :
#     if request.method == 'GET' :
#         all_task = Task.objects.all()
#         tasks = TaskSerializer(all_task , many =True)
#         return Response(tasks.data)
#     elif request.method == 'POST' :
#         client = TaskSerializer(data = request.data)
#         if client.is_valid() :
#             client.save()
#             return Response(client.data , status=201)
#         return Response(
#             client.errors , status=400)
        
# @api_view(['GET' , 'POST'])
# def tag(request) :
#     if request.method == 'GET' :
#         all_tag = Tag.objects.all()
#         tags = TagSerializer(all_tag , many =True)
#         return Response(tags.data)
#     elif request.method == 'POST' :
#         client = TagSerializer(data = request.data)
#         if client.is_valid() :
#             client.save()
#             return Response(client.data , status=201)
#         return Response(
#             client.errors , status=400)
    
# @api_view(['GET' , 'POST'])
# def category(request) :
#     if request.method == 'GET' :
#         all_category = Category.objects.all()
#         categorys = CategorySerializer(all_category , many =True)
#         return Response(categorys.data)
#     elif request.method == 'POST' :
#         client = CategorySerializer(data = request.data)
#         if client.is_valid() :
#             client.save()
#             return Response(client.data , status=201)
#         return Response(
#             client.errors , status=400)


# class TaskDetail(RetrieveUpdateDestroyAPIView):
#     queryset = Task.objects.all()
#     serializer_class = TaskSerializer
#     lookup_field = 'id'
# @api_view(['GET' , 'PUT' , 'PATCH' , 'DELETE'])
# def showtask(request , id) :
#     task = get_object_or_404(Task, pk=id)
#     #query data to show use get_obj_or_404
#     if request.method == 'GET' :
#         x = TaskSerializer(task)
#         return Response(x.data)
    
#     elif request.method == 'PUT' :
#         client = TaskSerializer(task, data =request.data)
#         if client.is_valid():
#             client.save()
#             return Response(client.data)
#         return Response(client.errors, status=400)
    
#     elif request.method == 'PATCH' :
#         client = TaskSerializer(task, data =request.data, partial=True)
#         if client.is_valid():
#             client.save()
#             return Response(client.data)
#         return Response(client.errors, status=400)
#     elif request.method == 'DELETE' :
#         task.delete()
#         return Response({'message' : "delete :D"}, status=204)
    #show query data
    # return Response(f"show {id}")
    #show query data use trycatch
    # try :
    #     task = Task.objects.get(pk=id)
    #     x = TaskSerializer(task)
    #     return Response(x.data)
    # except :
    #     return Response({"error": "Something wrong"},
    #                     status=404)

@api_view()
def home(request):
    return render(request,'task/index.html')
# def index(request) : 
#     return Response("Hello from ST5")
@api_view()
def contact(request):
     return render(request,'task/contact.html')
# def show(request) :
#     return Response("Show")


# @api_view(['GET' , 'PUT' , 'PATCH' , 'DELETE'])
# def showtag(request , id) :
#     tag = get_object_or_404(Tag, pk=id)
#     #query data to show use get_obj_or_404
#     if request.method == 'GET' :
#         x = TagSerializer(tag)
#         return Response(x.data)
    
#     elif request.method == 'PUT' :
#         client = TagSerializer(tag, data =request.data)
#         if client.is_valid():
#             client.save()
#             return Response(client.data)
#         return Response(client.errors, status=400)
    
#     elif request.method == 'PATCH' :
#         client = TagSerializer(tag, data =request.data, partial=True)
#         if client.is_valid():
#             client.save()
#             return Response(client.data)
#         return Response(client.errors, status=400)
#     elif request.method == 'DELETE' :
#         tag.delete()
#         return Response({'message' : "delete :D"}, status=204)

# @api_view(['GET' , 'PUT' , 'PATCH' , 'DELETE'])
# def showcategory(request , id) :
#     category = get_object_or_404(Category, pk=id)
#     #query data to show use get_obj_or_404
#     if request.method == 'GET' :
#         x = CategorySerializer(category)
#         return Response(x.data)
    
#     elif request.method == 'PUT' :
#         client = CategorySerializer(category, data =request.data)
#         if client.is_valid():
#             client.save()
#             return Response(client.data)
#         return Response(client.errors, status=400)
    
#     elif request.method == 'PATCH' :
#         client = CategorySerializer(category, data =request.data, partial=True)
#         if client.is_valid():
#             client.save()
#             return Response(client.data)
#         return Response(client.errors, status=400)
#     elif request.method == 'DELETE' :
#         category.delete()
#         return Response({'message' : "delete :D"}, status=204)
