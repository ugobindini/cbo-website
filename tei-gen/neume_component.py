import xml.etree.ElementTree as ET

from constants import *


class NeumeComponent:
    """
    Represents one note in adiastematic notation
    """
    def __init__(self, intm='n', modifier=None):
        # melodic interval from the previous pitch
        self.intm = intm
        self.modifier = modifier

    def __str__(self):
        res = f"[{self.intm}"
        if self.modifier is not None:
            res += MODIFIER_TO_REPR_STR[self.modifier]
        res += "]"
        return res

    def mei(self):
        nc = ET.Element("nc")
        nc.set("intm", self.intm)
        if self.modifier is not None:
            nc.append(ET.Element(MODIFIER_TO_MEI_TAG[self.modifier]))
        return nc

def intervals_to_components(intervals):
    return tuple(NeumeComponent(intm=intm) for intm in intervals)

def register_basic_shapes():
    BASIC_SHAPES['vi'] = intervals_to_components(['su'])
    BASIC_SHAPES['vi/'] = intervals_to_components(['su'])  # TODO: implement half-tone interval
    BASIC_SHAPES['pu'] = intervals_to_components(['sd'])
    BASIC_SHAPES['pe'] = intervals_to_components(['n', 'u'])
    BASIC_SHAPES['cl'] = intervals_to_components(['n', 'd'])
    BASIC_SHAPES['to'] = intervals_to_components(['n', 'u', 'd'])
    BASIC_SHAPES['po'] = intervals_to_components(['n', 'd', 'u'])
    BASIC_SHAPES['qi'] = (NeumeComponent('su', QUILISMA), NeumeComponent('su'), NeumeComponent('u'))
    BASIC_SHAPES['ql'] = (NeumeComponent('su', QUILISMA), NeumeComponent('su'), NeumeComponent('u'))
    BASIC_SHAPES['ci'] = intervals_to_components(['n', 'd', 'd'])
    BASIC_SHAPES['sc'] = intervals_to_components(['n', 'u', 'u'])
    BASIC_SHAPES['sc-'] = intervals_to_components(['n', 'u', 'u'])
    BASIC_SHAPES['cl/'] = BASIC_SHAPES['cl']  # TODO: signal the strike-through?
    BASIC_SHAPES['or'] = (NeumeComponent('s', ORISCUS),)
    BASIC_SHAPES['sf'] = intervals_to_components(['n', 'u', 'u', 'd'])
    BASIC_SHAPES['st'] = intervals_to_components(['su'])
    BASIC_SHAPES['vs'] = (NeumeComponent('n'), NeumeComponent('su', ORISCUS))  # TODO: the next neume starts with a 'd' note (implement)
    BASIC_SHAPES['pr'] = (NeumeComponent('n'), NeumeComponent('s', ORISCUS), NeumeComponent('d'))
    BASIC_SHAPES['ds'] = intervals_to_components(['n', 's'])
    BASIC_SHAPES['ts'] = intervals_to_components(['n', 's', 's'])
    BASIC_SHAPES['qs'] = (NeumeComponent('su', QUILISMA), NeumeComponent('su'), NeumeComponent('u'))
    BASIC_SHAPES['ep'] = intervals_to_components(['n', 'u'])
    BASIC_SHAPES['tr'] = intervals_to_components(['sd'])

    # composite shapes
    BASIC_SHAPES['pe!or'] = BASIC_SHAPES['pe'] + BASIC_SHAPES['or']
    BASIC_SHAPES['pe!po'] = BASIC_SHAPES['pe'] + BASIC_SHAPES['po'][1:]
    BASIC_SHAPES['to!or'] = BASIC_SHAPES['to'] + BASIC_SHAPES['or']
    BASIC_SHAPES['ci!st'] = BASIC_SHAPES['ci'] + intervals_to_components(['u'])

    # combinations starting with a quilisma
    for key in ['cl', 'or', 'pr', 'vs', 'po']:
        BASIC_SHAPES[f"qi!{key}"] = BASIC_SHAPES['qi'] + BASIC_SHAPES[key][1:]
    for key in ['cl', 'po', 'or', 'pr']:
        BASIC_SHAPES[f"ql!{key}"] = BASIC_SHAPES['ql'] + BASIC_SHAPES[key][1:]
    BASIC_SHAPES['qi!cl!or'] = BASIC_SHAPES['qi!cl'] + BASIC_SHAPES['or']
    BASIC_SHAPES['ql!cl!or'] = BASIC_SHAPES['ql!cl'] + BASIC_SHAPES['or']

    # prepuncta and subpuncta: implementing generously (up to 5 pp and sp)
    for n in range(1, 6):
        for key in ['pe', 'qi', 'qi!cl!or', 'cl', 'ci!st']:
            BASIC_SHAPES[f"{key}pp{n}"] = intervals_to_components(['n'] + ['u'] * n) + BASIC_SHAPES[key][1:]
        for key in ['vi', 'cl', 'pe', 'qi', 'ql', 'ql!cl']:
            BASIC_SHAPES[f"{key}su{n}"] = BASIC_SHAPES[key] + intervals_to_components(['d'] * n)

    # liquescent
    for key in ['pu', 'vi', 'pe', 'qi', 'ql']:
        BASIC_SHAPES[f"{key}>"] = tuple(NeumeComponent(x.intm, x.modifier) for x in BASIC_SHAPES[key])
        BASIC_SHAPES[f"{key}>"][-1].modifier = LIQUESCENT
