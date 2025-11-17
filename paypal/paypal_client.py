import paypalrestsdk
from django.conf import settings

_configured = False

# core/paypal.py
import requests

def get_access_token():
    resp = requests.post(
        f"{settings.PAYPAL_BASE_URL}/v1/oauth2/token",
        headers={"Accept": "application/json"},
        data={"grant_type": "client_credentials"},
        auth=(settings.PAYPAL_CLIENT_ID, settings.PAYPAL_CLIENT_SECRET),
    )
    resp.raise_for_status()
    return resp.json()["access_token"]


def ensure_paypal_config():
    global _configured
    if _configured:  # configure once per process
        return
    paypalrestsdk.configure({
        "mode": settings.PAYPAL_MODE,
        "client_id": settings.PAYPAL_CLIENT_ID,
        "client_secret": settings.PAYPAL_CLIENT_SECRET,
    })
    _configured = True