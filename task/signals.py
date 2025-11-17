# signals.py
from django.db.models.signals import post_save
from django.dispatch import receiver
from django.contrib.auth.models import User
from .models import Profile

@receiver(post_save, sender=User)
def handle_user_post_save(sender, instance, created, **kwargs):
    # 1️⃣ Create Profile when new user is created
    if created:
        Profile.objects.get_or_create(user=instance)

        # 2️⃣ Deactivate user upon registration (but don't trigger recursion)
        if instance.is_active and not instance.is_superuser:
            User.objects.filter(pk=instance.pk).update(is_active=False)

    # 3️⃣ Keep Profile updated for existing users
    else:
        if hasattr(instance, "profile"):
            instance.profile.save()


@receiver(post_save, sender=User)
def remind_superuser_phone(sender, instance, created, **kwargs):
    # Optional: warn if superuser missing phone
    if created and instance.is_superuser:
        profile, _ = Profile.objects.get_or_create(user=instance)
        if not profile.phone:
            print("\n⚠️  Remember to set a phone number for this superuser!\n")


# @receiver(post_save, sender=User)
# def create_or_update_user_profile(sender, instance, created, **kwargs):
#     if created:
#         Profile.objects.create(user=instance)
#     else:
#         instance.profile.save()

# # alter warning 
# @receiver(post_save, sender=User)
# def create_profile_for_superuser(sender, instance, created, **kwargs):
#     if created and instance.is_superuser:
#         Profile.objects.get_or_create(user=instance)
#         if not instance.profile.phone:
#             print("\n⚠️  Remember to set a phone number for this superuser!\n")
