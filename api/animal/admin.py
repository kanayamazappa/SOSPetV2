from django.contrib import admin
from . import models

# Register your models here.
@admin.register(models.Specie)
class SpecieAdmin(admin.ModelAdmin):
    model = models.Specie
    list_display = ['name']
    list_display_links = ['name',]

@admin.register(models.Breed)
class BreedAdmin(admin.ModelAdmin):
    model = models.Breed
    list_display = ['name', 'specie']
    list_display_links = ['name',]

@admin.register(models.Color)
class ColorAdmin(admin.ModelAdmin):
    model = models.Color
    list_display = ['name']
    list_display_links = ['name',]

@admin.register(models.Coat)
class CoatAdmin(admin.ModelAdmin):
    model = models.Coat
    list_display = ['name']
    list_display_links = ['name',]

class InterestInline(admin.TabularInline):
    model = models.Interest

@admin.register(models.Pet)
class PetAdmin(admin.ModelAdmin):
    model = models.Pet
    list_display = ['name', 'specie', 'breed']
    list_display_links = ['name',]

    # inlines = [
    #     InterestInline,
    # ]

    # This will help you to disbale add functionality
    # def has_add_permission(self, request):
    #     return False

    # This will help you to disable delete functionaliyt
    # def has_delete_permission(self, request, obj=None):
    #     return False

    # This will help you to disable change functionality
    # def has_change_permission(self, request, obj=None):
    #     return False