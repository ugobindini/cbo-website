from django.conf import settings

if settings.LOCAL:
    static_root = settings.STATICFILES_DIRS[0]
else:
    static_root = settings.STATIC_ROOT

def static_path(path):
    import os.path
    return os.path.join(static_root, path)