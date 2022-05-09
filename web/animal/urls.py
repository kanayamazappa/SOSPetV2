from django.urls import include, re_path
from . import views
app_name = 'animal'

# urlpatterns a lista de roteamentos de URLs para funções/Views
urlpatterns = [
    re_path(r'^$', views.animal_index, name='animal_index'),
    re_path(r'^(?P<pk>\d+)$', views.animal_detail, name='animal_detail'),
]