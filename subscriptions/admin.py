# admin.py
from django.contrib import admin
from .models import Movie, SubscriptionPlan

# Optionally, create a custom admin display
@admin.register(Movie)
class MovieAdmin(admin.ModelAdmin):
    list_display = ('title', 'release_date')
    search_fields = ('title', 'description')
    list_filter = ('release_date',)

@admin.register(SubscriptionPlan)
class SubscriptionPlanAdmin(admin.ModelAdmin):
    list_display = ('name', 'price', 'duration_days')
    search_fields = ('name', 'description')
