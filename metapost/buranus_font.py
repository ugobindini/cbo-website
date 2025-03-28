#!/usr/bin/env python3

import json

from glyphs import GLYPHS
from paths import PATHS

if __name__ == "__main__":
	# Export to .mp file
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

	# Export to local and static .json file
	for filename in ['buranus.json', '../staticfiles/json/buranus.json']:
		json_file = open(filename, 'w')
		json_file.write(json.dumps([glyph.json(n+1) for (n, glyph) in enumerate(GLYPHS)], indent=2))
		json_file.close()

