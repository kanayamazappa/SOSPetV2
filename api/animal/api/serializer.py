from rest_framework import serializers
from animal.models import Breed, Coat, Color, Interest, Pet, Specie
from login.api.serializer import LoginSerializer

class SpecieSerializer(serializers.ModelSerializer):
    class Meta:
        model = Specie
        fields = '__all__'

class BreedSerializer(serializers.ModelSerializer):
    class Meta:
        model = Breed
        fields = '__all__'

class ColorSerializer(serializers.ModelSerializer):
    class Meta:
        model = Color
        fields = '__all__'

class CoatSerializer(serializers.ModelSerializer):
    class Meta:
        model = Coat
        fields = '__all__'

class PetSerializer(serializers.ModelSerializer):

    class Meta:
        model = Pet
        fields = '__all__'

class PetSelSerializer(serializers.ModelSerializer):
    login = LoginSerializer(many=False, read_only=True)
    coat = CoatSerializer(many=False, read_only=True)
    specie = SpecieSerializer(many=False, read_only=True)
    breed = BreedSerializer(many=False, read_only=True)
    color = ColorSerializer(many=False, read_only=True)

    class Meta:
        model = Pet
        fields = '__all__'

class InterestSerializer(serializers.ModelSerializer):
    #login = LoginSerializer(many=False)
    #pet = PetSerializer(many=False)

    class Meta:
        model = Interest
        fields = '__all__'