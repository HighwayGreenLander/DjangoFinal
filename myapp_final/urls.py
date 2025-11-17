from django.contrib import admin
from django.urls import include, path
from django.conf import settings
from django.conf.urls.static import static
from subscriptions import views as subscription_views  # import your movie app views

urlpatterns = [
    # Admin
    path('admin/', admin.site.urls),

    # API routes
    path('api/', include('task.routes')),  # your task APIs

    # Djoser authentication routes
    path('api/auth/', include('djoser.urls')),
    path('api/auth/', include('djoser.urls.jwt')),

    # Payment routes
    path('payment/', include('payment.urls')),
    path('paypal/', include('paypal.urls')),
    
    # Movie subscription frontend
    # path('home/', subscription_views.home, name='home'),   # home page for movies & subscriptions
    path('subscriptions/', include('subscriptions.urls')),
    # path("subscribe/<int:plan_id>/", subscription_views.subscribe_view, name="paypal_subscribe"),

    path("client/", include("client.urls")),

]

# Serve media files in development
if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
