from django.db import models
from login.models import Login
import os

# Create your models here.
class Specie(models.Model):
    name = models.CharField(verbose_name=u"Espécie", max_length=150, help_text=u"Espécie do animal de estimação")
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = u'Espécie'
        verbose_name_plural = u'Espécies'

class Breed(models.Model):
    specie = models.ForeignKey(Specie, on_delete=models.CASCADE)
    name = models.CharField(verbose_name=u"Raça", max_length=150, help_text=u"Raça do animal de estimação")
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = u'Raça'
        verbose_name_plural = u'Raças'

class Color(models.Model):
    name = models.CharField(verbose_name=u"Cor", max_length=150, help_text=u"Cor do animal de estimação")
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = u'Cor'
        verbose_name_plural = u'Cores'

class Coat(models.Model):
    name = models.CharField(verbose_name=u"Pelagem", max_length=150, help_text=u"Pelagem do animal de estimação")
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = u'Pelagem'
        verbose_name_plural = u'Pelagens'


def content_file_name(instance, filename):
    ext = filename.split('.')[-1]
    filename = '%s.%s' % (instance.id, ext)
    return os.path.join('animais', filename)

class Pet(models.Model):
    GENRE_CHOICES = [("M", u"Macho"), ("F", u"Femêa")]
    login = models.ForeignKey(Login, on_delete=models.CASCADE)
    name = models.CharField(verbose_name=u"Nome", max_length=150, help_text=u"Nome do animal de estimação")
    genre = models.CharField(verbose_name=u"Sexo", choices=GENRE_CHOICES, max_length=1)
    microship = models.CharField(verbose_name=u"Microchip", max_length=150, help_text=u"Microchip do animal de estimação", blank=True)
    age = models.PositiveSmallIntegerField(verbose_name=u"Idade", help_text=u"Idade do animal de estimação")
    specie = models.ForeignKey(Specie, on_delete=models.CASCADE, verbose_name=u"Espécie")
    breed = models.ForeignKey(Breed, on_delete=models.CASCADE, verbose_name=u"Raça")
    castrated = models.BooleanField(verbose_name=u"Castrado", default=False, help_text=u"Animal de estimação é castrado?")
    color = models.ForeignKey(Color, on_delete=models.CASCADE, blank=True, null=True, verbose_name=u"Cor")
    coat = models.ForeignKey(Coat, on_delete=models.CASCADE, blank=True, null=True, verbose_name=u"Pelagem")
    weight = models.PositiveSmallIntegerField(verbose_name=u"Peso", help_text=u"Peso do animal de estimação", blank=True)
    height = models.PositiveSmallIntegerField(verbose_name=u"Altura", help_text=u"Altura do animal de estimação (cm)", blank=True)
    personality = models.CharField(verbose_name=u"Personalidade", max_length=150, help_text=u"Personalidade do animal de estimação", blank=True)
    vaccination = models.CharField(verbose_name=u"Vacinação", max_length=150, help_text=u"Vacinação do animal de estimação", blank=True)
    available = models.BooleanField(verbose_name=u"Disponível", default=1, help_text=u"Animal de estimação disponível para adoção?")
    photo = models.ImageField(verbose_name=u"Foto", upload_to=content_file_name, height_field=None, width_field=None, max_length=100, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = u'Animal'
        verbose_name_plural = u'Animais'


class Interest(models.Model):
    CONFIRM_CHOICES = [("I", u"Aguardando adoção"), ("N", u"Negar adoção"), ("A", u"Aceitar adoção")]
    pet = models.ForeignKey(Pet, on_delete=models.CASCADE)
    login = models.ForeignKey(Login, on_delete=models.CASCADE)
    confirm = models.CharField(verbose_name=u"Confirmação", choices=CONFIRM_CHOICES, max_length=1, default='I', help_text=u"Confirmação de doação")
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.pet