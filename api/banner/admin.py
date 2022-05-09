from django.contrib import admin
from adminsortable2.admin import SortableAdminMixin
from imagekit.admin import AdminThumbnail
from imagekit import ImageSpec
from imagekit.processors import ResizeToFill
from imagekit.cachefiles import ImageCacheFile
from . import models

class AdminThumbnailSpec(ImageSpec):
    processors = [ResizeToFill(150, 60)]
    format = 'JPEG'
    options = {'quality': 60 }

def cached_admin_thumb(instance):
    # `image` is the name of the image field on the model
    cached = ImageCacheFile(AdminThumbnailSpec(instance.banner))
    # only generates the first time, subsequent calls use cache
    cached.generate()
    return cached

# Register your models here.
@admin.register(models.Banner)
class BannerAdmin(SortableAdminMixin, admin.ModelAdmin):
    model = models.Banner
    fields = ('title', 'link', 'banner', 'active',)
    banner_display = AdminThumbnail(image_field=cached_admin_thumb)
    banner_display.short_description = 'Imagem'

    list_display = ['sort_order', 'title', 'active', 'banner_display']
    list_display_links = ['sort_order', 'title']