from rest_framework import viewsets
from clinica.api.serializer import ClinicSerializer
from clinica.models import Clinic

class ClinicViewSet(viewsets.ModelViewSet):
    queryset = Clinic.objects.all()
    serializer_class = ClinicSerializer