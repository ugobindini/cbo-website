from django.urls import path, include

from . import views

urlpatterns = [
    # path('', views.browse_index, name='browse_index'),
    path('browse-item/', views.browse_item, name='browse_item'),
    path('sources/', views.SourceListView.as_view(), name='sources'),
    path('source/<int:pk>', views.SourceDetailView.as_view(), name='source-detail'),
    path('item-core-view/<int:pk>', views.item_core_view, name='item-core-view'),
    path('item-as-tr/<int:pk>', views.item_as_tr, name='item-as-tr'),
    path('items/', views.ItemListView.as_view(), name='items'),
    path('item/<int:pk>', views.ItemDetailView.as_view(), name='item-detail'),
    path('abstract_item/<int:pk>', views.AbstractItemDetailView.as_view(), name='abstract-item-detail'),
    path('neumes/', views.NeumeListView.as_view(), name='neumes'),
    path('neume/<int:pk>', views.NeumeDetailView.as_view(), name='neume-detail')
]