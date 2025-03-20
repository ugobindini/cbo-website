# Classes to handle text layouts.

import xml.etree.ElementTree as ET
from typing import Union

from utils import n_to_roman

tex_caesura = "{\\caesura}"
tex_verse_break = "{\\versebreak}"
tex_strophe_break = "{\\strophebreak}"
tex_ms_break = "{\\msbreak}"

class Syllable:
    def __init__(self, syllable: str, part: Union[str, None] = None):
        """
        Initialize a syllable.
        :param str syllable: The textual content.
        """
        self.text = syllable
        self.part = part

    def tex(self):
        return self.text

    def tei(self):
        segment = ET.Element("seg", attrib={'type': 'syll'})
        segment.text = self.text
        if self.part is not None:
            segment.set('part', self.part)
        return segment


class Word:
    def __init__(self, word: str):
        """
        Initialize a word.
        :param str word: A list of strings representing one syllabified word.
        """
        assert not word.__contains__(" ")
        self.word = word
        syllables = word.split("-")
        if len(syllables) <= 1:
            self.syllables = [Syllable(syl) for syl in syllables]
        else:
            self.syllables = [Syllable(syllables[0], part='I')] + [Syllable(syl, part='M') for syl in syllables[1:-1]] + [Syllable(syllables[-1], part='F')]

    def tex(self):
        return "".join([syllable.tex() for syllable in self.syllables])

    def tei(self, plain=False):
        segment = ET.Element("w")
        if plain:
            segment.text = self.word
        else:
            segment.extend([syllable.tei() for syllable in self.syllables])
        return segment


class Segment:
    def __init__(self, segment: str):
        """
        Initialize a segment.
        :param str segment: A string representing one syllabified segment.
        """
        self.segment = segment
        self.words = [Word(w) for w in segment.split(" ") if len(w)]

    def tex(self):
        return " ".join([word.tex() for word in self.words])

    def tei(self, plain=False):
        segment = ET.Element("seg", attrib={'type': 'hemistich'})
        if plain:
            segment.text = self.segment
        else:
            segment.extend([word.tei(plain) for word in self.words])
        return segment


class Verse:
    def __init__(self, verse: str, n: int):
        """
        Initialize a verse.
        :param str verse: A string representing one syllabified verse (possibly containing a caesura '|').
        """
        self.n = n
        self.verse = verse
        self.splitted = False
        if verse.__contains__("|"):
            self.splitted = True
            self.segments = [Segment(s) for s in verse.split("|")]
        else:
            self.words = [Word(w) for w in verse.split(" ") if len(w)]

    def tex(self):
        if self.splitted:
            return tex_caesura.join([segment.tex() for segment in self.segments]) + tex_verse_break
        else:
            return " ".join([word.tex() for word in self.words]) + tex_verse_break

    def tei(self, plain=False):
        verse = ET.Element("l", attrib={'n': str(self.n)})
        if self.splitted:
            verse.extend([segment.tei(plain) for segment in self.segments])
        else:
            if plain:
                verse.text = self.verse
            else:
                verse.extend([word.tei() for word in self.words])
        return verse


class Strophe:
    def __init__(self, verses: list[str], n: int):
        """
        Initialize a strophe.
        :param list[str] verses: A list of strings representing syllabified verses.
        """
        self.verses = [Verse(x, i+1) for (i, x) in enumerate(verses)]
        self.n = n

    def tex(self):
        return "".join([verse.tex() for verse in self.verses]) + tex_strophe_break

    def tei(self, plain=False):
        # If plain is set, the verses are kept without splitting words (used to encode non-notated pieces).
        strophe = ET.Element("lg", attrib={'type': 'strophe', 'n': n_to_roman(self.n)})
        strophe.extend([verse.tei(plain) for verse in self.verses])
        return strophe
