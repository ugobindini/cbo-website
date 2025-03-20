#!/usr/bin/env python3

# Generic program to handle large corrections/updates/modifications of TEI files

from buranus_dict import NABC_TO_FONT_ID

import os
import argparse
import xml.etree.ElementTree as ET

if __name__ == "__main__":
	parser = argparse.ArgumentParser()
	parser.add_argument('-v', '--verbose', action='store_true', default=False)
	args = parser.parse_args()

	filenames = [file for file in os.listdir(".") if file.endswith(".tei")]

	for name in filenames:
		tei_file = open(name, 'r')
		tree = ET.parse(tei_file)
		tei_file.close()

		# Recompute glyph number according to the dictionary of the glyphs

		for neume in tree.getroot().findall(".//neume"):
			if neume.attrib['label'] in NABC_TO_FONT_ID.keys():
				if int(neume.attrib['glyph.num']) != NABC_TO_FONT_ID[neume.attrib['label']]:
					# Log the change
					if args.verbose:
						print(f"{name}, {neume.attrib['label']} : {neume.attrib['glyph.num']} -> {NABC_TO_FONT_ID[neume.attrib['label']]}")
					neume.set('glyph.num', str(NABC_TO_FONT_ID[neume.attrib['label']]))
			else:
				# Log the missing glyph
				if args.verbose:
					print(f"{name}, {neume.attrib['label']} : {neume.attrib['glyph.num']} -> 0")
				neume.set('glyph.num', '0')

		tei_file = open(name, 'w')
		ET.indent(tree)
		tree.write(tei_file, encoding="unicode", method="html")
		tei_file.close()
