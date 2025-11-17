from django.conf import settings
from rest_framework import serializers
from .models import Category, Task, Tag ,Note,Profile
from djoser.serializers import UserCreateSerializer as BaseUserCreateSerializer
from djoser.serializers import UserSerializer as BaseUserSerializer
from django.contrib.auth.models import User
from django.core.mail import send_mail
from django.contrib.auth import authenticate
from djoser.serializers import TokenCreateSerializer
from .utils import send_telegram_message  # add this import at the top
# from .views import tags_count


# class ST5UserCreateSerializer(BaseUserCreateSerializer):
#     class Meta(BaseUserCreateSerializer.Meta):
#         fields=['id','username','email','password','first_name','last_name']
        
#     def create(self, validated_data):
#         # print("data:" , self.initial_data)
#         phone = self.initial_data.pop("phone", None)
#         user = super().create(validated_data)
        
#         Profile.objects.update_or_create(
#             user=user,
#             defaults={
#                 "phone": phone
#             }
#         )
#         return user

# class ST5UserCreateSerializer(BaseUserCreateSerializer):
#     class Meta(BaseUserCreateSerializer.Meta):
#         fields = ['id', 'username', 'email', 'password', 'first_name', 'last_name']

#     def create(self, validated_data):
#         phone = self.initial_data.pop("phone", None)
#         user = super().create(validated_data)
        
#         profile, created = Profile.objects.update_or_create(
#             user=user,
#             defaults={"phone": phone}
#         )

#         # Generate OTP and send email
#         otp = profile.generate_otp()
#         send_mail(
#             subject='Your OTP Code',
#             message=f'Your verification OTP is: {otp}',
#             from_email='noreply@yourdomain.com',  # Change this
#             recipient_list=[user.email],
#             fail_silently=False,
#         )

#         return user


class ST5UserCreateSerializer(BaseUserCreateSerializer):
    class Meta(BaseUserCreateSerializer.Meta):
        fields = ['id', 'username', 'email', 'password', 'first_name', 'last_name']

    def create(self, validated_data):
        user = super().create(validated_data)
        user.is_active = False
        user.save()

        # Optional phone
        phone = self.initial_data.get("phone", None)
        profile, created = Profile.objects.update_or_create(
            user=user,
            defaults={"phone": phone}
        )

        # Generate OTP and send email
        otp = profile.generate_otp()
        send_mail(
            subject='Your OTP Code',
            message=f'Your verification OTP is: {otp}',
            from_email=settings.DEFAULT_FROM_EMAIL,
            recipient_list=[user.email],
            fail_silently=False,
        )

        # 🔹 Send Telegram message
        message = (
            f"📩 New User Registered!\n"
            f"👤 Username: {user.username}\n"
            f"📧 Email: {user.email}\n"
            f"📱 Phone: {phone or 'N/A'}\n"
            f"✅ OTP sent to email."
        )
        send_telegram_message(message)

        return user


class ST5UserSerializer(BaseUserSerializer):
    phone = serializers.CharField(source="profile.phone" , read_only=True)

    class Meta(BaseUserSerializer.Meta):
        model=User
        # fields = tuple(BaseUserSerializer.Meta.fields) + ("phone",)
        fields=['id','username','first_name','last_name','phone']

    
class CustomTokenCreateSerializer(TokenCreateSerializer):
    def validate(self, attrs):
        user = authenticate(**attrs)
        if user:
            if not user.profile.is_verified:
                raise serializers.ValidationError("Email not verified.")
        return super().validate(attrs)    

class CategorySerializer(serializers.ModelSerializer):
    tasks_count = serializers.IntegerField(read_only = True)
    status = serializers.SerializerMethodField()
    rate = serializers.FloatField(max_value=5.0)
    def get_status(self, obj):
        count = obj.tasks.count()
        if count == 0:
            return "None"
        elif count <= 3:
            return "A Few"
        else:
            return "Too Many"
    
    class Meta:
        model = Category
        fields = ['id','name','hex_color','tasks_count','status','rate']

class TagSerializer(serializers.ModelSerializer):
    
    tags_count = serializers.IntegerField(read_only = True)
    status = serializers.SerializerMethodField()
    # def get_tags_count(self, obj):
    #     return obj.tasks.count()  # adjust if you use a different related name

    def get_status(self, obj):
        count = obj.tasks.count()
        if count == 0:
            return "None"
        elif count <= 3:
            return "A Few"
        else:
            return "Too Many"
    
    class Meta:
        model = Tag
        fields = ['id', 'label','tags_count','status']
        ## fields = '__all__' => is not recommended

# class TagSerializer(serializers.Serializer):
#     name = serializers.CharField(max_length=100, source='label')

class TaskSerializer(serializers.ModelSerializer) :
    class Meta :
        model = Task
        fields = ['id','name','due_date','category','tag']
    # title = serializers.CharField(max_length =200, source='name')
    # note = serializers.CharField(max_length=200)
    # due_date = serializers.DateField()
    # category = serializers.CharField(max_length=100)
    # tag = TagSerializer(many =True)
    
class NoteSerializer(serializers.ModelSerializer) :
    class Meta :
        model = Note
        fields = ['id','content']