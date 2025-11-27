import lxml.etree
from django.db import models
from django.urls import reverse
from django.db.models import UniqueConstraint, F
from django.db.models.functions import Lower, Length
from .static_path import static_path
from .indentify import indentify
from .metify import metify


class Language(models.Model):
    """Model representing a language."""
    name = models.CharField(max_length=200, unique=True, help_text="The language (e.g. Latin, Middle High German, etc.)")

    def get_absolute_url(self):
        """Returns the URL to access a particular instance of the model."""
        return reverse('language-detail', args=[str(self.pk)])

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
        return reverse('author-detail', args=[str(self.pk)])

    def __str__(self):
        """String for representing the Model object (in Admin site etc.)"""
        return self.name


class Genre(models.Model):
    """Model representing a genre."""
    name = models.CharField(max_length=200, unique=True, help_text="The genre (e.g. Song, Liturgical chant, Versus, etc.)")

    def get_absolute_url(self):
        """Returns the URL to access a particular instance of the model."""
        return reverse('genre-detail', args=[str(self.pk)])

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
        return reverse('theme-detail', args=[str(self.pk)])

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
        return reverse('source-detail', args=[str(self.pk)])

    def __str__(self):
        """String for representing the Model object (in Admin site etc.)"""
        res = f"{self.location}, {self.bib_id}"
        if len(str(self.nick_name)):
            res += f" {self.nick_name}"
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
        return reverse('abstract-item-detail', args=[str(self.pk)])


class Item(models.Model):
    """An item's instance."""
    abstract_item = models.ForeignKey(AbstractItem, on_delete=models.PROTECT, null=True)
    source = models.ForeignKey(Source, on_delete=models.RESTRICT, null=True)
    foliation_start = models.CharField(max_length=64, help_text="First folio occupied by the item in the source.")
    foliation_end = models.CharField(max_length=64, help_text="Last folio occupied by the item in the source.")
    title = models.CharField(max_length=256, help_text="Title of the item (incipit).")
    language = models.ManyToManyField(Language)
    file = models.CharField(max_length=64, help_text="Filename (without extensions).", null=True)
    IIIF_canvasIndex = models.CharField(max_length=256, help_text="IIIF canvas index of the item (integer).", blank=True)
    IIIF_canvasId = models.CharField(max_length=256, help_text="IIIF canvas @id of the item (string), alternative to the previous field.", blank=True)
    alternative_img_link = models.CharField(max_length=1024, help_text="Alternative link for source images (if IIIF is not available).", blank=True)

    class Meta:
        # Exploiting that the Codex Buranus and Fragmenta Burana have pk 106 and 107
        ordering = [Length('abstract_item__cb_id'), 'abstract_item__cb_id', (106.5 - F('source__pk')) ** 2]

    def __str__(self):
        """String for representing the Model object (in Admin site etc.)"""
        res = f"{self.abstract_item.__str__()} {self.title} ({self.source.bib_id}, {self.foliation_str()})"
        return res


    def foliation_str(self):
        if self.foliation_start == self.foliation_end:
            return self.foliation_start
        else:
            return self.foliation_start + "-" + self.foliation_end


    @property
    def in_codex_buranus(self):
        # Exploiting that the Codex Buranus and Fragmenta Burana have pk 106 and 107
        return 106 <= self.source.pk <= 107

    def get_absolute_url(self):
        """Returns the URL to access a particular instance of the model."""
        return reverse('item-detail', args=[str(self.pk)])

    @property
    def has_concordances(self):
        return len(self.abstract_item.item_set.all()) > 1
    @property
    def is_translated(self):
        import os.path
        if os.path.isfile(static_path(f"tei/{self.file}_PB.tei")):
            return True
        else:
            return False

    @property
    def is_svg_based(self):
        import os.path
        if os.path.isfile(static_path(f"img/mscz/svg/{self.file}.svg")) or os.path.isfile(static_path(f"img/mscz/svg/{self.file}-1.svg")):
            return True
        else:
            return False

    @property
    def tei_path(self):
        return static_path(f"tei/{self.file}.tei")

    @property
    def mei_path(self):
        return static_path(f"mei/{self.file}.mei")

    def svg_files(self):
        import os
        # Order files: this assumes that each piece has less than 9 pages.
        files = [file for file in os.listdir(static_path("img/mscz/svg")) if file.startswith(self.file)]
        files.sort(key=lambda x: x[-5])
        return files

    @property
    def svg_template(self):
        svg_files = self.svg_files()
        template = ''.join(['<img src="/staticfiles/img/mscz/svg/' + file + '" style="width: 100%; margin-bottom: -12.5%;"/>' for file in svg_files[:-1]])
        template += '<img src="/staticfiles/img/mscz/svg/' + svg_files[-1] + '" style="width: 100%;"/>'
        return template

    def pdf_template(self):
        svg_files = self.svg_files()
        template = ''.join(['<img src="/staticfiles/img/mscz/svg/' + file + '" style="width: 100%;"/>' for file in svg_files])
        return template

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

    def words(self, exclude_apparatus=True, cleaned=True):
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
                    words.append(word.text.lower())
                else:
                    words.append("".join([syllable.text for syllable in syllables]).lower())

        if cleaned:
            # cleaning german diphthongs
            diphthongs = {'uͤ': 'u', 'uͦ': 'u', 'oͤ': 'o', 'oͧ': 'o', 'aͧ': 'a', 'iͤ': 'i'}
            for key in diphthongs.keys():
                words = [word.replace(key, diphthongs[key]) for word in words]

        return words

    def contains_words(self, words, exclude_apparatus, match_word_beginning, match_word_end, match_word_middle):
        # returns true if the text contains ALL the words in the given list
        n = 0
        for key in words:
            for word in self.words(exclude_apparatus=exclude_apparatus):
                if match_word_beginning and word.startswith(key) or match_word_end and word.endswith(key):
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

    def transform(self, xsl_file, tei_file=None, indent=False, met=False, n=None):
        # Given the xsl file (only filename, no path), transforms item's tei file
        # IMPORTANT: the xsl file must produce a tree with one root
        from lxml import etree, html
        if not tei_file:
            tei_file = self.file
        xsl = etree.parse(static_path(f"xsl/{xsl_file}"))
        transform = etree.XSLT(xsl)
        xml = etree.parse(static_path(f"tei/{tei_file}.tei"))
        if n:
            # Used for NeumeDetail view
            result = transform(xml, n=str(n))
        else:
            if met:
                metify(xml)
            result = transform(xml)
            if indent:
                indentify(result)

        try:
            res = lxml.html.tostring(result).decode('UTF-8')
            # Add the static prefix to all neume images (difficult/impossible to do in xslt)
            # Not clean, but the tree representation was not working
            return res.replace('src="buranus', 'src="/staticfiles/img/glyphs/svg/buranus')
        except:
            print("Error: not able to convert")
            return ''

    @property
    def continuous_transform(self):
        return self.transform('continuous.xsl')

    @property
    def formatted_transform(self):
        return self.transform('formatted.xsl', indent=True, met=True)

    @property
    def neume_apparatus_transform(self):
        return self.transform('neume-apparatus.xsl')

    @property
    def text_apparatus_transform(self):
        return self.transform('text-apparatus.xsl')

    @property
    def french_translation_transform(self):
        return self.transform('french-translation.xsl', tei_file=self.file + '_PB')


class Neume(models.Model):
    n = models.IntegerField()
    description = models.CharField(max_length=1024, help_text="Description of the glyph.")
    count = models.IntegerField()
    pattern = models.CharField(max_length=32, help_text="Melodic pattern.", null=True, blank=True)

    def __str__(self):
        """String for representing the Model object (in Admin site etc.)"""
        res = f"{self.n} {self.description}"
        return res

    class Meta:
        ordering = ['n']

    @property
    def svg_path(self):
        return f"img/glyphs/svg/buranus{self.n}.svg"

    @property
    def eps_path(self):
        return f"img/glyphs/eps/buranus{self.n}.eps"

    def get_absolute_url(self):
        """Returns the URL to access a particular instance of the model."""
        return reverse('neume-detail', args=[str(self.pk)])

