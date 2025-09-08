#!/usr/bin/env python3

# Generic program to handle large corrections/updates/modifications of TEI files

import lxml.etree as ET

import os
import argparse
# import xml.etree.ElementTree as ET

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
		#####
		#####

		for stage in tree.findall(".//stage"):
			text = stage.text
			for word in reversed(text.split(' ')):
				w = ET.Element('w')
				w.text = word
				stage.insert(index=0, element=w)
			stage.text = ""

		#####
		#####

		tree.write("test_" + name)
