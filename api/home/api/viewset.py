from rest_framework import viewsets
from home.api.serializer import ContactSerializer, QuemSomosSerializer, RecipientSerializer
from home.models import Contact, QuemSomos, Recipient

class QuemSomosViewSet(viewsets.ModelViewSet):
    queryset = QuemSomos.objects.all()
    serializer_class = QuemSomosSerializer

class ContactViewSet(viewsets.ModelViewSet):
    queryset = Contact.objects.all()
    serializer_class = ContactSerializer

class RecipientViewSet(viewsets.ModelViewSet):
    queryset = Recipient.objects.all()
    serializer_class = RecipientSerializer