from django.contrib import admin
from . import models

# Register your models here.
@admin.register(models.Ong)
class OngAdmin(admin.ModelAdmin):
    model = models.Ong
    list_display = ['name', 'email', 'telephone', 'state', 'city', 'street', 'number', 'complement']
    list_display_links = ['name', 'email']