# SOSPetV2

### Reestruturação para uma arquitetura horizontal.

API's - Python 3, Django, Django Rest Framework, Mysql.

FRONT's - Python 3, Django, SqlLite (Controle de sessão).

Utilizamos o **DOCKER** para gerar o cluster de **API's** e **FRONT's**, o **NGINX** para o controle de carga realizado.

### Como rodar o projeto.

Faça o download do git em: https://git-scm.com/downloads
Após a instalação abra o PowerShell ou CMD, e digite o commando:
```
git clone https://github.com/kanayamazappa/SOSPetV2.git
```

Faça o download do Docker em: https://docs.docker.com/get-docker/
Após a instalação abra a pasta do projeto SOSPetV2 com o powershel ou cmd e digite o commando:
```
docker-compose up -d
```

Pronto para testar o projeto, os caminhos são:

- MYSQL: http://localhost:3606
- API 1: http://localhost:5001
- API 2: http://localhost:5002
- API 3: http://localhost:5003
- BALANCER API: http://localhost:5000
- FRONT 1: http://localhost:8001
- FRONT 2: http://localhost:8002
- FRONT 3: http://localhost:8003
- BALANCER FRON: http://localhost:8000
