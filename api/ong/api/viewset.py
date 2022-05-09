from rest_framework import viewsets
from ong.api.serializer import OngSerializer
from ong.models import Ong
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import filters

class OngViewSet(viewsets.ModelViewSet):
    queryset = Ong.objects.all()
    serializer_class = OngSerializer
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['city', 'state', 'zipCode', 'bank', 'active']
    search_fields = ['name', 'fantasia', ]
    ordering_fields = ['id', 'name', 'created_at']