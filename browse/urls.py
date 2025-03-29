from django.urls import path, include

from . import views

urlpatterns = [
    path('', views.browse_index, name='browse_index'),
    path('sources/', views.SourceListView.as_view(), name='sources'),
    path('source/<int:pk>', views.SourceDetailView.as_view(), name='source-detail'),
    path('items/', views.ItemListView.as_view(), name='items'),
    path('item/<int:pk>', views.ItemDetailView.as_view(), name='item-detail'),
    path('neumes/', views.ItemListView.as_view(), name='neumes'),
    path('neume/<int:pk>', views.ItemDetailView.as_view(), name='neume-detail')
]