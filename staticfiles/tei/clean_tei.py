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

		for word in tree.findall(".//w"):
			syllables = word.findall(".//seg[@type='syll']")
			if len(syllables):
				last_syllable = syllables[-1]
				if last_syllable.text[-1] in ['.', ',', ';', ':', '!', '?']:
					parent = word.getparent()
					index = list(parent).index(word)
					pc = ET.fromstring("<pc>" + last_syllable.text[-1] + "</pc>")
					pc.set("resp", "#editor")
					pc.tail = word.tail
					parent.insert(index + 1, pc)
					last_syllable.text = last_syllable.text[:-1]

		#####

		tree.write(name)
