from django.shortcuts import render

def index(request):
    """View function for home page of CBO website."""

    context = {}

    # Render the HTML template index.html with the data in the context variable
    return render(request, 'index.html', context=context)