from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import  LoginViewSet, CustomUserViewSet, RegisterViewSet, TourRegisterViewSet

router = DefaultRouter()
router.register(r'login', LoginViewSet, basename='login')
router.register(r'users', CustomUserViewSet, basename='users')
router.register(r'register', RegisterViewSet, basename='register') 
router.register(r'tourAdminRegisr', TourRegisterViewSet, basename='tour admin register') 


urlpatterns = [
    path('api/', include(router.urls)),
]


