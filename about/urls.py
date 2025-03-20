from django.urls import path, include

from . import views

urlpatterns = [
    path('', views.index, name='about_index'),
]