# common

ARABIC_TO_ROMAN = {}

# nabc generics

SHAPE_TO_NAME = {
    "vi": "virga",
    "pu": "punctum",
    "ta": "tractulus",
    "gr": "gravis",
    "cl": "clivis",
    "pe": "pes",
    "po": "porrectus",
    "to": "torculus",
    "ci": "climacus",
    "sc": "scandicus",
    "pf": "porrectus flexus",
    "sf": "scandicus flexus",
    "tr": "torculus resupinus",
    "st": "stropha",
    "ds": "distropha",
    "ts": "tristropha",
    "tg": "trigonus",
    "bv": "bivirga",
    "tv": "trivirga",
    "pr": "pressus maior",
    "pi": "pressus minor",
    "vs": "virga strata",
    "or": "oriscus",
    "sa": "salicus",
    "pq": "pes quassus",
    "qi": "quilisma, with 2 loops",
    "ql": "quilisma, with 3 loops",
    "qs": "quilisma, with 4 loops",
    "pt": "pes stratus"
}

# xml specifics

BASIC_SHAPES = {} # for each basic_shape, a list of the components
# these include combinations with ! and modifications, prepuncta and subpuncta

MELODIC_INTERVALS = ['u', 'd', 's', 'n', 'sd', 'su']

EPISEMA = 0
LIQUESCENT = 1
ORISCUS = 2
QUILISMA = 3
STROPHICUS = 4

MODIFIERS = [EPISEMA, LIQUESCENT, ORISCUS, QUILISMA, STROPHICUS]

MODIFIER_TO_MEI_TAG = {
    EPISEMA: "episema",
    LIQUESCENT: "liquescent",
    ORISCUS: "oriscus",
    QUILISMA: "quilisma",
    STROPHICUS: "strophicus"
}

MODIFIER_TO_REPR_STR = {
    EPISEMA: "-",
    LIQUESCENT: "°",
    ORISCUS: "~",
    QUILISMA: "^",
    STROPHICUS: "'"
}

# buranus font

NABC_TO_FONT_ID = {
	'?': 0,
	"pu": 1,
	"tr": 2,
	"st": 3,
	"ds": 4,
	"ts": 5,
	"vi": 6,
	"vi)": 7,
	"vi*": 8,
	"vs": 9,
	"pr": 10,
	"pr!st": 11,
	"vi!or!pu": 12,
	"vssu2": 13,
	"vssu2!st": 14,
	"vi)su1": 15,
	"vi)su2": 16,
	"visu2-": 17,
	"visu3": 18,
	"visu3-": 19,
	"visu3!st": 20,
	"visu4": 21,
	"visu3°": 22,
	"visu4-": 23,
	"visu5": 24,
	"vi/": 25,
	"vi)/": 26,
	"visu3-!st": 27,
	"ep": 28,
	"eppp1": 29,
	"pe": 30,
	"pe)": 31,
	"pesu2": 32,
	"pesu2-": 33,
	"pesu2!st": 34,
	"pesu3": 35,
	"pesu3-": 36,
	"pesu4-": 37,
	"pesu3!st": 38,
	"pesu3-!st": 39,
	"pepp1": 40,
	"pe)pp1": 41,
	"pe!po": 42,
	"pe!pm": 43,
	"an": 44,
	"cl": 45,
	"cl)": 46,
	"cl/": 47,
	"cl!st": 48,
	"clpp2": 49,
	"clsu2": 50,
	"to": 51,
	"to!or": 52,
	"to!pm": 53,
	"po": 54,
	"qi": 55,
	"qi)": 56,
	"qi!cl": 57,
	"qi!clsu1": 58,
	"qi!clsu2": 59,
	"qipp1!clsu1!st": 60,
	"qipp1!cl": 61,
	"qi!cl!st": 62,
	"qipp1!cl!st": 63,
	"qi!po": 64,
	"qipp1!cl!or": 65,
	"qi!or": 66,
	"qi!pr": 67,
	"qipp1": 68,
	"qisu2": 69,
	"qipp1su2": 70,
	"qisu2-": 71,
	"qipp1su2-": 72,
	"qisu2!st": 73,
	"qipp1su2!st": 74,
	"qisu3": 75,
	"qisu3-": 76,
	"qipp1su3-": 77,
	"qisu4-": 78,
	"qi!ansu2": 79,
	"ql": 80,
	"ql)": 81,
	"ql!an": 82,
	"ql!cl": 83,
	"qlpp1!cl": 84,
	"ql!cl!or": 85,
	"ql!clsu1": 86,
	"ql!cl!st": 87,
	"qlpp1!cl!st": 88,
	"ql!po": 89,
	"qlpp1!po": 90,
	"ql!or": 91,
	"ql!pr": 92,
	"qlsu2": 93,
	"qlpp1su2": 94,
	"qlsu2-": 95,
	"qlsu3": 96,
	"qlsu3-": 97,
	"qlpp1su3-": 98,
	"qlsu2!st": 99,
	"qlpp1su2!st": 100,
	"qlpp1su4-": 101,
	"qlpp1": 102,
	"qs": 103,
	"qssu3": 104,
	"ci": 105,
	"ci/": 106,
	"ci°": 107,
	"ci!st": 108,
	"cipp2": 109,
	"cipp2!st": 110,
	"sc": 111,
	"sc-": 112,
	"sc)": 113,
}