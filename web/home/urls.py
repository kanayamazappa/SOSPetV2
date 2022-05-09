from django.urls import re_path
from . import views

app_name = 'home'

# urlpatterns a lista de roteamentos de URLs para funções/Views
urlpatterns = [
    # GET /
    re_path(r'^$', views.home_index, name='home_index'),
    re_path(r'^quem-somos$', views.quemsomos_index, name='quemsomos_index'),
    re_path(r'^contato$', views.contato_index, name='contato_index'),
    re_path(r'^contato/ajax$', views.contato_ajax, name='contato_ajax'),
]