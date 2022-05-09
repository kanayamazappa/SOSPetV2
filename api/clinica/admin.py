from django.contrib import admin
from . import models

# Register your models here.
@admin.register(models.Clinic)
class ClinicAdmin(admin.ModelAdmin):
    model = models.Clinic
    list_display = ['name', 'phone', 'email']
    list_display_links = ['name', 'phone']

    def __name__(self):
        return "Clínica"