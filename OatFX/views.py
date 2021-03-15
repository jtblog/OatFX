from django.http import HttpResponse, HttpResponseRedirect, HttpResponseBadRequest
from django.shortcuts import render
from django.views.generic import View

from .forms import LoginForm
from .shared import *

con = obj.get_connection()

class IndexView(View):
    def post(self, request):
        form = LoginForm(request.POST)
        if(form.is_valid()):
            #TOKEN = '428f4f0130d439c3d02922e4a5d4640a783830fb'
            token = request.POST.get('api_token')
            con = obj.get_connection()
            if(con is not None and con.is_connected):
                pass
            else:
                con = fx(access_token=token, log_level='error', server='demo', log_file='oatfx.log')
                obj.set_connection(con)
                obj.print_account()
                obj.close()
            context = {
                'btnhtml': 'Log Out',
                'form': form
            }
            #return HttpResponseRedirect('/')
            return render(request, 'index.html', context)
        else:
            '''form = LoginForm()
            context = {
                'form':form
            }
            return render(request, 'index.html', context)'''
    def get(self, request):
        form = LoginForm()
        context = {
                'btnhtml': 'Log In',
                'form':form
            }
        return render(request, 'index.html', context)
        
def close_connection(request):
    if(con is not None and con.is_connected):
        con.close()
        return HttpResponse("Connection is closed")
    else:
        return HttpResponseBadRequest('This connection is already closed or bad')

'''def index(request):
    if(request.method) == 'POST':
        form =LoginForm(request.POST)
        if(form.is_valid()):
            pass
        else:
            form = LoginForm()
        return render(request, 'index.html', {'form':form})
'''


'''
{% load static %}
    <link rel="stylesheet" href="{% static 'assets/bootstrap/css/bootstrap.min.css' %}">
    <link rel="stylesheet" href="{% static 'assets/fonts/ionicons.min.css' %}">
    <link rel="stylesheet" href="{% static 'assets/css/styles.min.css' %}">
'''

'''
{{ btnhtml }}
{% if disabled == True %} disabled {% endif %}
'''

'''
{% csrf_token %}
{% if form.api_token.value != None %}value="{{form.api_token.value |stringformat:'s'}}"{% endif %}
'''

'''
{% load static %}
    <script src="{% static 'assets/js/jquery.min.js' %}" ></script>
    <script src="{% static 'assets/bootstrap/js/bootstrap.min.js' %}" ></script>
    <script src="{% static 'assets/js/script.min.js' %}" ></script>
'''