# Create your views here.
from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login
from django.contrib.auth.models import User
from django.contrib import messages

def login_view(request):
    if request.method == "POST":
        username = request.POST["username"]
        password = request.POST["password"]
        user = authenticate(username=username, password=password)

        if user:
            login(request, user)
            return redirect("payments:paypal_subscribe", plan_id=request.GET.get("next_plan", 1))
        else:
            messages.error(request, "Invalid username or password")

    return render(request, "client/login.html")


def register_view(request):
    if request.method == "POST":
        username = request.POST["username"]
        email = request.POST["email"]
        password = request.POST["password"]

        User.objects.create_user(username=username, email=email, password=password)
        return redirect("client:login")

    return render(request, "client/register.html")


def forgot_password_view(request):
    return render(request, "client/forgot_password.html")
