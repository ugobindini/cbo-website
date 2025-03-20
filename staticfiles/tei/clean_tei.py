#!/usr/bin/env python3

# Generic program to handle large corrections/updates/modifications of TEI files

from buranus_dict import NABC_TO_FONT_ID

import os
import argparse
import xml.etree.ElementTree as ET

if __name__ == "__main__":
	parser = argparse.ArgumentParser()
	parser.add_argument('--f', nargs='+')
	parser.add_argument('--all', action='store_true', default=False)
	args = parser.parse_args()

	filenames = []

	if args.all:
		filenames = [file for file in os.listdir(".") if file.endswith(".tei")]
	else:
		filenames = [name + ".tei" for name in args.f]

	for name in filenames:
		tei_file = open(name, 'r')
		tree = ET.parse(tei_file)
		tei_file.close()

		# Add core code modifying the tree here!

		for neume in tree.getroot().findall(".//neume"):
			try:
				label = neume.attrib['label']
			except:
				print(name)
				print(neume.attrib['label'])

			if '>' in label:
				neume.set('label', label.replace('>', ')'))

		tei_file = open(name, 'w')
		ET.indent(tree)
		tree.write(tei_file, encoding="unicode")
		tei_file.close()
