FROM python:3.10.1
ENV PYTHONUNBUFFERED 1
RUN mkdir /web
WORKDIR /web
# Installing OS Dependencies
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
libsqlite3-dev
RUN pip install -U pip setuptools
ADD web/requirements.txt /web/
RUN pip install --upgrade pip 
RUN pip install -r requirements.txt
ADD web /web/
# Django service
EXPOSE 5000