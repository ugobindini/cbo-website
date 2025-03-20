from itertools import groupby


def n_to_roman(n):
    """
    Convert arabic integers to roman numerals
    """
    num = [1, 4, 5, 9, 10, 40, 50, 90, 100, 400, 500, 900, 1000]
    sym = ["I", "IV", "V", "IX", "X", "XL", "L", "XC", "C", "CD", "D", "CM", "M"]
    i = len(num)-1
    res = ""

    while n:
        div = n // num[i]
        n %= num[i]
        res += sym[i] * div
        i -= 1

    return res


def strophe_parser(file):
    """
    Parse strophes from a text file where strophes are separated by double newline characters.
    Each strophe is returned as a list of strings (verses).
    """
    lines = file.read().splitlines()

    for key, strophe in groupby(lines, lambda x: len(x) > 0):
        # Group verses of positive length to form each strophe
        if key:
            yield list(strophe)


def in_out_filenames(name, in_extension, out_extension):
    if name.endswith(f".{in_extension}"):
        # if the given filename already contains the in_extension
        in_filename = name
        out_filename = f"{name.split('.')[0]}.{out_extension}"
    else:
        # the given filename should be without extension
        assert '.' not in name, 'Invalid file name.'
        in_filename = f"{name}.{in_extension}"
        out_filename = f"{name}.{out_extension}"

    return in_filename, out_filename


def met_parser(met_file):
    """
    Parser for a .met file
    """
    res = []

    for strophe in strophe_parser(met_file):
        if strophe[0].endswith('x') and not strophe[0].startswith('@'):
            # there is a muliplier
            assert strophe[0][0].isnumeric()
            n = int(strophe[0][:-1])
            for i in range(n):
                res.append(strophe[1:])
        else:
            res.append(strophe)

    return res

def neu_parser(neu_file):
    """
    Parser for a .neu file
    """
    res = []
    for strophe in strophe_parser(neu_file):
        if len(strophe) == 1 and strophe[0] == '--':
            res.append([])
        else:
            res.append(strophe)
    return res

def last_stressed_syllable_index(met):
    """
    Given a metric symbol (4p, A3-, ...) returns the index (negative) of the last stressed syllable
    """
    if met.endswith('pp'):
        return -3
    elif met.endswith('p'):
        return -2
    elif met.endswith('-'):
        return -2
    else:
        return -1