from queue import Empty
import xdrlib
import requests
import json
from urllib.parse import urlencode
from django.conf import settings


def gettoken():
    url = settings.API_URL + '/api/auth'
    body = {'username': settings.API_USER, 'password': settings.API_PASS}
    headers =  {"Content-Type":"application/json"}
    response = requests.post(url, data=json.dumps(body), headers=headers)

    return {
        'status': response.status_code,
        'data': response.json()
    }

def executeapi(action, method, querystring=None, headers=None, body=None, files=None):
    #try:
    if method.upper() not in ["GET", "POST", "PUT", "DELETE"]:
        return {
            'status': 500,
            'data': 'Médoto de envio inválido!'
        }
    
    token = gettoken()

    if token['status'] != 200:
        return token
    
    query = ""
    if querystring:
        query = urlencode(querystring)
    
    url = settings.API_URL + '/api/' + action + '/'
    if len(query) > 0:
        url += '?' + query

    headers =  {"Content-Type":"application/json", "Authorization": "JWT " + token['data']['token']}
    response = None

    match method.upper():
        case "GET":
            response = requests.get(url, headers=headers)
        case "POST":
            data = json.dumps(body)
            if files is not None and len(files) > 0:
                headers =  {"Authorization": "JWT " + token['data']['token']}
                data = body
            response = requests.post(url, data=data, headers=headers, files=files)
        case "PUT":
            data = json.dumps(body)
            if files is not None and len(files) > 0:
                headers =  {"Authorization": "JWT " + token['data']['token']}
                data = body
            response = requests.request("PUT", url, data=data, headers=headers, files=files)
        case "DELETE":
            response = requests.delete(url, headers=headers)
    return {
        'status': response.status_code,
        'data': response.json()
    }
    # except requests.exceptions.HTTPError as errh:
    #     print ("Http Error:",errh)
    # except requests.exceptions.ConnectionError as errc:
    #     print ("Error Connecting:",errc)
    # except requests.exceptions.Timeout as errt:
    #     print ("Timeout Error:",errt)
    # except requests.exceptions.RequestException as err:
    #     print ("OOps: Something Else",err)

def dump(obj):
  for attr in dir(obj):
    print("obj.%s = %r" % (attr, getattr(obj, attr)))