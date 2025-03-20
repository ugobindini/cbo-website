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
	"pe!po": 41,
	"pe!pm": 42,
	"an": 43,
	"cl": 44,
	"cl)": 45,
	"cl/": 46,
	"cl!st": 47,
	"clpp2": 48,
	"clsu2": 49,
	"to": 50,
	"to!or": 51,
	"to!pm": 52,
	"po": 53,
	"qi": 54,
	"qi)": 55,
	"qi!cl": 56,
	"qi!clsu1": 57,
	"qi!clsu2": 58,
	"qipp1!clsu1!st": 59,
	"qipp1!cl": 60,
	"qi!cl!st": 61,
	"qipp1!cl!st": 62,
	"qi!po": 63,
	"qipp1!cl!or": 64,
	"qi!or": 65,
	"qi!pr": 66,
	"qipp1": 67,
	"qisu2": 68,
	"qipp1su2": 69,
	"qisu2-": 70,
	"qipp1su2-": 71,
	"qisu2!st": 72,
	"qipp1su2!st": 73,
	"qisu3": 74,
	"qisu3-": 75,
	"qipp1su3-": 76,
	"qisu4-": 77,
	"qi!ansu2": 78,
	"ql": 79,
	"ql)": 80,
	"ql!an": 81,
	"ql!cl": 82,
	"qlpp1!cl": 83,
	"ql!cl!or": 84,
	"ql!clsu1": 85,
	"ql!cl!st": 86,
	"qlpp1!cl!st": 87,
	"ql!po": 88,
	"qlpp1!po": 89,
	"ql!or": 90,
	"ql!pr": 91,
	"qlsu2": 92,
	"qlpp1su2": 93,
	"qlsu2-": 94,
	"qlsu3": 95,
	"qlsu3-": 96,
	"qlpp1su3-": 97,
	"qlsu2!st": 98,
	"qlpp1su2!st": 99,
	"qlpp1su4-": 100,
	"qlpp1": 101,
	"qs": 102,
	"qssu3": 103,
	"ci": 104,
	"ci/": 105,
	"ci°": 106,
	"ci!st": 107,
	"cipp2": 108,
	"cipp2!st": 109,
	"sc": 110,
	"sc-": 111,
	"sc)": 112,
}