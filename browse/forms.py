from django import forms


class BrowseSourceForm(forms.Form):
    country = forms.MultipleChoiceField(choices=[], required=False, widget=forms.CheckboxSelectMultiple(attrs={"class": "cbo-dropdown"}))
    bib_id = forms.CharField(max_length=20, help_text="Bibliographical identifier.", required=False)


class BrowseItemForm(forms.Form):
    template_name = "form_snippet.html"
    cb_id = forms.CharField(max_length=16, label="CB id", help_text="CB index.", required=False)
    words = forms.CharField(max_length=2048, label="Containing words...", help_text="Separate words with whitespaces to match items containing all given words.", required=False)
    exclude_apparatus = forms.BooleanField(initial=True, required=False, label="Exclude critical apparatus")
    match_word_beginning = forms.BooleanField(initial=False, required=False, label="Match word beginnings")
    match_word_end = forms.BooleanField(initial=False, required=False, label="Match word ends")
    match_word_middle = forms.BooleanField(initial=False, required=False, label="Match occurrences in the middle of word")
    metrics = forms.CharField(max_length=2048, label="Containing metric...", help_text="Separate with whitespaces to match items containing all given units.\nSeparate with slash to match consecutive verses (or half-verses).", required=False)
    through_strophe_break = forms.BooleanField(initial=False, required=False, label="Search through strophe breaks for consecutive patterns")