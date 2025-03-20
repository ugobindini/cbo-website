#!/usr/bin/env python3

# Adds metrical information (metrical-units) from an input .met file to a .tei file, and spreads the top-level information (@met and @rhyme) down to the bottom (verse).
# WARNING: the input .tei file will be overwritten

import argparse
import xml.etree.ElementTree as ET

from utils import in_out_filenames, met_parser, last_stressed_syllable_index


def propagate_metrical_info(strophe, attrib, value):
	verses_value = value.split('/')
	verses = strophe.findall(".//l")
	assert len(verses_value) == len(verses), f"ERROR: metify.py: mismatch in the number of verses."
	for (i, verse) in enumerate(verses):
		verse.set(attrib, verses_value[i])
		hemis = verse.findall(".//seg[@type='hemistich']")
		if len(hemis):
			assert len(hemis) > 1, "ERROR. Verse with only one hemistich"
			if '+' in verses_value[i]:
				# split the information amongst hemistichs
				hemis_value = verses_value[i].split('+')
				for (j, hemi) in enumerate(hemis):
					hemi.set(attrib, hemis_value[j])
			else:
				# only set the last hemistich
				hemis[-1].set(attrib, verses_value[i])


if __name__ == "__main__":
	parser = argparse.ArgumentParser()
	parser.add_argument('filename', nargs='+')

	args = parser.parse_args()

	for name in args.filename:
		met_filename, tei_filename = in_out_filenames(name=name, in_extension="met", out_extension="tei")
		print(f"Reading metrical information from input file met/{met_filename}")

		tei_file = open(f"tei/{tei_filename}", 'r')
		tree = ET.parse(tei_file)

		# First step: propagate information from the divs of @type 'poem' to the strophes

		for div in tree.getroot().findall(".//div[@type='poem']"):
			try:
				met = div.get('met')
			except:
				print("WARNING: Attribute @met not specified in div of type @poem")
			try:
				rhyme = div.get('rhyme')
			except:
				print("WARNING: Attribute @rhyme not specified in div of type @poem")

			strophes = div.findall(".//lg[@type='strophe']") + div.findall(".//lg[@type='refrain']")
			for strophe in strophes:
				if 'met' not in strophe.keys():
					strophe.set('met', met)
				else:
					met = strophe.get('met')
				if 'rhyme' not in strophe.keys():
					strophe.set('rhyme', rhyme)
				else:
					rhyme = strophe.get('rhyme')
				propagate_metrical_info(strophe, attrib='met', value=met)
				propagate_metrical_info(strophe, attrib='rhyme', value=rhyme)

		# Second step: signal the last accented syllable of each verse/hemistich by setting @met='+'.

		for x in tree.getroot().findall(".//l") + tree.getroot().findall(".//seg[@type='hemistich']"):
			syllables = x.findall("./seg[@type='word']/seg[@type='syll']")
			if len(syllables) and x.get('met') is not None:
				i = last_stressed_syllable_index(x.get('met'))
				try:
					syllables[i].set('met', '+')
				except:
					pass

		# Third step: enclose last word of each verse/hemistich in a <rhyme> tag with the correct @label.

		for x in tree.getroot().findall(".//l") + tree.getroot().findall(".//seg[@type='hemistich']"):
			words = x.findall("./seg[@type='word']")
			if len(words) and x.get('rhyme') is not None:
				label = x.get('rhyme')
				rhyme = ET.Element('rhyme', attrib={'label': label})
				last_word = words[-1]
				rhyme.append(last_word)
				x.remove(last_word)
				x.append(rhyme)

		# Last step: read from .met file the information about metrical units.

		# met_file = open(f"met/{met_filename}", 'r')
		# met_strophes = met_parser(met_file)
		# met_file.close()
		#
		# for (i, strophe) in enumerate(tree.getroot().findall(".//lg[@type='strophe']")):
		# 	strophe_met = strophe.get('met').split('/')
		# 	verses = strophe.findall("./l")
		# 	ns = [int(x.split(' ')[0]) for x in met_strophes[i]]
		# 	attribs = [x.split(' ')[1:] for x in met_strophes[i]]
		# 	current = 0
		# 	units = []
		# 	for (i, n) in enumerate(ns):
		# 		key_values = [(x.split('=')[0][1:], x.split('=')[1]) for x in attribs[i]]
		# 		lg = ET.Element('lg', attrib=dict(key_values))
		# 		lg.set('type', 'metrical-unit')
		# 		lg.set('met', '/'.join(strophe_met[current:current+n]))
		# 		lg.extend(verses[current:current+n])
		# 		units.append(lg)
		# 		current += n
		# 	for verse in verses:
		# 		strophe.remove(verse)
		# 	strophe.extend(units)

		tei_file = open(f"tei/{tei_filename}", 'w')
		ET.indent(tree)
		tree.write(tei_file, encoding="unicode")
		tei_file.close()
