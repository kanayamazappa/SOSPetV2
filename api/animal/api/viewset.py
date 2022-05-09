from rest_framework import viewsets
from animal.api.serializer import BreedSerializer, CoatSerializer, ColorSerializer, InterestSerializer, PetSelSerializer, PetSerializer, SpecieSerializer
from animal.models import Breed, Coat, Color, Interest, Pet, Specie
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import filters

class SpecieViewSet(viewsets.ModelViewSet):
    queryset = Specie.objects.all()
    serializer_class = SpecieSerializer
    filter_backends = [filters.SearchFilter, filters.OrderingFilter]
    search_fields = ['name']
    ordering_fields = ['id', 'name']

class BreedViewSet(viewsets.ModelViewSet):
    queryset = Breed.objects.all()
    serializer_class = BreedSerializer
    filter_backends = [filters.SearchFilter, filters.OrderingFilter]
    search_fields = ['name']
    ordering_fields = ['id', 'name']

class ColorViewSet(viewsets.ModelViewSet):
    queryset = Color.objects.all()
    serializer_class = ColorSerializer
    filter_backends = [filters.SearchFilter, filters.OrderingFilter]
    search_fields = ['name']
    ordering_fields = ['id', 'name']

class InterestViewSet(viewsets.ModelViewSet):
    queryset = Interest.objects.all()
    serializer_class = InterestSerializer
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['confirm', 'pet', 'login']
    search_fields = ['pet__name', 'login__name']
    ordering_fields = ['id', 'confirm']

class CoatViewSet(viewsets.ModelViewSet):
    queryset = Coat.objects.all()
    serializer_class = CoatSerializer
    filter_backends = [filters.SearchFilter, filters.OrderingFilter]
    search_fields = ['name']
    ordering_fields = ['id', 'name']

class PetViewSet(viewsets.ModelViewSet):
    queryset = Pet.objects.all()
    serializer_class = PetSerializer
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['genre', 'specie', 'breed', 'color', 'coat', 'available', 'login']
    search_fields = ['name']
    ordering_fields = ['id', 'name', 'created_at']

class PetSelViewSet(viewsets.ModelViewSet):
    queryset = Pet.objects.all()
    serializer_class = PetSelSerializer
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['genre', 'specie', 'breed', 'color', 'coat', 'available', 'login']
    search_fields = ['name']
    ordering_fields = ['id', 'name', 'created_at']