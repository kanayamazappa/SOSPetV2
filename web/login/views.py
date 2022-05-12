import json
from django.shortcuts import render
from django.http import Http404, HttpResponse
from django.shortcuts import redirect
from django.core.mail import send_mail
from cryptography.fernet import Fernet
from datetime import datetime, timedelta
from django.conf import settings

from tools.executeapi import executeapi

# Create your views here.
key = 'zxroME6Q35lvbcOvOqpD8pu1B6d0ZTpbW2mmFt5FwNM='

def login_index(request):
	return render(request, 'login/index.html', { })

def login_esqueci(request):
	return render(request, 'login/esqueci-senha.html', { })

def login_esqueci_ajax(request):
	if request.is_ajax() and request.POST:
		email = request.POST.get('email')

		response = executeapi("login/users", "get", {"email": email}, None, None)
		if response['status'] == 200:
			login = response['data'][0]
		else:
			login = []
			
		data = {'success': False}
		if login != None:
			message = "Olá %s, sua senha é: %s" % (login['name'], login['password'])
			send_mail("SOS Pet - Recuperação de senha", message, "SOS Pet<%s>" % (settings.EMAIL_HOST_USER), [login['email']])
			data = {'success': True, 'email': login['email']}

		return HttpResponse(json.dumps(data), content_type='application/json')

def login_cadastro(request):
	return render(request, 'login/cadastro.html', { })

def login_cadastro_ajax(request):
	if request.is_ajax() and request.POST:
		name = request.POST.get('name')
		email = request.POST.get('email')
		password = request.POST.get('password')
		confirm = request.POST.get('confirm')
		cpf = request.POST.get('cpf')
		phone = request.POST.get('phone')
		zipCode = request.POST.get('zipCode')
		street = request.POST.get('street')
		number = request.POST.get('number')
		complement = request.POST.get('complement')
		district = request.POST.get('district')
		city = request.POST.get('city')
		state = request.POST.get('state')

		if password != confirm:
			return HttpResponse(json.dumps({'success': False, 'message': 'Sua senha e a confirmação não coincidem!'}), content_type='application/json')

		logins = []
		response = executeapi("login/users", "get", {"email": email, "active": "true"}, None, None)
		if response['status'] == 200:
			if len(response['data']) > 0:
				logins = response['data']
		
		if len(logins) > 0:
			return HttpResponse(json.dumps({'success': False, 'message': 'Já existe um cadastro com este e-mail!'}), content_type='application/json')

		# Removendo cadastro com mesmo e-mail inativos
		try:
			logins2 = []
			response = executeapi("login/users", "get", {"email": email, "active": "false"}, None, None)
			if response['status'] == 200 and len(response['data']) > 0:
				logins2 = response['data']
			
			if len(logins2) > 0:
				for item in logins2:
					response = executeapi("login/users/%s" % (item['id']), "delete", None, None, None)
		except:
			pass
		
		login = None
		response = executeapi("login/users", "post", None, None, {"name": name,"email": email,"password": password,"active": False})
		if response['status'] == 201:
			login = response['data']
		
		data = {'success': False, 'message': 'Não foi possível realizar seu cadastro!'}
		if login != None:

			executeapi("login/documents", "post", None, None, {"type": "C", "document": cpf, "login": login["id"]})
			executeapi("login/phones", "post", None, None, {"type": "R", "phone": phone, "login": login["id"]})
			executeapi("login/address", "post", None, None, {"type": "R", "street": street, "number": number, "complement": complement, "district": district, "city": city, "state": state, "zipCode": zipCode, "login": login["id"]})

			request.session['login'] = login['id']

			date_key = datetime.timestamp(datetime.now() + timedelta(hours=1))

			key_active = encrypt('%s|@|%d' % (date_key, login['id']))

			message = 'Olá %s, para ativar sua conta clique <a href="http://%s/login/ativar?key=%s">aqui</a>' % (login['name'], request.get_host(), key_active)

			send_mail("SOS Pet - Ativação de conta", message, "SOS Pet<%s>" % (settings.EMAIL_HOST_USER), [login['email']])

			message = 'Cadastro realizado com sucesso!\n Enviamos o link de ativação da conta no e-mail: %s' % login['email']

			data = {'success': True, 'message': message}

		return HttpResponse(json.dumps(data), content_type='application/json')

def login_editar(request):
	if not check_login(request):
		return redirect('/login')
	login_id = request.session.get('login', 0)
	login = None
	response = executeapi("login/users/%s" % (login_id), "get", None, None, None)
	if response['status'] == 200:
		login = response['data']

	cpf = ''
	response = executeapi("login/documents", "get", {"login": login_id, "type": "C"}, None, None)
	if response['status'] == 200:
		document = response['data'][0]

	if document != None:
		cpf = document['document']

	phone = ''
	response = executeapi("login/phones", "get", {"login": login_id, "type": "R"}, None, None)
	if response['status'] == 200:
		telephone = response['data'][0]

	if telephone != None:
		phone = telephone['phone']

	address = {}
	response = executeapi("login/address", "get", {"login": login_id, "type": "R"}, None, None)
	if response['status'] == 200:
		address = response['data'][0]

	return render(request, 'login/editar.html', { 'login': login, 'cpf': cpf, 'phone': phone, 'address': address })

def login_editar_ajax(request):
	if not check_login(request):
		return redirect('/login')

	if request.is_ajax() and request.POST:
		try:
			name = request.POST.get('name')
			email = request.POST.get('email')
			password = request.POST.get('password')
			confirm = request.POST.get('confirm')
			cpf = request.POST.get('cpf')
			phone = request.POST.get('phone')
			zipCode = request.POST.get('zipCode')
			street = request.POST.get('street')
			number = request.POST.get('number')
			complement = request.POST.get('complement')
			district = request.POST.get('district')
			city = request.POST.get('city')
			state = request.POST.get('state')

			if password != confirm:
				return HttpResponse(json.dumps({'success': False, 'message': 'Sua senha e a confirmação não coincidem!'}), content_type='application/json')

			login_id = request.session.get('login', 0)
			response = executeapi("login/users/%s" % (login_id), "put", None, None, {"id": login_id, "name": name,"email": email,"password": password,"active": False})
			if response['status'] == 200:
				login = response['data']
			else:
				raise
			
			document = None
			response = executeapi("login/documents", "get", {"login": login_id, "type": "C"}, None, None)
			if response['status'] == 200:
				document = response['data'][0]
			
			if document != None:
				document['document'] = cpf
				executeapi("login/documents/%s" % (document['id']), "put", None, None, document)
			else:
				executeapi("login/documents", "post", None, None, {"type": "C", "document": cpf, "login": login_id})

			telephone = None
			response = executeapi("login/phones", "get", {"login": login_id, "type": "R"}, None, None)
			if response['status'] == 200:
				telephone = response['data'][0]
			
			if telephone != None:
				telephone['phone'] = phone
				executeapi("login/phones/%s" % (telephone['id']), "put", None, None, telephone)
			else:
				executeapi("login/phones", "post", None, None, {"type": "R", "phone": phone, "login": login_id})

			address = None
			response = executeapi("login/address", "get", {"login": login_id, "type": "R"}, None, None)
			if response['status'] == 200:
				address = response['data'][0]

			if address != None:
				address['zipCode'] = zipCode
				address['street'] = street
				address['number'] = number
				address['complement'] = complement
				address['district'] = district
				address['city'] = city
				address['state'] = state
				executeapi("login/address/%s" % (address['id']), "put", None, None, address)
			else:
				executeapi("login/address", "post", None, None, {"type": "R", "street": street, "number": number, "complement": complement, "district": district, "city": city, "state": state, "zipCode": zipCode, "login": login_id})

			message = 'Perfil alterado com sucesso!'
			data = {'success': True, 'message': message}
		except:
			message = 'Não foi possível alterar seu perfil!'
			data = {'success': True, 'message': message}

	return HttpResponse(json.dumps(data), content_type='application/json')

def login_active(request):
	key_active = str(decrypt(request.GET.get('key')))
	date_key = ''
	date_now = datetime.now()
	login_id = 0
	success = False
	if key_active.find('|@|'):
		timestamp = float(key_active.split('|@|')[0])
		date_key = datetime.fromtimestamp(timestamp)
		login_id = int(key_active.split('|@|')[1])
		login = None
		response = executeapi("login/users/%s" % (login_id), "get", None, None, None)
		if response['status'] == 200:
			login = response['data']

		if date_now <= date_key:
			if response['status'] == 200:
				login['active'] = True
				executeapi("login/users/%s" % (login_id), "put", None, None, login)
				message = "Cadastro ativado com sucesso!"
				success = True
			else:
				message = "Falha ao ativar o cadastro, token não reconhecido!"
		else:
			date_key = datetime.timestamp(datetime.now() + timedelta(hours=1))
			key_active = encrypt('%s|@|%d' % (date_key, login['id']))
			message = 'Olá %s, para ativar sua conta clique <a href="http://localhost:8000/login/ativar?key=%s">aqui</a>' % (login['name'], key_active)
			send_mail("SOS Pet - Ativação de conta", message, "SOS Pet<%s>" % (settings.EMAIL_HOST_USER), [login['email']])
			message = "Seu link esta expirado, foi enviado um novo e-mail!"
	else:
		message = "Falha ao ativar o cadastro, token não reconhecido!"

	return render(request, 'login/ativar.html', { 'success': success, 'message': message })

def login_logout(request):
	try:
		del request.session['login']
	except:
		pass
	return redirect('/login')

def login_ajax(request):
	if request.is_ajax() and request.POST:
		email = request.POST.get('email')
		password = request.POST.get('password')

		data = {'success': False, 'message': 'Login e/ou senha incorrétos!'}
		try:
			login = None
			response = executeapi("login/users", "get", {"email": email, "password": password}, None, None)
			if response['status'] == 200:
				login = response['data'][0]
			else:
				return HttpResponse(json.dumps(data), content_type='application/json')

			if not login['active']:
				data = {'success': False, 'message': 'Login inátivo, acesse seu e-mail e clique no link para ativar seu cadastro!'}
				return HttpResponse(json.dumps(data), content_type='application/json')

			data = {'success': True}
			request.session['login'] = login['id']
			return HttpResponse(json.dumps(data), content_type='application/json')
		except:
			return HttpResponse(json.dumps(data), content_type='application/json')
	else:
		raise Http404

def login_area(request):
	if not check_login(request):
		return redirect('/login')
	return render(request, 'login/area.html', {})

def login_species(request):
	species = []

	species = request.session.get('species', [])

	if len(species) == 0:
		response = executeapi("animal/species", "get", None, None, None)
		if response['status'] == 200:
			species = response['data']
			request.session['species'] = species
	return species

def login_breeds(request):
	breeds = []

	breeds = request.session.get('breeds', [])

	if len(breeds) == 0:
		response = executeapi("animal/breeds", "get", None, None, None)
		if response['status'] == 200:
			breeds = response['data']
			request.session['breeds'] = breeds
	return breeds

def login_colors(request):
	colors = []

	colors = request.session.get('colors', [])

	if len(colors) == 0:
		response = executeapi("animal/colors", "get", None, None, None)
		if response['status'] == 200:
			colors = response['data']
			request.session['colors'] = colors
	return colors

def login_coats(request):
	coats = []

	coats = request.session.get('coats', [])

	if len(coats) == 0:
		response = executeapi("animal/coats", "get", None, None, None)
		if response['status'] == 200:
			coats = response['data']
			request.session['coats'] = coats
	return coats

def login_animais(request):
	if not check_login(request):
		return redirect('/login?redirect=/login/animais')

	#try:
	login=get_logged_user(request)
	pets = []
	aux_pets = []
	response = executeapi("animal/petssel", "get", {"login": login["id"], "ordering": "-created_at"}, None, None)
	if response['status'] == 200:
		aux_pets = response['data']
	
	for pet in aux_pets:
		if pet["photo"]:
			pet["photo"] = pet["photo"].replace("http://loadbalancer", "http://localhost:5000")
		
		interest = 0
		response = executeapi("animal/interests", "get", {"pet": pet["id"], "confirm": "I"}, None, None)
		if response['status'] == 200:
			interest = len(response['data'])

		adoption = 0
		response = executeapi("animal/interests", "get", {"pet": pet["id"], "confirm": "A"}, None, None)
		if response['status'] == 200:
			adoption = len(response['data'])

		pets.append({
			'pet': pet,
			'interest': interest,
			'adoption': adoption
		})
	#except:
		#pets = []

	return render(request, 'login/animais.html', { 'pets': pets })

def login_animais_edit(request, pk):
	if not check_login(request):
		return redirect('/login?redirect=/login/animais/editar/%d' % pk)

	# try:
	pet = None
	response = executeapi("animal/petssel/%s" % (pk), "get", None, None, None)
	if response['status'] == 200:
		pet = response['data']
		if pet["photo"]:
			pet["photo"] = pet["photo"].replace("http://loadbalancer", "http://localhost:5000")
	
	species = login_species(request)
	breeds = login_breeds(request)
	colors = login_colors(request)
	coats = login_coats(request)
	# except:
	# 	return redirect('/login/animais')
	return render(request, 'login/animais-editar.html', { 
		'pet': pet, 
		'species': species, 
		'breeds': breeds, 
		'colors': colors, 
		'coats': coats
		})

def login_animais_edit_ajax(request, pk):
	if request.method == 'POST':
		#try:
		name = request.POST.get('name')
		genre = request.POST.get('genre')
		microship = request.POST.get('microship')
		age = request.POST.get('age')
		weight = request.POST.get('weight')
		height = request.POST.get('height')
		specie = request.POST.get('specie')
		breed = request.POST.get('breed')
		castrated = request.POST.get('castrated', 'False')
		color = request.POST.get('color')
		coat = request.POST.get('coat')
		personality = request.POST.get('personality')
		vaccination = request.POST.get('vaccination', 'False')
		available = request.POST.get('available', 'False')
		photo = request.FILES.get('photo', None)

		# aux_specie = None
		# response = executeapi("animal/species/%s" % (specie), "get", None, None, None)
		# if response['status'] == 200:
		# 	aux_specie = response['data']
		
		# aux_breed = None
		# response = executeapi("animal/breeds/%s" % (breed), "get", None, None, None)
		# if response['status'] == 200:
		# 	aux_breed = response['data']
		
		# aux_color = None
		# response = executeapi("animal/colors/%s" % (color), "get", None, None, None)
		# if response['status'] == 200:
		# 	aux_colors = response['data']
		
		# aux_coat = None
		# response = executeapi("animal/coats/%s" % (coat), "get", None, None, None)
		# if response['status'] == 200:
		# 	aux_coat = response['data']

		pet = None
		response = executeapi("animal/pets/%s" % (pk), "get", None, None, None)
		if response['status'] == 200:
			pet = response['data']
			pet['name'] = name
			pet['genre'] = genre
			pet['microship'] = microship
			pet['age'] = age
			pet['weight'] = weight
			pet['height'] = height
			pet['specie'] = specie
			pet['breed'] = breed
			pet['castrated'] = castrated
			pet['color'] = color
			pet['coat'] = coat
			pet['personality'] = personality

			if vaccination == 'True':
				pet['vaccination'] = True

			if available == 'True':
				pet['available'] = available

			del pet['photo']
			files = []
			if photo:
				files = [('photo', (photo.name, photo.file, photo.content_type))]
			
			response = executeapi("animal/pets/%s" % (pk), "put", None, None, pet, files)
			return HttpResponse(json.dumps({'success': True, 'message': 'Animal alterado com sucesso!'}), content_type='application/json')
		else:
			return HttpResponse(json.dumps({'success': False, 'message': 'Não foi possível alterar o animal!'}), content_type='application/json')
		# except:
		#  	return HttpResponse(json.dumps({'success': False, 'message': 'Não foi possível alterar o animal!'}), content_type='application/json')

def dump(obj):
  for attr in dir(obj):
    print("obj.%s = %r" % (attr, getattr(obj, attr)))

def login_animais_register(request):
	if not check_login(request):
		return redirect('/login?redirect=/login/animais/cadastrar')

	try:
		species = login_species(request)
		breeds = login_breeds(request)
		colors = login_colors(request)
		coats = login_coats(request)
	except:
		return redirect('/login/animais')
	return render(request, 'login/animais-cadastrar.html', { 
		'species': species, 
		'breeds': breeds, 
		'colors': colors, 
		'coats': coats
		})

def login_animais_register_ajax(request):
	if request.method == 'POST':
		#try:
		name = request.POST.get('name')
		genre = request.POST.get('genre')
		microship = request.POST.get('microship')
		age = request.POST.get('age')
		weight = request.POST.get('weight')
		height = request.POST.get('height')
		specie = request.POST.get('specie')
		breed = request.POST.get('breed')
		castrated = request.POST.get('castrated', 'False')
		color = request.POST.get('color')
		coat = request.POST.get('coat')
		personality = request.POST.get('personality')
		vaccination = request.POST.get('vaccination', 'False')
		available = request.POST.get('available', 'False')
		photo = request.FILES.get('photo', None)

		login=get_logged_user(request)

		# aux_specie = None
		# response = executeapi("animal/species/%s" % (specie), "get", None, None, None)
		# if response['status'] == 200:
		# 	aux_specie = response['data']
		
		# aux_breed = None
		# response = executeapi("animal/breeds/%s" % (breed), "get", None, None, None)
		# if response['status'] == 200:
		# 	aux_breed = response['data']
		
		# aux_color = None
		# response = executeapi("animal/colors/%s" % (color), "get", None, None, None)
		# if response['status'] == 200:
		# 	aux_colors = response['data']
		
		# aux_coat = None
		# response = executeapi("animal/coats/%s" % (coat), "get", None, None, None)
		# if response['status'] == 200:
		# 	aux_coat = response['data']

		pet = {
			"login": login['id'], 
			"name": name,
			"genre": genre,
			"microship": microship,
			"age": age,
			"weight": weight,
			"height": height,
			"specie": specie,
			"breed": breed,
			"castrated": castrated,
			"color": color,
			"coat": coat,
			"personality": personality,
		}
		

		if vaccination == 'True':
			pet["vaccination"] = True

		if available == 'True':
			pet["available"] = available

		files = []
		if photo:
			files = [('photo', (photo.name, photo.file, photo.content_type))]
		
		print(pet)
		response = executeapi("animal/pets", "post", None, None, pet, files)
		print(response)
		if response['status'] == 201:
			return HttpResponse(json.dumps({'success': True, 'message': 'Animal cadastrado com sucesso!'}), content_type='application/json')
		else:
			return HttpResponse(json.dumps({'success': False, 'message': 'Não foi possível cadastrar o animal!'}), content_type='application/json')
		# except:
		#  	return HttpResponse(json.dumps({'success': False, 'message': 'Não foi possível cadastrar o animal!'}), content_type='application/json')

def login_animais_interest(request, pk):
	if not check_login(request):
		return redirect('/login?redirect=/login/animais/interesse/%s' % pk)

	try:
		pet = None
		response = executeapi("animal/pets/%s" % (pk), "get", None, None, None)
		if response['status'] == 200:
			pet = response['data']
			if pet["photo"]:
				pet["photo"] = pet["photo"].replace("http://loadbalancer", "http://localhost:5000")
		else:
			return redirect('/login/area')
		return render(request, 'login/animais-interesse.html', { 'pet': pet })
	except:
		return redirect('/login/area')

def login_animais_interest_ajax(request, pk):
	# try:
	if request.is_ajax() and request.POST:
		interest_send = request.POST.get('interest', "false")

		if interest_send == "true":
			pet = None
			response = executeapi("animal/petssel/%s" % (pk), "get", None, None, None)
			if response['status'] == 200:
				pet = response['data']

			interested=get_logged_user(request)
			owner = pet['login']

			interests = []
			response = executeapi("animal/interests", "get", {"pet": pet["id"], "login": interested["id"]}, None, None)
			if response['status'] == 200:
				interests = response['data']

			if len(interests) > 0:
				return HttpResponse(json.dumps({'success': False, 'message': 'Você já declarou interesse pelo animal.', 'interest_send': interest_send}), content_type='application/json')

			interest = None
			response = executeapi("animal/interests", "post", None, None, {"login": interested["id"], "pet": pet["id"], "confirm": "I"})
			if response['status'] == 201:
				interest = response['data']
			
			message = """
				<p>Olá {{owner_name}}, o {{interested_name}} está interessado no seu animal {{pet_name}}</p>
				<p><a href="http://{{get_full_path}}/login/animais/adocao/{{interest_id}}">Clique aqui</a> para ver mais detalhes</p>
			"""
			message.replace("{{owner_name}}", owner["name"])
			message.replace("{{interested_name}}", interested["name"])
			message.replace("{{pet_name}}", pet["name"])
			message.replace("{{get_full_path}}", request.get_host())
			message.replace("{{interest_id}}", str(interest["id"]))
			print(message)

			from_email = "%s<%s>" % (interested["name"], interested["email"])
			print(from_email)

			send_mail("SOS Pet - Recuperação de senha", message, from_email, [owner["email"]], html_message=message)

			return HttpResponse(json.dumps({'success': True, 'message': 'Solicitação de interesse enviada com sucesso!'}), content_type='application/json')
		else:
			return HttpResponse(json.dumps({'success': False, 'message': 'Não foi possível enviar sua solicitação de enteresse.', 'interest_send': interest_send}), content_type='application/json')
	# except:
	# 	raise Http404

def login_animais_order_adoption(request, pk):
	try:
		pet = None
		response = executeapi("animal/pets/%s" % (pk), "get", None, None, None)
		if response['status'] == 200:
			pet = response['data']

		interests = []
		response = executeapi("animal/interests", "get", {"pet": pet["id"], "confirm": "I"}, None, None)
		if response['status'] == 200:
			interests = response['data']
	except:
		pet = None
		interests = []

	return render(request, 'login/animais-pedidos-adocao.html', { 'interests': interests, 'pet': pet })

def login_animais_order_adoption_ajax(request, pk):
	#try:
	if request.is_ajax() and request.POST:
		confirm = request.POST.get('confirm', "I")

		interest = None
		response = executeapi("animal/interests/%s" % (pk), "get", None, None, None)
		if response['status'] == 200:
			interest = response['data']
		else:
			raise Exception("Interesse não encontrado")
		interest['confirm'] = confirm
		response = executeapi("animal/interests/%s" % (pk), "post", None, None, interest)
		if response['status'] == 201:
			interest = response['data']

		if confirm == 'A':
			pet = interest['pet']
			pet['available'] = False
			executeapi("animal/pets/%s" % (pet['id']), "post", None, None, pet)
			return HttpResponse(json.dumps({'success': True, 'message': 'Solicitação de adoção aceita!'}), content_type='application/json')
		elif confirm == 'N':
			return HttpResponse(json.dumps({'success': True, 'message': 'Solicitação de adoção negada!'}), content_type='application/json')
		else:
			return HttpResponse(json.dumps({'success': False, 'message': 'Solicitação de adoção continua aguardando sua ação!'}), content_type='application/json')
	else:
		return HttpResponse(json.dumps({'success': False, 'message': 'Não foi possível finalizar a solicitação de doação.'}), content_type='application/json')
	#except:
	#	return HttpResponse(json.dumps({'success': False, 'message': 'Não foi possível finalizar a solicitação de doação.'}), content_type='application/json')


def check_login(request):
	if request.session.get('login', 0) == 0:
		return False
	else:
		return True

def get_logged_user(request):
	try:
		if (check_login(request)):
			id = request.session.get('login', 0)
			login = None
			response = executeapi("login/users/%s" % (id), "get", None, None, None)
			if response['status'] == 200:
				login = response['data']
			else:
				return None
			
			return login
		else:
			return None
	except:
		return None

def encrypt(text):
	cipher_suite = Fernet(key)
	return cipher_suite.encrypt(text.encode()).decode()

def decrypt(text):
	cipher_suite = Fernet(key)
	return cipher_suite.decrypt(text.encode()).decode()
