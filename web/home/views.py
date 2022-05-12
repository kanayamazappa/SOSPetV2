import json
from smtplib import SMTPException
from django.shortcuts import render
from django.http import Http404, HttpResponse
from django.core.mail import send_mail
from tools.executeapi import executeapi
#from banner.models import Banner
#from .models import QuemSomos, Contact, Recipient

# Create your views here.
def home_index(request):
    try:
        response = executeapi("banner", "get", {"ordering": "-created_at"}, None, None)
        if response['status'] == 200:
            banners = response['data']

            for banner in banners:
                if banner["banner"]:
                    banner["banner"] = banner["banner"].replace("http://loadbalancer", "http://localhost:5000")
        else:
            banners = []
    except:
        banners = []
    return render(request, 'home/index.html', { 'banners': banners })

def quemsomos_index(request):
    try:
        response = executeapi("home/who-we-are/1", "get", None, None, None)
        if response['status'] == 200:
            QuemSomos = response['data']
        else:
            QuemSomos = []
    except:
        QuemSomos = {}
    return render(request, 'home/quem-somos.html', { 'QuemSomos': QuemSomos})

def contato_index(request):
    return render(request, 'home/contato.html', { })

def contato_ajax(request):
    if request.is_ajax() and request.POST:
        name = request.POST.get('name')
        email = request.POST.get('email')
        subject = request.POST.get('subject')
        message = request.POST.get('message')

        data = {'success': False, 'message': 'Falha ao enviar o contato!'}
        try:
            response = executeapi("home/contact", "post", None, None, {'name': name, 'email': email, 'subject': subject, 'message': message})
            if response['status'] != 201:
                data = {'success': False, 'message': 'Não foi possível salvar o contato no banco de dados.'}
                raise

            recipients = []

            response = executeapi("home/recipient", "get", None, None, None)
            if response['status'] == 200:
                Recipients = response['data']
            else:
                Recipients = []

            for item in Recipients:
                recipients.append(item['email'])

            message = """<table border="1">
                <tr><th align="left">Nome</th><td>{{name}}</td></tr>
                <tr><th align="left">E-mail</th><td>{{email}}</td></tr>
                <tr><th align="left">Assunto</th><td>{{subject}}</td></tr>
                <tr><th align="left">Mensagem</th><td>{{message}}</td></tr>
            </table>""".replace("{{name}}", name).replace("{{email}}", email).replace("{{subject}}", subject).replace("{{message}}", message)

            from_email = "SOS Pet<%s>" % email

            send_mail("SOS Pet - Contato", message, from_email, recipients, html_message=message)

            data = {'success': True, 'message': 'Contato enviado com sucesso'}
            return HttpResponse(json.dumps(data), content_type='application/json')
        except SMTPException as e:
            return HttpResponse(json.dumps(data), content_type='application/json')
        except:
            return HttpResponse(json.dumps(data), content_type='application/json')
    else:
        raise Http404