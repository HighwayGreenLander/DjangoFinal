# subscriptions/urls.py
from django.urls import path
from . import views

app_name = "paypal_payments"

urlpatterns = [
    path('', views.home, name='home'),

    path("subscribe/<int:plan_id>/", views.subscribe_view, name="paypal_subscription"),
    path("complete/", views.paypal_subscription_complete, name="paypal_subscription_complete"),

]
