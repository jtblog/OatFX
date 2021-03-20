from django.http import HttpResponse, HttpResponseRedirect, HttpResponseBadRequest
from django.shortcuts import render
from django.views.generic import View

from .forms import LoginForm
from .shared import obj

con = obj.get_connection()

class IndexView(View):
    
    def post(self, request):
        form = LoginForm(request.POST)
        con = obj.get_connection()
        context = { 'btnhtml': 'Log In', 'form': form }
        if(form.is_valid()):
            #TOKEN = '428f4f0130d439c3d02922e4a5d4640a783830fb'
            token = request.POST.get('api_token')
            if(con is not None):
                context['btnhtml'] = 'Log Out'
                #json_data = json.dumps({'ping':'1'})
                #con.send(json_data)
                #obj.get_instruments()
                pass
            else:
                #con = obj.fx(access_token=token, log_level='error', server='demo', log_file='oatfx.log')
                obj.connect()
                #obj.set_connection(con)
                if(con is not None):
                    context['btnhtml'] = 'Log Out'
                
            #return HttpResponseRedirect('/')
            return render(request, 'index.html', context)
        else:
            pass
    def get(self, request):
        form = LoginForm()
        context = { 'btnhtml': 'Log In', 'form':form }
        return render(request, 'index.html', context)
        
def close_connection(request):
    con = obj.get_connection()
    #obj.cleardb()
    '''if(con is not None):
        con.close()
        return HttpResponse("Connection is closed")
    else:
        return HttpResponseBadRequest("This connection is already closed or bad")'''






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
{{ btnhtml }}
{% if disabled == True %} disabled {% endif %}
'''

'''
{% csrf_token %}
{% if form.api_token.value != None %}value="{{form.api_token.value |stringformat:'s'}}"{% endif %}
'''