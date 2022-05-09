from rest_framework import serializers
from home.models import Contact, QuemSomos, Recipient

class QuemSomosSerializer(serializers.ModelSerializer):
    class Meta:
        model = QuemSomos
        fields = '__all__'

class ContactSerializer(serializers.ModelSerializer):
    class Meta:
        model = Contact
        fields = '__all__'

class RecipientSerializer(serializers.ModelSerializer):
    class Meta:
        model = Recipient
        fields = '__all__'