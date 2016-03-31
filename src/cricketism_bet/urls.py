from django.conf.urls import include, url
from django.contrib import admin
from django.views.generic import RedirectView

urlpatterns = [
    # Examples:
    # url(r'^$', 'cricketism_bet.views.home', name='home'),
    # url(r'^blog/', include('blog.urls')),
    url(r'^$', RedirectView.as_view(url='/bet/')),
    url(r'^admin/', include(admin.site.urls)),
    url(r'^accounts/', include('allauth.urls')),
    url(r'^invitations/', include('invitations.urls', namespace='invitations')),
    url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework')),
    url(r'^bet/','cricketism_bet.views.home'),
]
