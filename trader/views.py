from django.shortcuts import render
from django.http import HttpResponse, HttpResponseRedirect, HttpResponseBadRequest

# Create your views here.
def index(request):
    return HttpResponse('Trader Page')