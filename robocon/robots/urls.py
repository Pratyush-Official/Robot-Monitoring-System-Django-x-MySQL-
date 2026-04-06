from django.urls import path
from . import views

urlpatterns = [
    path('', views.dashboard, name='dashboard'),
    path('robots/', views.robots_list, name='robots'),
    path('robots/<int:id>/', views.robot_detail, name='robot_detail'),
    path('robots/add/', views.robot_add, name='robot_add'),
    path('robots/edit/<int:id>/', views.robot_edit, name='robot_edit'),
    path('robots/delete/<int:id>/', views.robot_delete, name='robot_delete'),
    path('sensors/', views.sensors_list, name='sensors'),
    path('readings/', views.readings_list, name='readings'),
    path('actuators/', views.actuators_list, name='actuators'),
    path('control/', views.control_list, name='control'),
    path('login/', views.login_view, name='login'),
    path('logout/', views.logout_view, name='logout'),
]