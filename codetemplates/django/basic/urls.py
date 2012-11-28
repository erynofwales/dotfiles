from django.conf import settings
from django.conf.urls import patterns, include, url


urlpatterns = patterns('',
    url(r'', include('{{ project_name }}.urls')),
)


if settings.DEBUG:
    from django.contrib import admin
    admin.autodiscover()
    urlpatterns += patterns('',
        url(r'^admin/', include(admin.site.urls)),
    )

