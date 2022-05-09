from django.db import models
from imagekit.models import ProcessedImageField
from imagekit.processors import ResizeToFill

# Create your models here.
class Banner(models.Model):
    class Meta:
        ordering = ('sort_order',)
    
    title = models.CharField(verbose_name=u"Título", max_length=100, null=False, blank=False, help_text=u"Título do banner")
    link = models.URLField(verbose_name="Link", blank=True)
    banner = ProcessedImageField(verbose_name=u"Banner", upload_to="banners", processors=[ResizeToFill(960, 428)], format='JPEG', options={'quality': 60}, help_text=u"Imagem do banner da home")
    sort_order = models.PositiveIntegerField(verbose_name=u"Ordem", default=0)
    active = models.BooleanField(verbose_name=u"Ativo", default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.title