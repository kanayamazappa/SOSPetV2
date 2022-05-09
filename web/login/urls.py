from django.urls import re_path
from . import views

app_name = 'login'

# urlpatterns a lista de roteamentos de URLs para funções/Views
urlpatterns = [
    re_path(r'^$', views.login_index, name='login_index'),
    re_path(r'^logout$', views.login_logout, name='login_logout'),
    re_path(r'^esqueci-senha$', views.login_esqueci, name='login_esqueci'),
    re_path(r'^esqueci-senha/ajax$', views.login_esqueci_ajax, name='login_esqueci_ajax'),
    re_path(r'^cadastro$', views.login_cadastro, name='login_cadastro'),
    re_path(r'^cadastro/ajax$', views.login_cadastro_ajax, name='login_cadastro_ajax'),
    re_path(r'^ativar$', views.login_active, name='login_active'),
    re_path(r'^ajax$', views.login_ajax, name='login_ajax'),
    re_path(r'^area$', views.login_area, name='login_area'),
    re_path(r'^perfil$', views.login_editar, name='login_editar'),
    re_path(r'^perfil/ajax$', views.login_editar_ajax, name='login_editar_ajax'),
    re_path(r'^animais$', views.login_animais, name='login_animais'),
    re_path(r'^animais/(?P<pk>\d+)$', views.login_animais_edit, name='login_animais_edit'),
    re_path(r'^animais/ajax/(?P<pk>\d+)$', views.login_animais_edit_ajax, name='login_animais_edit_ajax'),
    re_path(r'^animais/cadastrar$', views.login_animais_register, name='login_animais_register'),
    re_path(r'^animais/cadastrar/ajax$', views.login_animais_register_ajax, name='login_animais_register_ajax'),
    re_path(r'^animais/interesse/(?P<pk>\d+)$', views.login_animais_interest, name='login_animais_interest'),
    re_path(r'^animais/interesse/ajax/(?P<pk>\d+)$', views.login_animais_interest_ajax, name='login_animais_interest_ajax'),
    re_path(r'^animais/pedidos-adocao/(?P<pk>\d+)$', views.login_animais_order_adoption, name='login_animais_order_adoption'),
    re_path(r'^animais/pedidos-adocao/ajax/(?P<pk>\d+)$', views.login_animais_order_adoption_ajax, name='login_animais_order_adoption_ajax'),
]