import json
import requests

from django.conf import settings
from django.core.management.base import BaseCommand, CommandError


def get_access_token():
    base_url = getattr(settings, "PAYPAL_BASE_URL", "https://api-m.sandbox.paypal.com")
    client_id = getattr(settings, "PAYPAL_CLIENT_ID", None)
    client_secret = getattr(settings, "PAYPAL_CLIENT_SECRET", None)

    if not client_id or not client_secret:
        raise CommandError("PAYPAL_CLIENT_ID and PAYPAL_CLIENT_SECRET must be set in settings.py")

    resp = requests.post(
        f"{base_url}/v1/oauth2/token",
        headers={"Accept": "application/json"},
        data={"grant_type": "client_credentials"},
        auth=(client_id, client_secret),
    )
    try:
        resp.raise_for_status()
    except requests.HTTPError as e:
        raise CommandError(f"Failed to get PayPal access token: {e} - {resp.text}")

    data = resp.json()
    return data["access_token"]


def find_existing_product(access_token, name):
    """
    Try to find an existing product with the same name to avoid duplicates.
    Returns product_id or None.
    """
    base_url = getattr(settings, "PAYPAL_BASE_URL", "https://api-m.sandbox.paypal.com")

    resp = requests.get(
        f"{base_url}/v1/catalogs/products?page_size=50",
        headers={
            "Content-Type": "application/json",
            "Authorization": f"Bearer {access_token}",
        },
    )
    if resp.status_code != 200:
        return None

    data = resp.json()
    for p in data.get("products", []):
        if p.get("name") == name:
            return p.get("id")
    return None


def create_product(access_token, name, description=None, product_type="SERVICE"):
    base_url = getattr(settings, "PAYPAL_BASE_URL", "https://api-m.sandbox.paypal.com")

    payload = {
        "name": name,
        "type": product_type,
    }
    if description:
        payload["description"] = description

    resp = requests.post(
        f"{base_url}/v1/catalogs/products",
        headers={
            "Content-Type": "application/json",
            "Authorization": f"Bearer {access_token}",
        },
        json=payload,
    )

    try:
        resp.raise_for_status()
    except requests.HTTPError as e:
        raise CommandError(f"Failed to create product: {e} - {resp.text}")

    data = resp.json()
    return data["id"]


def create_plan(
    access_token,
    product_id,
    name,
    price_value,
    currency_code,
    interval_unit,
    interval_count,
):
    base_url = getattr(settings, "PAYPAL_BASE_URL", "https://api-m.sandbox.paypal.com")

    payload = {
        "product_id": product_id,
        "name": name,
        "billing_cycles": [
            {
                "frequency": {
                    "interval_unit": interval_unit,  # e.g. "MONTH"
                    "interval_count": interval_count,  # e.g. 1
                },
                "tenure_type": "REGULAR",
                "sequence": 1,
                "total_cycles": 0,  # 0 = infinite until cancelled
                "pricing_scheme": {
                    "fixed_price": {
                        "value": f"{price_value:.2f}",
                        "currency_code": currency_code,
                    }
                },
            }
        ],
        "payment_preferences": {
            "auto_bill_outstanding": True,
            "setup_fee_failure_action": "CANCEL",
            "payment_failure_threshold": 3,
        },
    }

    resp = requests.post(
        f"{base_url}/v1/billing/plans",
        headers={
            "Content-Type": "application/json",
            "Authorization": f"Bearer {access_token}",
        },
        json=payload,
    )

    try:
        resp.raise_for_status()
    except requests.HTTPError as e:
        raise CommandError(f"Failed to create plan: {e} - {resp.text}")

    data = resp.json()
    return data["id"]


class Command(BaseCommand):
    help = "Create (or reuse) a PayPal Product & Plan for recurring subscriptions."

    def add_arguments(self, parser):
        parser.add_argument(
            "--product-name",
            default="Basic Membership",
            help="PayPal Product name.",
        )
        parser.add_argument(
            "--product-description",
            default="Basic membership subscription",
            help="PayPal Product description.",
        )
        parser.add_argument(
            "--plan-name",
            default="Basic Monthly Plan",
            help="PayPal Plan name.",
        )
        parser.add_argument(
            "--price",
            type=float,
            default=1.0,  # default to $1
            help="Recurring price (e.g. 1.0 for $1/month).",
        )
        parser.add_argument(
            "--currency",
            default="USD",
            help="Currency code (e.g. USD).",
        )
        parser.add_argument(
            "--interval-unit",
            default="MONTH",
            choices=["DAY", "WEEK", "MONTH", "YEAR"],
            help="Billing interval unit (e.g. MONTH).",
        )
        parser.add_argument(
            "--interval-count",
            type=int,
            default=1,
            help="Billing interval count (e.g. 1 for every month).",
        )
        parser.add_argument(
            "--reuse-product",
            action="store_true",
            help="If set, will reuse an existing product with the same name if found.",
        )

    def handle(self, *args, **options):
        product_name = options["product_name"]
        product_description = options["product_description"]
        plan_name = options["plan_name"]
        price = options["price"]
        currency = options["currency"]
        interval_unit = options["interval_unit"]
        interval_count = options["interval_count"]
        reuse_product = options["reuse_product"]

        self.stdout.write(self.style.NOTICE("Getting PayPal access token..."))
        access_token = get_access_token()

        # Product
        product_id = None
        if reuse_product:
            self.stdout.write(self.style.NOTICE(f"Searching for existing product '{product_name}'..."))
            product_id = find_existing_product(access_token, product_name)
            if product_id:
                self.stdout.write(self.style.SUCCESS(f"Found existing product: {product_id}"))

        if not product_id:
            self.stdout.write(self.style.NOTICE(f"Creating product '{product_name}'..."))
            product_id = create_product(
                access_token,
                name=product_name,
                description=product_description,
            )
            self.stdout.write(self.style.SUCCESS(f"Created product: {product_id}"))

        # Plan
        self.stdout.write(self.style.NOTICE(
            f"Creating plan '{plan_name}' for {price:.2f} {currency} every {interval_count} {interval_unit}(s)..."
        ))
        plan_id = create_plan(
            access_token=access_token,
            product_id=product_id,
            name=plan_name,
            price_value=price,
            currency_code=currency,
            interval_unit=interval_unit,
            interval_count=interval_count,
        )

        self.stdout.write(self.style.SUCCESS("Done!"))
        self.stdout.write(self.style.SUCCESS(f"Product ID: {product_id}"))
        self.stdout.write(self.style.SUCCESS(f"Plan ID:    {plan_id}"))
        self.stdout.write("")
        self.stdout.write("➡ Copy this plan_id into your Django settings or template:")
        self.stdout.write(f"   PAYPAL_SUBSCRIPTION_PLAN_ID = '{plan_id}'")