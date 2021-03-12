from django.http import HttpResponse
from django.shortcuts import render
from django.views.generic import View

class IndexView(View):
    def get(self, request):
        return render(request, 'index.html')

'''
{% load static %}
    <link rel="stylesheet" href="{% static '/assets/bootstrap/css/bootstrap.min.css' %}">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Euphoria+Script">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Waiting+for+the+Sunrise">
    <link rel="stylesheet" href="{% static '/assets/css/styles.min.css' %}">
'''

'''
{% load static %}
    <script src="{% static 'assets/js/jquery.min.js' %}" ></script>
    <script src="{% static 'assets/bootstrap/js/bootstrap.min.js' %}" ></script>
    <script src="{% static 'assets/js/script.min.js' %}" ></script>
'''