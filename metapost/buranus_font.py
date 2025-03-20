#!/usr/bin/env python3

from glyphs import GLYPHS
from paths import PATHS

if __name__ == "__main__":
	mp_file = open('buranus.mp', 'w')

	mp_file.write("prologues := 3;\n")
	mp_file.write('outputtemplate := "%j%c.eps";\n\n')
	mp_file.write("u = 1pt;\n\n")

	for path in PATHS:
		mp_file.write(path.metapost_init() + "\n\n")

	for (n, glyph) in enumerate(GLYPHS):
		mp_file.write(f"beginfig({n+1});\n")
		mp_file.write(glyph.metapost() + "\n")
		mp_file.write(f"endfig;\n\n")

	mp_file.write("bye")

	mp_file.close()


