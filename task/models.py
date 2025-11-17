from django.db import models
from datetime import datetime, timezone
from django.core.validators import MaxValueValidator
from django.contrib.auth.models import User
import random

# Create your models here.
class Category(models.Model) :
    name = models.CharField(max_length=50)
    hex_color = models.CharField(max_length=10,null=True)
    rate = models.FloatField(default=0.0, validators=[MaxValueValidator(5.0)])
    def __str__(self):
        return self.name
    
class Tag(models.Model) :
    label = models.CharField(max_length=300)
    def __str__(self):
        return self.label
    
class Task(models.Model) :
    name = models.CharField(max_length=200)
    # note = models.CharField(max_length=500)
    due_date = models.DateField(null=True,blank=True)
    created_date = models.DateTimeField(auto_now_add=True)
    category = models.ForeignKey(Category, on_delete=models.CASCADE,related_name='tasks')
    tag = models.ManyToManyField(Tag, related_name='tasks')
    user = models.ForeignKey(User,related_name='user', on_delete=models.CASCADE )
    def __str__(self):
        return self.name
    
class Note(models.Model) :
    content = models.CharField(max_length=255)
    task = models.ForeignKey(Task , on_delete=models.CASCADE, related_name='notes')
    created_at = models.DateTimeField(auto_now_add=True)
    
    def __str__(self):
        return self.content
class TaskProfile(models.Model):
    name = models.CharField(max_length=255)
    description = models.TextField(blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)

# class Profile(models.Model):
#     user = models.OneToOneField(User, on_delete=models.CASCADE,
#                                 related_name="profile",
#                                 primary_key=True)
#     phone = models.CharField(max_length=20, blank=True, null=True)
#     address = models.CharField(max_length=255, blank=True, null=True)
#     picture = models.ImageField(upload_to="profile/", 
# 			    default="profile/default.png",
# 			    blank=True, null=True)

#     def __str__(self):
#         return f"{self.user.username}'s profile" 

class Profile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name="profile", primary_key=True)
    phone = models.CharField(max_length=20, blank=True, null=True)
    address = models.CharField(max_length=255, blank=True, null=True)
    picture = models.ImageField(upload_to="profile/", default="profile/default.png", blank=True, null=True)

    is_verified = models.BooleanField(default=False)
    otp = models.CharField(max_length=6, blank=True, null=True)

    def generate_otp(self):
        otp = str(random.randint(100000, 999999))
        self.otp = otp
        self.save()
        return otp

    def __str__(self):
        return f"{self.user.username}'s profile"
    
