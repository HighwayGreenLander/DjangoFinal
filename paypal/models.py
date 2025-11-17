from django.db import models

# Create your models here.
## Model
class PaymentRecord(models.Model):
    payment_id  = models.CharField(max_length=64, unique=True)
    status      = models.CharField(max_length=32)
    amount      = models.DecimalField(max_digits=10, decimal_places=2)
    currency    = models.CharField(max_length=8, default="USD")
    payer_id    = models.CharField(max_length=64, blank=True, null=True)
    created_at  = models.DateTimeField(auto_now_add=True)
    updated_at  = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"{self.payment_id} ({self.status})"
    
# paypal subscription model
## Model
from django.contrib.auth import get_user_model
User = get_user_model()

class PayPalSubscription(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    paypal_subscription_id = models.CharField(max_length=64, unique=True)
    status = models.CharField(max_length=32)
    plan_id = models.CharField(max_length=64)
    start_time = models.DateTimeField(null=True, blank=True)
    next_billing_time = models.DateTimeField(null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
