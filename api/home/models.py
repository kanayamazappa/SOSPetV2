from django.db import models
from ckeditor_uploader.fields import RichTextUploadingField

# Create your models here.
class QuemSomos(models.Model):
    content = RichTextUploadingField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return u'Quem Somos'

    class Meta:
        verbose_name = u'Quem Somos'
        verbose_name_plural = u'Quem Somos'

class Contact(models.Model):
    name = models.CharField(verbose_name=u"Nome", max_length=150)
    email = models.EmailField(verbose_name=u"E-mail")
    subject = models.CharField(verbose_name=u"Assunto", max_length=150)
    message = RichTextUploadingField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = u'Contato'
        verbose_name_plural = u'Contatos'

class Recipient(models.Model):
    email = models.EmailField(verbose_name=u"E-mail")
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.email

    class Meta:
        verbose_name = u'Destinatário'
        verbose_name_plural = u'Destinatário'