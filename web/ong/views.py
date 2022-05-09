from django.shortcuts import render
from django.http import Http404, HttpResponse
from django.shortcuts import redirect
from tools.executeapi import executeapi

# Create your views here.
def ong_index(request):
	try:
		response = executeapi("ong", "get", {"ordering": "-created_at"}, None, None)
		if response['status'] == 200:
			ongs = response['data']
		else:
			ongs = []
	except:
		ongs = []

	return render(request, 'ong/index.html', { 'ongs': ongs })

def ong_detail(request, pk):
	try:
		response = executeapi("ong/%s" % (pk), "get", None, None, None)
		if response['status'] == 200:
			ong = response['data']
		else:
			ong = {}
	except:
		return redirect('/ongs')

	return render(request, 'ong/detail.html', { 'ong': ong })