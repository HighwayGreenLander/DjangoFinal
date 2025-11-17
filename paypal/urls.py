from django.urls import path
from . import views
app_name = "payments"
urlpatterns = [
    path("checkout/", views.checkout_start, name="start"),
    path("checkout/cancel/", views.checkout_cancel, name="cancel"),
    path("checkout/execute/", views.checkout_execute, name="execute"),
    # subscription URLs could be added here
    
    path("subscribe/<int:plan_id>/", views.subscribe_view, name="paypal_subscribe"),

    # path("subscribe/", views.subscribe_view, name="paypal_subscribe"),

    path("complete/", views.paypal_subscription_complete, name="paypal_subscription_complete"),
]