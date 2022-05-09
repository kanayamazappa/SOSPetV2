from django.db import models

# Create your models here.
class Clinic(models.Model):
    name = models.CharField(verbose_name=u"Nome", max_length=150)
    phone = models.CharField(verbose_name=u"Telefone", max_length=20)
    email = models.EmailField(verbose_name=u"E-mail")
    adress = models.TextField(verbose_name=u"Endereço")
    officeHours = models.TextField(verbose_name=u"Horário de Atendimento")

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = u'Clínica'
        verbose_name_plural = u'Clínicas'