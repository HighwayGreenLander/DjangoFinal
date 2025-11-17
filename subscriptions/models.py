from django.db import models

# Create your models here.
class Movie(models.Model):
    title = models.CharField(max_length=200)
    description = models.TextField()
    thumbnail = models.ImageField(upload_to='thumbnails/')
    release_date = models.DateField()

    def __str__(self):
        return self.title

class SubscriptionPlan(models.Model):
    name = models.CharField(max_length=50)
    price = models.DecimalField(max_digits=6, decimal_places=2)
    duration_days = models.IntegerField()
    paypal_plan_id = models.CharField(max_length=255, blank=True, null=True)
    description = models.TextField(blank=True, null=True)  # <-- add this

    def __str__(self):
        return self.name


