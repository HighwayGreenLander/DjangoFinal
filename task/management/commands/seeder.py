from django.core.management.base import BaseCommand
from task.models import Task, Category, Tag
from django.utils import timezone
from random import choice, sample, randint
from datetime import timedelta
import faker

fake = faker.Faker()

class Command(BaseCommand):
    help = 'Generate dummy Task data'

    def handle(self, *args, **kwargs):
        categories = list(Category.objects.all())
        tags = list(Tag.objects.all())

        if not categories or not tags:
            self.stdout.write(self.style.ERROR('Please add Category and Tag fixtures first.'))
            return

        for i in range(50):  # create 50 dummy tasks
            created_date = timezone.now()
            # Ensure due_date >= created_date.date()
            due_date = created_date.date() + timedelta(days=randint(0, 30))

            task = Task.objects.create(
                name=fake.sentence(nb_words=5),
                # note=fake.text(max_nb_chars=200),
                due_date=due_date,
                created_date=created_date,
                category=choice(categories)
            )

            # Assign 1–3 random tags
            task.tag.set(sample(tags, k=choice([1, 2, 3])))

        self.stdout.write(self.style.SUCCESS('✅ Successfully generated 50 dummy tasks.'))
