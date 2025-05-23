import lxml.etree
from django.db import models
from django.urls import reverse
from django.db.models import UniqueConstraint
from django.db.models.functions import Lower, Length
from django.conf import settings
from .indentify import indentify
from .metify import metify

if settings.LOCAL:
    static_root = settings.STATICFILES_DIRS[0]
else:
    static_root = settings.STATIC_ROOT

def staticfile_path(folder, filename):
    import os.path
    return os.path.join(os.path.join(static_root, folder), filename)

class Language(models.Model):
    """Model representing a language."""
    name = models.CharField(max_length=200, unique=True, help_text="The language (e.g. Latin, Middle High German, etc.)")

    def get_absolute_url(self):
        """Returns the URL to access a particular instance of the model."""
        return reverse('language-detail', args=[str(self.id)])

    def __str__(self):
        """String for representing the Model object (in Admin site etc.)"""
        return self.name

    class Meta:
        ordering = ['name']
        constraints = [
            UniqueConstraint(
                Lower('name'),
                name='language_name_case_insensitive_unique'
            ),
        ]


class Author(models.Model):
    """Model representing an author."""
    name = models.CharField(max_length=200, unique=True, help_text="The author's name.")
    date_of_birth = models.CharField(max_length=100, help_text="The author's birth date.", default=None)
    date_of_death = models.CharField(max_length=100, help_text="The author's death date", default=None)

    class Meta:
        ordering = ['name']

    def get_absolute_url(self):
        """Returns the URL to access a particular instance of the model."""
        return reverse('author-detail', args=[str(self.id)])

    def __str__(self):
        """String for representing the Model object (in Admin site etc.)"""
        return self.name

    class Meta:
        constraints = [
            UniqueConstraint(
                Lower('name'),
                name='author_name_case_insensitive_unique'
            ),
        ]


class Genre(models.Model):
    """Model representing a genre."""
    name = models.CharField(max_length=200, unique=True, help_text="The genre (e.g. Song, Liturgical chant, Versus, etc.)")

    def get_absolute_url(self):
        """Returns the URL to access a particular instance of the model."""
        return reverse('genre-detail', args=[str(self.id)])

    def __str__(self):
        """String for representing the Model object (in Admin site etc.)"""
        return self.name

    class Meta:
        ordering = ['name']
        constraints = [
            UniqueConstraint(
                Lower('name'),
                name='genre_name_case_insensitive_unique'
            ),
        ]


class Theme(models.Model):
    """Model representing a theme."""
    name = models.CharField(max_length=200, unique=True, help_text="The theme (e.g. Moral, Satyric, Love, etc.)")

    def get_absolute_url(self):
        """Returns the URL to access a particular instance of the model."""
        return reverse('theme-detail', args=[str(self.id)])

    def __str__(self):
        """String for representing the Model object (in Admin site etc.)"""
        return self.name

    class Meta:
        ordering = ['name']
        constraints = [
            UniqueConstraint(
                Lower('name'),
                name='theme_name_case_insensitive_unique'
            ),
        ]


class TextType(models.Model):
    """Model representing a text type (metrical poetry, rhythmic poetry, prose)."""
    METRICAL_POETRY = "Metrical poetry"
    RHYTHMICAL_POETRY = "Rhythmical poetry"
    PROSE = "Prose"
    TYPE_CHOICES = [
        (METRICAL_POETRY, "Metrical poetry"),
        (RHYTHMICAL_POETRY, "Rhythmical poetry"),
        (PROSE, "Prose")
    ]
    type = models.CharField(max_length=20, choices=TYPE_CHOICES)

    def get_absolute_url(self):
        """Returns the URL to access a particular instance of the model."""
        return reverse('text-type-detail', args=[str(self.id)])

    def __str__(self):
        """String for representing the Model object (in Admin site etc.)"""
        return self.type

    class Meta:
        ordering = ['type']


class TextTypeSpecification(models.Model):
    """Model representing a specification of the text type."""
    text_type = models.ForeignKey(TextType, on_delete=models.CASCADE)
    abstract_item = models.ForeignKey("AbstractItem", on_delete=models.CASCADE)
    HEXAMETER = "HEX"
    PENTAMETER = "PEN"
    SEPTENARIUS = "SEP"
    TRIMETER = "TRI"
    VERSE_UNIT_CHOICES = [
        ("", "Unspecified"),
        (HEXAMETER, "Hexameter"),
        (PENTAMETER, "Pentameter"),
        (SEPTENARIUS, "Septenarius"),
        (TRIMETER, "Trimeter")
    ]
    verse_unit = models.CharField(max_length=3, choices=VERSE_UNIT_CHOICES, default="", null=True, blank=True)

    IAMB = "IAM"
    TROCHEE = "TRO"
    SPONDEE = "SPO"
    ANAPEST = "ANA"
    DAKTYL = "DAK"
    TYPE_OF_METER_CHOICES = [
        ("", "Unspecified"),
        (IAMB, "Iamb"),
        (TROCHEE, "Trochee"),
        (SPONDEE, "Spondee"),
        (ANAPEST, "Anapest"),
        (DAKTYL, "Daktyl")
    ]
    type_of_meter = models.CharField(max_length=3, choices=TYPE_OF_METER_CHOICES, default="", null=True, blank=True)

    ISOMETRIC = "ISO"
    HETEROMETRIC = "HET"
    STROPHIC_CHOICES = [
        ("", "Not strophic"),
        (ISOMETRIC, "Isometric"),
        (HETEROMETRIC, "Heterometric")
    ]
    strophic = models.CharField(max_length=3, choices=STROPHIC_CHOICES, default="", null=True, blank=True)

    refrain = models.BooleanField()

    def get_absolute_url(self):
        """Returns the URL to access a particular instance of the model."""
        return reverse('text-type-specification-poetry-detail', args=[str(self.id)])

    def __str__(self):
        """String for representing the Model object (in Admin site etc.)"""
        return f"{self.verse_unit}, {self.type_of_meter}, {self.strophic}, refrain: {self.refrain}"


class MusicalForm(models.Model):
    """Model representing a musical form."""
    # TODO: how do we represent it?

    def get_absolute_url(self):
        """Returns the URL to access a particular instance of the model."""
        return reverse('music-form-detail', args=[str(self.id)])

    def __str__(self):
        """String for representing the Model object (in Admin site etc.)"""
        # TODO
        return ""


class Source(models.Model):
    """Model representing a source (manuscript)."""
    bib_id = models.CharField(max_length=128, unique=True, help_text="The source identifier.")
    nick_name = models.CharField(max_length=128, help_text="The source name.", blank=True)
    country = models.CharField(max_length=256, help_text="The source location (country).")
    location = models.CharField(max_length=256, help_text="The source location (institution).")
    century = models.CharField(max_length=256, help_text="The source century.", blank=True)
    notation = models.CharField(max_length=256, help_text="The source notation type (for musical notation only).", blank=True)
    url = models.CharField(max_length=512, help_text="External url to access the source images.", blank=True)
    concordances = models.TextField(help_text="Concordances with the Codex Buranus.", blank=True)
    notes = models.TextField(help_text="Additional notes on the source.", blank=True)
    IIIF_manifest = models.CharField(max_length=1024, help_text="URL of the IIIF manifest.", blank=True)

    class Meta:
        ordering = ['country', 'location', 'bib_id']

    def get_absolute_url(self):
        """Returns the URL to access a particular instance of the model."""
        return reverse('source-detail', args=[str(self.id)])

    def __str__(self):
        """String for representing the Model object (in Admin site etc.)"""
        res = self.location + ", " + self.bib_id
        if len(self.nick_name):
            res += f' "{self.nick_name}"'
        return res


class AbstractItem(models.Model):
    """A single piece (with or without music) in the Buranus manuscript, as an abstract entity"""
    cb_id = models.CharField(max_length=10, help_text="Number of the item.")
    theme = models.ManyToManyField(Theme)
    genre = models.ForeignKey(Genre, on_delete=models.SET_NULL, null=True)
    text_type = models.ManyToManyField(TextType, through="TextTypeSpecification")

    class Meta:
        ordering = [Length('cb_id'), 'cb_id']

    def __str__(self):
        """Returns the item's CB id."""
        return f"CB {self.cb_id}"

    def get_absolute_url(self):
        """Returns the URL to access a particular instance of the model."""
        return reverse('abstract-item-detail', args=[str(self.cb_id)])


class Item(models.Model):
    """An item's instance."""
    abstract_item = models.ForeignKey(AbstractItem, on_delete=models.PROTECT, null=True)
    source = models.ForeignKey(Source, on_delete=models.RESTRICT, null=True)
    foliation_start = models.CharField(max_length=64, help_text="First folio occupied by the item in the source.")
    foliation_end = models.CharField(max_length=64, help_text="Last folio occupied by the item in the source.")
    title = models.CharField(max_length=256, help_text="Title of the item (incipit).")
    language = models.ManyToManyField(Language)
    file = models.CharField(max_length=64, help_text="Filename (without extensions).", null=True)
    IIIF_canvas = models.CharField(max_length=256, help_text="IIIF canvas index of the item.", blank=True)
    alternative_img_link = models.CharField(max_length=1024, help_text="Alternative link for source images (if IIIF is not available).", blank=True)

    class Meta:
        ordering = [Length('abstract_item__cb_id'), 'abstract_item__cb_id']

    def foliation_str(self):
        if self.foliation_start == self.foliation_end:
            return self.foliation_start
        else:
            return self.foliation_start + "-" + self.foliation_end

    def __str__(self):
        """String for representing the Model object (in Admin site etc.)"""
        res = f"{self.abstract_item.__str__()} {self.title} ({self.source.bib_id}, {self.foliation_str()})"
        return res

    def get_absolute_url(self):
        """Returns the URL to access a particular instance of the model."""
        return reverse('item-detail', args=[str(self.pk)])

    @property
    def is_translated(self):
        import os.path
        if os.path.isfile(staticfile_path('tei', self.file + '_PB.tei')):
            return True
        else:
            return False

    @property
    def is_svg_based(self):
        import os.path
        if os.path.isfile(staticfile_path('img', self.file + '.svg')):
            return True
        else:
            return False

    @property
    def tei_path(self):
        return staticfile_path('tei', self.file + ".tei")

    @property
    def mei_path(self):
        return staticfile_path('mei', self.file + ".mei")

    @property
    def svg_path(self):
        return 'img/' + self.file + ".svg"

    @property
    def tei_tree(self):
        from lxml import etree
        return etree.parse(self.tei_path)

    @property
    def is_notated(self):
        if self.tei_tree.find(".//neume") is not None:
            return True
        else:
            return False

    def count_neumes(self, n):
        # Counts the neumes of type n in the piece
        return len(self.tei_tree.findall(f".//neume[@glyph.num='{n}']"))

    def contains_words(self, words):
        # returns true if the text contains ALL the words in the given list
        tree = self.tei_tree
        self_words = []
        locations = ["p", "l", "seg[@type='hemistich']", "stage"]
        locations += [location + "/app[@type='text']/lem" for location in locations]
        for location in locations:
            for word in tree.findall(".//" + location + "/w"):
                syllables = word.xpath("./seg[@type='syll']|./app[@type='neume']/lem/seg[@type='syll']")
                if not len(syllables):
                    # a non syllabated word
                    self_words.append(word.text.lower())
                else:
                    self_words.append("".join([syllable.text for syllable in syllables]).lower())

        # cleaning german diphthongs
        diphthongs = {'uͤ': 'u', 'uͦ': 'u', 'oͤ': 'o', 'oͧ': 'o', 'aͧ': 'a', 'iͤ': 'i'}
        for key in diphthongs.keys():
            self_words = [word.replace(key, diphthongs[key]) for word in self_words]

        return len(set(words).intersection(set(self_words))) == len(words)

    def transform(self, xsl_file, tei_file, indent=False, met=False):
        # Given the xsl file (only filename, no path), transforms item's tei file
        # IMPORTANT: the xsl file must produce a tree with one root
        from lxml import etree, html
        xsl = etree.parse(staticfile_path('xsl', xsl_file))
        transform = etree.XSLT(xsl)
        xml = etree.parse(staticfile_path('tei', tei_file + '.tei'))
        if met:
            metify(xml)
        result = transform(xml)
        if indent:
            indentify(result)
        try:
            return lxml.html.tostring(result).decode('UTF-8')
        except:
            print("Error: not able to convert")
            return ''

    def neume_detail_transform(self, n):
        from lxml import etree, html
        xsl = etree.parse(staticfile_path('xsl', 'neume_detail.xsl'))
        transform = etree.XSLT(xsl)
        try:
            return lxml.html.tostring(transform(etree.parse(self.tei_path), n=str(n))).decode('UTF-8')
        except:
            return ''

    @property
    def continuous_transform(self):
        return self.transform('continuous.xsl', self.file)

    @property
    def formatted_transform(self):
        return self.transform('formatted.xsl', self.file, indent=True, met=True)

    @property
    def neume_apparatus_transform(self):
        return self.transform('neume-apparatus.xsl', self.file)

    @property
    def text_apparatus_transform(self):
        return self.transform('text-apparatus.xsl', self.file)

    @property
    def french_translation_transform(self):
        return self.transform('french-translation.xsl', self.file + '_PB')


class Neume(models.Model):
    n = models.IntegerField()
    description = models.CharField(max_length=200, help_text="Description of the glyph.")

    def __str__(self):
        """String for representing the Model object (in Admin site etc.)"""
        res = f"{self.n} {self.description}"
        return res

    @property
    def svg_path(self):
        return f"buranus{self.n}.svg"

    def get_absolute_url(self):
        """Returns the URL to access a particular instance of the model."""
        return reverse('neume-detail', args=[str(self.pk)])
