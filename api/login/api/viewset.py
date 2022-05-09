from rest_framework import viewsets
from login.api.serializer import AddressSerializer, DocumentSerializer, LoginSerializer, TelephoneSerializer
from login.models import Address, Document, Login, Telephone
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import filters

class AddressViewSet(viewsets.ModelViewSet):
    queryset = Address.objects.all()
    serializer_class = AddressSerializer
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['login', 'type']
    search_fields = ['login_name', 'login_email']
    ordering_fields = ['id', 'created_at']

class DocumentViewSet(viewsets.ModelViewSet):
    queryset = Document.objects.all()
    serializer_class = DocumentSerializer
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['login', 'type']
    search_fields = ['login_name', 'login_email']
    ordering_fields = ['id', 'created_at']

class TelephoneViewSet(viewsets.ModelViewSet):
    queryset = Telephone.objects.all()
    serializer_class = TelephoneSerializer
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['login', 'type']
    search_fields = ['login_name', 'login_email']
    ordering_fields = ['id', 'created_at']

class LoginViewSet(viewsets.ModelViewSet):
    queryset = Login.objects.all()
    serializer_class = LoginSerializer
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['active','email','password']
    search_fields = ['name']
    ordering_fields = ['id', 'created_at']