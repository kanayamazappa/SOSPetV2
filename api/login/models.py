from django.db import models

# Create your models here.
class Login(models.Model):
    name = models.CharField(verbose_name=u"Nome", max_length=150)
    email = models.EmailField(verbose_name=u"E-mail")
    password = models.CharField(verbose_name=u"Senha", max_length=1024)
    active = models.BooleanField(verbose_name=u"Ativo?", default=False)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name

    class Meta:
        index_together = [['email', 'active']]
        verbose_name = u'Usuário'
        verbose_name_plural = u'Usuários'

class Address(models.Model):
    login = models.ForeignKey(Login, on_delete=models.CASCADE)
    type = models.CharField(verbose_name=u"Tipo do Endereço", choices=[("C", u"Comercial"), ("R", u"Residencial")], max_length=1)
    street = models.CharField(verbose_name=u"Logradouro", max_length=150)
    number = models.CharField(verbose_name=u"Número", max_length=20)
    complement = models.CharField(verbose_name=u"Complemento", max_length=250, blank=True)
    district = models.CharField(verbose_name=u"Bairro", max_length=150)
    city = models.CharField(verbose_name=u"Cidade", max_length=150)
    state = models.CharField(verbose_name=u"Estado", max_length=2)
    zipCode = models.CharField(verbose_name=u"CEP", max_length=10)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.street

class Document(models.Model):
    login = models.ForeignKey(Login, on_delete=models.CASCADE)
    type = models.CharField(verbose_name=u"Tipo do Documento", choices=[("C", u"CPF"), ("R", u"RG")], max_length=1)
    document = models.CharField(verbose_name=u"Número", max_length=20)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.document
        

class Telephone(models.Model):
    login = models.ForeignKey(Login, on_delete=models.CASCADE)
    type = models.CharField(verbose_name=u"Tipo do Telefone", choices=[("C", u"Comercial"), ("R", u"Residencial")], max_length=1)
    phone = models.CharField(verbose_name=u"Número", max_length=20)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.phone