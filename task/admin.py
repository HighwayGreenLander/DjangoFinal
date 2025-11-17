from django.contrib import admin
from .models import Task, Category, Tag, Profile
from datetime import datetime
from django.utils import timezone
# Register your models here.

# admin.site.register(Category)
@admin.register(Category)
class CategoryModel(admin.ModelAdmin):
    list_display = ['id','name', 'hex_color' ,'total_task']
    def total_task(self, obj) :
        return obj.tasks.count()
    total_task.short_description = 'Tasks'
    
# admin.site.register(Tag)
@admin.register(Tag)
class TagModel(admin.ModelAdmin):
    list_display = ['id','label','total_tags']
    
    def total_tags(self, obj) :
        return obj.tasks.count()
    total_tags.short_description = 'Tags'
    
   
#admin.site.register(Task)   
@admin.register(Task)
class TaskModel(admin.ModelAdmin):
    list_display = ['id','name','created_date', 'due_date','status','category','tag_list']
    # list_editable = ['Category']
    
    search_fields = ['name' ]
    
    def tag_list (self,task):
        all_tags=task.tag.all()
        tag_display=[]
        for item in all_tags:
            tag_display.append(item.label)
        return tag_display
    #     return ", ".join([tag.label for tag in task.tag.all()])
    # get_tags.short_description = 'Tag List'
    def status(self,obj_task):
        if obj_task.due_date < timezone.now().date():
            return "Late"
        else:
            return "On Going"
admin.site.register(Profile)