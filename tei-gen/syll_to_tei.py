#!/usr/bin/env python3

# Converts a syllabified .syll file into a TEI file (without musical content).
# This generates a preliminary file used for discussing neumes in detail.
# The finer textual structure and critical apparatus are added at a later stage

import argparse

from utils import strophe_parser, in_out_filenames
from text_layout import *


if __name__ == "__main__":
	parser = argparse.ArgumentParser()
	parser.add_argument('filename', nargs='+')

	args = parser.parse_args()

	for name in args.filename:
		in_filename, out_filename = in_out_filenames(name=name, in_extension="syll", out_extension="tei")
		print(f"Reading from input file syll/{in_filename}")

		in_file = open(f"syll/{in_filename}", 'r')
		out_file = open(f"tei/{out_filename}", 'w')

		poem = ET.Element("div", {'type': 'poem'})
		poem.extend([Strophe(x, n=i + 1).tei() for (i, x) in enumerate(strophe_parser(in_file))])

		body = ET.Element("body")
		body.append(poem)

		text = ET.Element("text")
		text.append(body)

		tei = ET.Element("TEI")
		tei.append(ET.Element("teiHeader"))
		tei.append(text)

		ET.indent(tei)
		out_file.write(ET.tostring(tei, encoding="unicode", method="html"))
		out_file.close()

		print(f"Output written on output file tei/{out_filename}")