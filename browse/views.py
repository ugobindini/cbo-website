from django.http import HttpResponseRedirect
from django.shortcuts import render

from .models import Source, Item, Neume
from .forms import BrowseSourceForm, BrowseItemForm


def browse_item(request):
    # if this is a POST request we need to process the form data
    if request.method == "POST":
        # create a form instance and populate it with data from the request:
        form = BrowseItemForm(request.POST)
        # check whether it's valid:
        if form.is_valid():
            items = Item.objects.all()
            if len(form.cleaned_data['cb_id']):
                cb_id = form.cleaned_data['cb_id']
                items = Item.objects.filter(abstract_item__cb_id=cb_id)
            if len(form.cleaned_data['words']):
                words = form.cleaned_data['words'].lower().split(" ")
                exclude_apparatus = form.cleaned_data['exclude_apparatus']
                match_word_beginning = form.cleaned_data['match_word_beginning']
                match_word_end = form.cleaned_data['match_word_end']
                match_word_middle = form.cleaned_data['match_word_middle']
                items = [item for item in items if item.contains_words(words,
                                                                       exclude_apparatus=exclude_apparatus,
                                                                       match_word_beginning=match_word_beginning,
                                                                       match_word_end=match_word_end,
                                                                       match_word_middle=match_word_middle)
                         ]
            if len(form.cleaned_data['metrics']):
                metrics = form.cleaned_data['metrics'].split(" ")
                through_strophe_break = form.cleaned_data['through_strophe_break']
                items = [item for item in items if item.contains_metrics(metrics,
                                                                         through_strophe_break=through_strophe_break)
                         ]
            return render(request, "browse_item.html", {"form": form, "items": items})

    # if a GET (or any other method) we'll create a blank form
    else:
        form = BrowseItemForm()

    return render(request, "browse_item.html", {"form": form, "items": Item.objects.all()})


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

def item_core_view(request, pk):
    item = Item.objects.get(pk=pk)
    return render(request, 'item_core_view.html', context={'item': item})

def item_as_tr(request, pk):
    item = Item.objects.get(pk=pk)
    return render(request, 'item_as_tr.html', context={'item': item})


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
    # paginate_by = 30


class ItemDetailView(generic.DetailView):
    model = Item
    template_name = 'item_detail.html'

    def get_context_data(self, **kwargs):
        context = super(ItemDetailView, self).get_context_data(**kwargs)
        context['other_items'] = Item.objects.all()
        return context

class NeumeListView(generic.ListView):
    model = Neume
    context_object_name = 'neume_list'
    template_name = 'neume_list.html'

    def get_context_data(self, **kwargs):
        context = super(NeumeListView, self).get_context_data(**kwargs)
        context['neume_list'] = sorted(Neume.objects.all(), key=lambda x: x.count, reverse=True)
        return context


class NeumeDetailView(generic.DetailView):
    model = Neume
    template_name = 'neume_detail.html'

    def get_context_data(self, **kwargs):
        context = super(NeumeDetailView, self).get_context_data(**kwargs)
        context['items'] = []
        n = self.get_object().n
        print(n)

        for item in Item.objects.all():
            k = item.count_neumes(n)
            if k:
                context['items'].append((item, str(k), item.neume_detail_transform(n)))

        return context
