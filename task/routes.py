from django.urls import path, include
from task import views
# from rest_framework.routers import DefaultRouter
from rest_framework_nested.routers import DefaultRouter, NestedDefaultRouter 
from task.views import TaskGeneric,TaskDetailGeneric, TagViewSet , CategoryViewSet ,NoteViewSet
from task.views import VerifyOTPView

# router = DefaultRouter()
# router.register('', TaskViewSet )

# urlpatterns= router.urls
# urlpatterns =[
#     path('', views.home),
#     path('contact', views.contact),
#     # api
#     # # path('', views.index),
#     # path('apitask', views.TaskView.as_view()),
#     # path('apitask/<id>/', views.TaskDetail.as_view()),
   
#     path('apitag', views.tag),
#     path('apicategory' , views.category),
#     path('apitag/<id>/', views.showtag),
#     path('apicategory/<id>/', views.showcategory)
# ]

# urls.py


router = DefaultRouter()
# router.register(r'tasks', TaskGeneric),
# router.register(r'tags', TagViewSet),
# router.register(r'category', CategoryViewSet),

# Nested router for notes under tasks
# sub_note = NestedDefaultRouter(router, 'tasks', lookup='task')
# sub_note.register(r'notes', NoteViewSet, basename='task-notes')

# router.register(r'notes', NoteViewSet),
urlpatterns = [
    path("tasks/", TaskGeneric.as_view()),
    path("tasks/<int:pk>/", TaskDetailGeneric.as_view()),
    path('verify-otp/', VerifyOTPView.as_view(), name='verify-otp'),
    # path('api', include(router.urls)),
    path('', views.home),
    path('contact', views.contact)
] + router.urls