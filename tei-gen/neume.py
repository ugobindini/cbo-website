import xml.etree.ElementTree as ET

from constants import BASIC_SHAPES, NABC_TO_FONT_ID

class Neume:
    """
    Represents one graphical element (possibly cursive combination of basic shapes). Corresponds to the MEI tag <neume>
    """

    def __init__(self, nabc_str):
        if not len(BASIC_SHAPES):
            print(f"WARNING: constant BASIC_SHAPES not initialized.")
        self.nabc_str = nabc_str
        if nabc_str in BASIC_SHAPES.keys():
            self.components = BASIC_SHAPES[nabc_str]
        else:
            self.components = tuple()

    def __str__(self):
        # return ''.join([component.__str__() for component in self.components])
        return self.nabc_str

    def font_code(self):
        return NABC_TO_FONT_ID[self.nabc_str]

    def tei(self):
        try:
            glyph_num = NABC_TO_FONT_ID[self.nabc_str]
        except:
            glyph_num = 0
            if self.nabc_str != '?':
                print(f"WARNING: unrecognized shape {self.nabc_str}")
        return ET.Element("neume", attrib={"fontname": "buranus", "glyph.num": str(glyph_num), "label": self.nabc_str})

    def mei(self):
        neume = self.tei()
        # Commenting for now, in order to work with lighter and more readable files.
        # The components can be added at once in post-processing
        # neume.extend([component.mei() for component in self.components])
        return neume

    def tex(self):
        return "\\BuranusNeume{" + str(NABC_TO_FONT_ID[self.nabc_str]) + "}"

    def html(self):
        return ET.Element("img", attrib={"class": "neume", "src": f"img/svg/buranus{self.font_code()}.svg"})