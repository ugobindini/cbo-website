from django.contrib import admin
from .models import Language, Author, Genre, Theme, TextType, TextTypeSpecification, Source, AbstractItem, Item


class SourceAdmin(admin.ModelAdmin):
    list_per_page = 120
    list_display = ["country", "location", "bib_id", "century", "notation", "url", "concordances", "notes"]
    list_editable = ["url"]
    # Uncomment the following line to allow filtering the corresponding fields
    list_filter = ["country"]


class ItemAdmin(admin.ModelAdmin):
    pass


class TextTypeSpecificationInline(admin.TabularInline):
    model = TextTypeSpecification
    extra = 1


class TextTypeAdmin(admin.ModelAdmin):
    inlines = [TextTypeSpecificationInline]


class AbstractItemAdmin(admin.ModelAdmin):
    inlines = [TextTypeSpecificationInline]


admin.site.register(Language)
admin.site.register(Author)
admin.site.register(Genre)
admin.site.register(Theme)
admin.site.register(TextType)
admin.site.register(TextTypeSpecification)
admin.site.register(Source, SourceAdmin)
admin.site.register(AbstractItem, AbstractItemAdmin)
admin.site.register(Item, ItemAdmin)
