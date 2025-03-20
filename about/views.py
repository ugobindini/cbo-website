from django.shortcuts import render

def index(request):
    """View function for starting page of about."""

    context = {}

    # Render the HTML template index.html with the data in the context variable
    return render(request, 'about_index.html', context=context)
