from django.shortcuts import render
from django.http import Http404, HttpResponse
from django.shortcuts import redirect

from tools.executeapi import executeapi
#from .models import Pet, Specie, Breed, Color, Coat

# Create your views here.
def animal_index(request):
	try:
		response = executeapi("animal/petssel", "get", {"available": "true", "ordering": "-created_at"}, None, None)
		if response['status'] == 200:
			pets = response['data']

			for pet in pets:
				if pet["photo"]:
					pet["photo"] = pet["photo"].replace("http://loadbalancer", "http://localhost:5000")
		else:
			pets = []
	except:
		pets = []

	return render(request, 'animal/index.html', { 'pets': pets })

def animal_detail(request, pk):
	try:
		response = executeapi("animal/petssel/%s" % (pk), "get", None, None, None)
		if response['status'] == 200:
			pet = response['data']
			if pet["photo"]:
				pet["photo"] = pet["photo"].replace("http://loadbalancer", "http://localhost:5000")
		else:
			return redirect('/animais')
	except:
		return redirect('/animais')

	return render(request, 'animal/detail.html', { 'pet': pet })