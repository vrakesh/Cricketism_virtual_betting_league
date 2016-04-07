from django.http import HttpResponse
from django.template.loader import get_template
from django.template import Context
from allauth.account.decorators import verified_email_required
from django.template.context_processors import csrf
from bet.models import ScoreModel

@verified_email_required(login_url='/accounts/login/')
def home(request):
    """Dummy home page"""
    t =  get_template('home.html')
    c = Context({})
    response = t.render(c)
    return HttpResponse(response)


@verified_email_required(login_url='/accounts/login')
def rules(request):
    t = get_template('rules.html')
    args = {}
    args.update(csrf(request))
    c = Context(args)
    response = t.render(c)
    return HttpResponse(response)


@verified_email_required(login_url='/accounts/login')
def score(request):
    scores = ScoreModel.objects.all().order_by('-total_score')
    sc = []
    data_dict = {}
    i=1
    for score in scores:
        data_dict['user'] = score.user_name
        data_dict['score'] = score.total_score
        data_dict['serial'] = i
        i += 1
        sc.append(data_dict.copy())
    t = get_template('score.html')
    c = Context({'scores' : sc,})
    response = t.render(c)
    return HttpResponse(response)