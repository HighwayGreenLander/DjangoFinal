
from django.shortcuts import redirect, render
from django.views.decorators.http import require_http_methods
from django.http import HttpResponseBadRequest, HttpResponse
from django.urls import reverse
from django.conf import settings
import paypalrestsdk
from .paypal_client import ensure_paypal_config
from .models import PaymentRecord
from decimal import Decimal, InvalidOperation
from subscriptions.models import SubscriptionPlan

# Create your views here.

def _approval_url(links):
    for l in (links or []):
        rel = getattr(l, "rel", None)
        href = getattr(l, "href", None)
        if rel == "approval_url" and href:
            return href
    return None

@require_http_methods(["GET", "POST"])
def checkout_start(request):
    if request.method == "GET":
        return render(request, "checkout.html")
    
    amount = request.POST.get("amount", "1.00")
    currency = request.POST.get("currency", "USD").upper()
    try:
        Decimal(amount)  # basic validation
    except (InvalidOperation, TypeError):
        return HttpResponseBadRequest("Invalid amount")

    ensure_paypal_config()
    return_url = settings.SITE_URL + reverse("payments:execute")
    cancel_url = settings.SITE_URL + reverse("payments:cancel")

    payment = paypalrestsdk.Payment({
        "intent": "sale",
        "payer": {"payment_method": "paypal"},
        "redirect_urls": {"return_url": return_url, "cancel_url": cancel_url},
        "transactions": [{
            "amount": {"total": amount, "currency": currency},
            "description": "Order description"
        }]
    })

    if payment.create():
        # Save record
        PaymentRecord.objects.update_or_create(
            payment_id=payment.id,
            defaults={"status": payment.state, "amount": amount, "currency": currency},
        )
        url = _approval_url(payment.links)
        if not url:
            print("No approval_url found. Links:",
                [(getattr(x, "rel", None), getattr(x, "href", None)) for x in (payment.links or [])])
            return HttpResponse("No approval_url returned by PayPal.", status=502)
        return redirect(url)
    else:
        # Inspect payment.error for details (JSON)
        return HttpResponse(f"Create payment failed: {payment.error}", status=502)
    
def checkout_execute(request):
    """
    PayPal returns: paymentId, token, PayerID (query params).
    We execute the payment server-side, update DB, and show success.
    """
    ensure_paypal_config()
    payment_id = request.GET.get("paymentId")
    payer_id = request.GET.get("PayerID")

    if not payment_id or not payer_id:
        return HttpResponseBadRequest("Missing paymentId or PayerID")

    payment = paypalrestsdk.Payment.find(payment_id)
    if not payment:
        return HttpResponse("Payment not found.", status=404)

    if payment.execute({"payer_id": payer_id}):
        # Update DB
        PaymentRecord.objects.filter(payment_id=payment.id).update(
            status=payment.state, payer_id=payer_id
        )
        # You can read capture details:
        # sale_id = payment.transactions[0].related_resources[0].sale.id
        return render(request, "success.html", {
            "payment_id": payment.id,
            "state": payment.state,
            "amount": payment.transactions[0].amount.total,
            "currency": payment.transactions[0].amount.currency,
        })
    else:
        return HttpResponse(f"Execute failed: {payment.error}", status=502)
    
def checkout_cancel(request):
    return render(request, "cancel.html")

# paypal subscription views to be added here
import json
import requests
from django.shortcuts import render
from django.conf import settings
from django.contrib.auth.decorators import login_required
from django.http import JsonResponse, HttpResponseForbidden
from django.views.decorators.csrf import csrf_exempt
from .models import PayPalSubscription
from .paypal_client import get_access_token
from django.shortcuts import render, get_object_or_404
from subscriptions.models import SubscriptionPlan


# @login_required(login_url='/client/login/')
# def subscribe_view(request, plan_id):
#     plan = get_object_or_404(SubscriptionPlan, id=plan_id)
#     return render(request, "subscribe.html", {"plan": plan})

@login_required(login_url='/client/login/')
def subscribe_view(request, plan_id):
    """
    Render the subscription page.
    Only authenticated users can access this.
    """
    return render(request, "subscribe.html", {
        "paypal_client_id": settings.PAYPAL_CLIENT_ID,
        "paypal_plan_id": settings.PAYPAL_SUBSCRIPTION_PLAN_ID,
    })

# def subscribe_view(request, plan_id):
#     plan = SubscriptionPlan.objects.get(id=plan_id)
    
#     return render(request, "payments/subscribe.html", {"plan": plan})

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
