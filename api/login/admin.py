from django.contrib import admin
from . import models

# Register your models here.
class AddressInline(admin.TabularInline):
    model = models.Address

class DocumentInline(admin.TabularInline):
    model = models.Document

class TelephoneInline(admin.TabularInline):
    model = models.Telephone

@admin.register(models.Login)
class LoginAdmin(admin.ModelAdmin):
    model = models.Login
    list_display = ['name', 'email',]
    list_display_links = ['name', 'email']

    inlines = [
        AddressInline,
        DocumentInline,
        TelephoneInline
    ]

    # This will help you to disbale add functionality
    def has_add_permission(self, request):
        return False

    # This will help you to disable delete functionaliyt
    def has_delete_permission(self, request, obj=None):
        return False

    # This will help you to disable change functionality
    def has_change_permission(self, request, obj=None):
        return False