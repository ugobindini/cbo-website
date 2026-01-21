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

		for lg in tree.findall(".//lg"):
			for n, line in enumerate(lg.findall("./l")):
				line.attrib['n'] = str(n+1)

		for sp in tree.findall(".//sp"):
			if not len(sp.getchildren()) and sp.text is None:
				sp.text = ''
		for st in tree.findall(".//stage"):
			if not len(st.getchildren()) and st.text is None:
				st.text = ''

		#####
		#####

		tree.write(name)
		# tree.write("test_" + name)
