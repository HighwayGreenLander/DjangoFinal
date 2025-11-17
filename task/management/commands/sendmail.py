# your_app/management/commands/seedermail.py

from django.core.management.base import BaseCommand
from django.core.mail import send_mail
from django.conf import settings

class Command(BaseCommand):
    help = 'Send a test (seed) email to verify SMTP configuration'

    def add_arguments(self, parser):
        parser.add_argument(
            '--to',
            type=str,
            default=settings.EMAIL_HOST_USER,
            help='Email address to send the test mail to'
        )

    def handle(self, *args, **options):
        recipient = options['to']
        subject = "Django SeederMail Test"
        message = (
            "Hello!\n\n"
            "This is a test email sent using Django and Gmail SMTP.\n"
            "If you received this, your email setup works fine!\n\n"
            "— Django Mail System"
        )
        

        self.stdout.write(self.style.NOTICE(f"Sending test email to {recipient}..."))

        try:
            send_mail(
                subject=subject,
                message=message,
                from_email=settings.DEFAULT_FROM_EMAIL,
                recipient_list=[recipient],
                fail_silently=False,
            )
            self.stdout.write(self.style.SUCCESS(f"✅ Email successfully sent to {recipient}!"))
        except Exception as e:
            self.stdout.write(self.style.ERROR(f"❌ Failed to send email: {e}"))
