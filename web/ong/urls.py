from django.urls import re_path
from . import views

app_name = 'ong'

# urlpatterns a lista de roteamentos de URLs para funções/Views
urlpatterns = [
    re_path(r'^$', views.ong_index, name='ong_index'),
    re_path(r'^(?P<pk>\d+)$', views.ong_detail, name='ong_detail'),
]