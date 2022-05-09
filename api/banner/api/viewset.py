from rest_framework import viewsets
from banner.api.serializer import BannerSerializer
from banner.models import Banner
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import filters

class BannerViewSet(viewsets.ModelViewSet):
    queryset = Banner.objects.all()
    serializer_class = BannerSerializer
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['active',]
    search_fields = ['title', 'link', 'banner']
    ordering_fields = ['id', 'created_at', 'sort_order']