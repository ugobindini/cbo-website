#!/usr/bin/env python
"""Django's command-line utility for administrative tasks."""
import os
import sys


def main():
    """Run administrative tasks."""
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'cbo-website.settings')
    try:
        from django.core.management import execute_from_command_line
    except ImportError as exc:
        raise ImportError(
            "Couldn't import Django. Are you sure it's installed and "
            "available on your PYTHONPATH environment variable? Did you "
            "forget to activate a virtual environment?"
        ) from exc
    execute_from_command_line(sys.argv)


if __name__ == '__main__':
    main()

    """
    # This code is for reloading the Neume.objects after adding/removing glyphs or items
    import json
    from browse.models import Item,Neume

    Neume.objects.all().delete()

    with open('staticfiles/json/buranus.json') as f:
        glyphs = json.load(f)
        for glyph in glyphs:
            Neume(n=glyph['n'], description=glyph['description'], count=sum([item.count_neumes(glyph['n']) for item in Item.objects.all()])).save()
    """
