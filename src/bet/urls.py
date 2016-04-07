from django.conf.urls import  url
urlpatterns = [
               url(r'^update/(?P<match_id>[0-9]+)/$','bet.views.update'),
               url(r'^$','bet.views.bet'),
                url(r'^score/update/$', 'bet.views.score_update'),

]