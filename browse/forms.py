from django import forms


class BrowseSourceForm(forms.Form):
    country = forms.MultipleChoiceField(choices=[], required=False, widget=forms.CheckboxSelectMultiple(attrs={"class": "cbo-dropdown"}))
    bib_id = forms.CharField(max_length=20, help_text="Bibliographical identifier.", required=False)


class BrowseItemForm(forms.Form):
    template_name = "form_snippet.html"
    cb_id = forms.CharField(max_length=16, label="CB id", help_text="CB index.", required=False)
    words = forms.CharField(max_length=2048, label="Containing words...", help_text="Separate words with whitespaces to match items containing all given words.", required=False)
    metrics = forms.CharField(max_length=2048, label="Containing metric...", help_text="Separate with whitespaces to match items containing all given units.\nSeparate with slash to match consecutive verses (or half-verses).", required=False)
