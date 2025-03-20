from django import forms


class BrowseSourceForm(forms.Form):
    country = forms.MultipleChoiceField(choices=[], required=False, widget=forms.CheckboxSelectMultiple(attrs={"class": "cbo-dropdown"}))
    bib_id = forms.CharField(max_length=20, help_text="Bibliographical identifier.", required=False)


class BrowseItemForm(forms.Form):
    cb_id = forms.CharField(max_length=10, help_text="Number of the item.")