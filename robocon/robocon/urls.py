from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('robots.urls')),
]

handler404 = 'robots.views.custom_404'
handler500 = 'robots.views.custom_500'