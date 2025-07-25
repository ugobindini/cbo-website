# Classes to handle text layouts.

import xml.etree.ElementTree as ET
from typing import Union

from utils import n_to_roman

tex_caesura = "{\\caesura}"
tex_verse_break = "{\\versebreak}"
tex_strophe_break = "{\\strophebreak}"
tex_ms_break = "{\\msbreak}"

class PunctuationCharacter:
    def __init__(self, char: str):
        self.char = char

    def tei(self):
        pc = ET.Element("pc", attrib={'resp': '#editor'})
        pc.text = self.char
        return pc

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

        # check for punctuation characters
        self.pc = None
        x = 1
        char = ""
        while x <= len(word) and not word[-x].isalpha():
            char += word[-x]
            x += 1
        if len(char):
            self.pc = PunctuationCharacter(char)

        # remove punctuation from last syllable and from word
        if x > 1:
            self.word = self.word[:-x+1]
            syllables[-1] = syllables[-1][:-x+1]

        if len(syllables) <= 1:
            self.syllables = [Syllable(syl) for syl in syllables]
        else:
            self.syllables = [Syllable(syllables[0], part='I')] + [Syllable(syl, part='M') for syl in syllables[1:-1]] + [Syllable(syllables[-1], part='F')]


    def tex(self):
        return "".join([syllable.tex() for syllable in self.syllables])

    def tei(self, plain):
        # returns a list, because sometimes we have to admit <pc> elements as well
        w = ET.Element("w")
        if plain <= 1:
            w.text = self.word
        else:
            w.extend([syllable.tei() for syllable in self.syllables])
        if self.pc is not None:
            return [w, self.pc.tei()]
        else:
            return [w]


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

    def tei(self, plain):
        segment = ET.Element("seg", attrib={'type': 'hemistich'})
        if plain == 0:
            segment.text = self.segment
        else:
            import itertools
            segment.extend(list(itertools.chain.from_iterable([word.tei(plain) for word in self.words])))
        return segment


class Verse:
    def __init__(self, verse: str, n: int):
        """
        Initialize a verse.
        :param str verse: A string representing one syllabified verse (possibly containing a caesura '|').
        """
        self.n = n
        self.verse = verse
        self.split = False
        if verse.__contains__("|"):
            self.split = True
            self.segments = [Segment(s) for s in verse.split("|")]
        else:
            self.words = [Word(w) for w in verse.split(" ") if len(w)]

    def tex(self):
        if self.split:
            return tex_caesura.join([segment.tex() for segment in self.segments]) + tex_verse_break
        else:
            return " ".join([word.tex() for word in self.words]) + tex_verse_break

    def tei(self, plain):
        verse = ET.Element("l", attrib={'n': str(self.n)})
        if self.split:
            verse.extend([segment.tei(plain) for segment in self.segments])
        else:
            if plain == 0:
                verse.text = self.verse
            else:
                import itertools
                verse.extend(list(itertools.chain.from_iterable([word.tei(plain) for word in self.words])))
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

    def tei(self, plain=2):
        # If plain is 0, verses are kept without splitting words (used to encode Pascale's translations).
        # If plain is 1, words are not split into syllables (used to encode the text of non-neumed pieces for now).
        # If plain is 2 (or more), words are split into syllables.
        strophe = ET.Element("lg", attrib={'type': 'strophe', 'n': n_to_roman(self.n)})
        strophe.extend([verse.tei(plain) for verse in self.verses])
        return strophe
