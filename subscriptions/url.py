# subscriptions/urls.py
from django.urls import path
from . import views

urlpatterns = [
    path('', views.home, name='home'),
    path("subscribe/<int:plan_id>/", views.subscribe_view, name="paypal_subscribe"),


]
