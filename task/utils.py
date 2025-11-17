import requests
from django.conf import settings

def send_telegram_message(message):
    """Send a message to your Telegram bot"""
    token = settings.TELEGRAM_BOT_TOKEN
    chat_id = settings.TELEGRAM_CHAT_ID
    url = f"https://api.telegram.org/bot{token}/sendMessage"
    payload = {"chat_id": chat_id, "text": message}
    try:
        requests.post(url, data=payload, timeout=5)
    except Exception as e:
        print("Telegram send failed:", e)
