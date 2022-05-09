from rest_framework import serializers
from login.models import Address, Document, Login, Telephone

class LoginSerializer(serializers.ModelSerializer):
    class Meta:
        model = Login
        fields = '__all__'

class AddressSerializer(serializers.ModelSerializer):
    class Meta:
        model = Address
        fields = '__all__'

class DocumentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Document
        fields = '__all__'

class TelephoneSerializer(serializers.ModelSerializer):
    class Meta:
        model = Telephone
        fields = '__all__'