from django.views.generic.base import RedirectView
from django.conf.urls import url
from . import views

urlpatterns = [
    url(r'^index/$', views.Index.as_view(), name='index'),
    url(r'^quote-paginator/', views.QuotePaginator.as_view(), name='quote-paginator'),

]









