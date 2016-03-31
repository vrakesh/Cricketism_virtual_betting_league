from django.http import HttpResponse
from django.template.loader import get_template
from django.template import Context
from allauth.account.decorators import verified_email_required

@verified_email_required(login_url='/accounts/login/')
def home(request):
    """Dummy home page"""
    t =  get_template('home.html')
    c = Context({})
    response = t.render(c)
    return HttpResponse(response)