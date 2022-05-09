from django import forms
from django.contrib import admin
from ckeditor.widgets import CKEditorWidget
from . import models

# Register your models here.
class QuemSomosAdminForm(forms.ModelForm):
    content = forms.CharField(widget=CKEditorWidget())
    class Meta:
        model = models.QuemSomos
        fields = '__all__'

class QuemSomosAdmin(admin.ModelAdmin):
    form = QuemSomosAdminForm

    # This will help you to disbale add functionality
    def has_add_permission(self, request):
        return False

    # This will help you to disable delete functionaliyt
    def has_delete_permission(self, request, obj=None):
        return False

admin.site.register(models.QuemSomos, QuemSomosAdmin)

class ContactAdmForm(forms.ModelForm):
    message = forms.CharField(widget=CKEditorWidget())
    class Meta:
        model = models.Contact
        fields = '__all__'

class ContactAdm(admin.ModelAdmin):
    form = ContactAdmForm
    list_display = ['name', 'email', 'subject', 'created_at']

    # This will help you to disbale add functionality
    def has_add_permission(self, request):
        return False

    # This will help you to disable delete functionaliyt
    def has_delete_permission(self, request, obj=None):
        return False

    # This will help you to disable change functionality
    def has_change_permission(self, request, obj=None):
        return False

admin.site.register(models.Contact, ContactAdm)

@admin.register(models.Recipient)
class RecipientAdmin(admin.ModelAdmin):
    model = models.Recipient