from django.shortcuts import render
from django import forms
from .models import Source, Item, Neume

from browse.forms import BrowseSourceForm


def browse_index(request):
    """View function for starting page of browse."""

    form = BrowseSourceForm(request.GET)
    form.fields['country'].choices = list(set([(source.country, source.country) for source in Source.objects.all()]))
    # print(form.fields['country'].widget.render("Ciao", "ciao"))
    source_list = []

    if request.method == 'GET':
        if form.is_valid():
            source_list = Source.objects.filter(bib_id__contains=form.cleaned_data['bib_id']).filter(country__in=form.cleaned_data['country'])

    context = {
        'form': form,
        'source_list': source_list,
    }

    # Render the HTML template index.html with the data in the context variable
    return render(request, 'browse_index.html', context=context)


from django.views import generic


class SourceListView(generic.ListView):
    model = Source
    context_object_name = 'source_list'
    template_name = 'source_list.html'
    paginate_by = 30


class SourceDetailView(generic.DetailView):
    model = Source
    template_name = 'source_detail.html'


class ItemListView(generic.ListView):
    model = Item
    context_object_name = 'item_list'
    template_name = 'item_list.html'
    paginate_by = 30


class ItemDetailView(generic.DetailView):
    model = Item
    template_name = 'item_detail.html'


class NeumeListView(generic.ListView):
    model = Neume
    context_object_name = 'neume_list'
    template_name = 'neume_list.html'


class NeumeDetailView(generic.DetailView):
    model = Neume
    template_name = 'neume_detail.html'

    def get_context_data(self, **kwargs):
        context = super(NeumeDetailView, self).get_context_data(**kwargs)
        n = self.get_object().n
        print(n)

        import xml.etree.ElementTree as ET
        import os
        from django.conf import settings

        tei_path = os.path.join(os.path.join(settings.BASE_DIR, 'staticfiles'), 'tei')

        for tei_file in os.listdir(tei_path):
            print(tei_file)
            if tei_file.endswith(".tei"):
                tree = ET.parse(os.path.join(tei_path, tei_file))
                print(tree.find(f"neume[@glyph.num='{n}']2"))

        return context
