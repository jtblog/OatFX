from django import forms

class LoginForm(forms.Form):
    #acc_type = forms.ChoiceField()
    api_token = forms.CharField(label='')