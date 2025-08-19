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


# Old models for the text type (obsolete)
# class TextType(models.Model):
#     """Model representing a text type (metrical poetry, rhythmic poetry, prose)."""
#     METRICAL_POETRY = "Metrical poetry"
#     RHYTHMICAL_POETRY = "Rhythmical poetry"
#     PROSE = "Prose"
#     TYPE_CHOICES = [
#         (METRICAL_POETRY, "Metrical poetry"),
#         (RHYTHMICAL_POETRY, "Rhythmical poetry"),
#         (PROSE, "Prose")
#     ]
#     type = models.CharField(max_length=20, choices=TYPE_CHOICES)
#
#     def get_absolute_url(self):
#         """Returns the URL to access a particular instance of the model."""
#         return reverse('text-type-detail', args=[str(self.id)])
#
#     def __str__(self):
#         """String for representing the Model object (in Admin site etc.)"""
#         return self.type
#
#     class Meta:
#         ordering = ['type']
#
#
# class TextTypeSpecification(models.Model):
#     """Model representing a specification of the text type."""
#     text_type = models.ForeignKey(TextType, on_delete=models.CASCADE)
#     abstract_item = models.ForeignKey("AbstractItem", on_delete=models.CASCADE)
#     HEXAMETER = "HEX"
#     PENTAMETER = "PEN"
#     SEPTENARIUS = "SEP"
#     TRIMETER = "TRI"
#     VERSE_UNIT_CHOICES = [
#         ("", "Unspecified"),
#         (HEXAMETER, "Hexameter"),
#         (PENTAMETER, "Pentameter"),
#         (SEPTENARIUS, "Septenarius"),
#         (TRIMETER, "Trimeter")
#     ]
#     verse_unit = models.CharField(max_length=3, choices=VERSE_UNIT_CHOICES, default="", null=True, blank=True)
#
#     IAMB = "IAM"
#     TROCHEE = "TRO"
#     SPONDEE = "SPO"
#     ANAPEST = "ANA"
#     DAKTYL = "DAK"
#     TYPE_OF_METER_CHOICES = [
#         ("", "Unspecified"),
#         (IAMB, "Iamb"),
#         (TROCHEE, "Trochee"),
#         (SPONDEE, "Spondee"),
#         (ANAPEST, "Anapest"),
#         (DAKTYL, "Daktyl")
#     ]
#     type_of_meter = models.CharField(max_length=3, choices=TYPE_OF_METER_CHOICES, default="", null=True, blank=True)
#
#     ISOMETRIC = "ISO"
#     HETEROMETRIC = "HET"
#     STROPHIC_CHOICES = [
#         ("", "Not strophic"),
#         (ISOMETRIC, "Isometric"),
#         (HETEROMETRIC, "Heterometric")
#     ]
#     strophic = models.CharField(max_length=3, choices=STROPHIC_CHOICES, default="", null=True, blank=True)
#
#     refrain = models.BooleanField()
#
#     def get_absolute_url(self):
#         """Returns the URL to access a particular instance of the model."""
#         return reverse('text-type-specification-poetry-detail', args=[str(self.id)])
#
#     def __str__(self):
#         """String for representing the Model object (in Admin site etc.)"""
#         return f"{self.verse_unit}, {self.type_of_meter}, {self.strophic}, refrain: {self.refrain}"


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
    IIIF_canvasIndex = models.CharField(max_length=256, help_text="IIIF canvas index of the item.", blank=True)
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
        if os.path.isfile(staticfile_path('img/mscz/', self.file + '.svg')):
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
        return 'img/mscz/' + self.file + ".svg"

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
        if self.is_svg_based:
            return 0
        else:
            return len(self.tei_tree.findall(f".//neume[@glyph.num='{n}']"))

    def words(self, exclude_apparatus, cleaned=True):
        # returns a list of all words in the piece
        # if cleaned, then the german diphthongs are converted to the base vowel
        # TODO: possibly, if this slows down the search a lot, compute it once and for all and pickle it to a static file
        tree = self.tei_tree
        words = []
        for word in tree.xpath(".//w"):
            if exclude_apparatus and (word.xpath("./ancestor::rdg") or word.xpath("./ancestor::note")):
                # exclude words in app-readings or app-notes
                pass
            else:
                syllables = word.xpath("./seg[@type='syll']|./app[@type='neume']/lem/seg[@type='syll']")
                if not len(syllables):
                    # a non syllabated word
                    words.append(word.text.lower())
                else:
                    words.append("".join([syllable.text for syllable in syllables]).lower())

        if cleaned:
            # cleaning german diphthongs
            diphthongs = {'uͤ': 'u', 'uͦ': 'u', 'oͤ': 'o', 'oͧ': 'o', 'aͧ': 'a', 'iͤ': 'i'}
            for key in diphthongs.keys():
                words = [word.replace(key, diphthongs[key]) for word in words]
        return words

    def metrics(self, through_strophe_break=False):
        # return a list of strings: one string ('/'-separated, with a final slash) for each 'poem' unit in the item (there can be many, e.g. plays)
        import itertools
        tree = self.tei_tree
        metrics = []
        poem_types = ['poem', 'sequence', 'leich']
        for poem in list(itertools.chain.from_iterable([tree.findall(f".//div[@type='{t}']") for t in poem_types])):
            poem_metrics = ""
            if 'met' in poem.keys():
                poem_met = poem.get('met')
            else:
                poem_met = None
            lg_types = ['strophe', 'refrain', 'versicle']
            for lg in list(itertools.chain.from_iterable([poem.findall(f".//lg[@type='{t}']") for t in lg_types])):
                if 'met' in lg.keys():
                    met = lg.get('met')
                else:
                    assert poem_met is not None, "ERROR: Undefined metric"
                    met = poem_met
                met_list = met.split('/')
                for (n, l) in enumerate(lg.findall(".//l")):
                    if 'met' not in l.keys():
                        poem_metrics += met_list[n] + "/"
                    else:
                        poem_metrics += l.get('met') + "/"
                if not through_strophe_break:
                    poem_metrics += "/"
            metrics.append(poem_metrics.replace('+', '/'))
        return metrics

    def contains_metrics(self, metrics, through_strophe_break=True):
        # returns true if the text contains ALL the metrics in the given list
        for metric in self.metrics(through_strophe_break=through_strophe_break):
            if sum([1 for m in metrics if m + '/' in metric]) == len(metrics):
                return True
        return False

    def contains_words(self, words, exclude_apparatus, match_word_beginning, match_word_end, match_word_middle):
        # returns true if the text contains ALL the words in the given list
        n = 0
        for key in words:
            for word in self.words(exclude_apparatus=exclude_apparatus):
                if match_word_beginning and word.startswith(key):
                    print(self.abstract_item.cb_id, word)
                    n += 1
                    break
                elif match_word_end and word.endswith(key):
                    print(self.abstract_item.cb_id, word)
                    n += 1
                    break
                elif match_word_middle and key in word:
                    print(self.abstract_item.cb_id, word)
                    n += 1
                    break
                elif key == word:
                    print(self.abstract_item.cb_id, word)
                    n += 1
                    break
        return n == len(words)

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
    description = models.CharField(max_length=1024, help_text="Description of the glyph.")
    count = models.IntegerField()

    def __str__(self):
        """String for representing the Model object (in Admin site etc.)"""
        res = f"{self.n} {self.description}"
        return res

    class Meta:
        ordering = ['n']

    @property
    def svg_path(self):
        return f"buranus{self.n}.svg"

    def get_absolute_url(self):
        """Returns the URL to access a particular instance of the model."""
        return reverse('neume-detail', args=[str(self.pk)])

