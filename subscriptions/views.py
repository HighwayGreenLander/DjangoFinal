from django.shortcuts import redirect, render, get_object_or_404
from .models import Movie, SubscriptionPlan
from django.contrib.auth.decorators import login_required
from django.http import JsonResponse, HttpResponseForbidden
from django.views.decorators.csrf import csrf_exempt
from paypal.models import PayPalSubscription
from paypal.paypal_client import get_access_token
from django.conf import settings
import json
import requests

# Create your views here.

def home(request):
    movies = Movie.objects.all()

    # attach full image URLs to each movie instance
    for movie in movies:
        if movie.thumbnail:
            movie.full_thumbnail_url = request.build_absolute_uri(movie.thumbnail.url)
        else:
            movie.full_thumbnail_url = None

    plans = SubscriptionPlan.objects.all()

    return render(request, 'subscription/home.html', {
        'movies': movies,
        'plans': plans
    })

@login_required(login_url='/client/login/')
def subscribe_view(request, plan_id):
    """
    Render the subscription page for a specific subscription plan.
    Only authenticated users can access this page.
    """
    if not request.user.is_authenticated:
        return redirect('login')  # replace 'login' with your login URL name

    # Get the subscription plan or return 404
    plan = get_object_or_404(SubscriptionPlan, id=plan_id)

    # Pass plan info and PayPal credentials to template
    return render(request, "subscription/subscribe.html", {
        "plan": plan,
        "paypal_client_id": settings.PAYPAL_CLIENT_ID,
        "paypal_plan_id": plan.paypal_plan_id,
    })

@csrf_exempt
@login_required
def paypal_subscription_complete(request):
    """
    Called by frontend JS after user approves PayPal subscription.
    Retrieves PayPal subscription details and saves them.
    """
    if request.method != "POST":
        return HttpResponseForbidden("POST required")

    data = json.loads(request.body)
    sub_id = data.get("subscription_id")
    if not sub_id:
        return JsonResponse({"error": "Missing subscription_id"}, status=400)

    # Verify subscription with PayPal
    access = get_access_token()
    resp = requests.get(
        f"{settings.PAYPAL_BASE_URL}/v1/billing/subscriptions/{sub_id}",
        headers={"Authorization": f"Bearer {access}"},
    )

    if resp.status_code != 200:
        return JsonResponse({"error": resp.text}, status=400)

    sub_data = resp.json()

    PayPalSubscription.objects.update_or_create(
        paypal_subscription_id=sub_id,
        defaults={
            "user": request.user,
            "status": sub_data.get("status"),
            "plan_id": sub_data.get("plan_id"),
            "start_time": sub_data.get("start_time"),
            "next_billing_time": sub_data.get("billing_info", {}).get("next_billing_time"),
        },
    )

    return JsonResponse({"ok": True, "subscription_status": sub_data.get("status")})
