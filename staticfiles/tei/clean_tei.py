#!/usr/bin/env python3

# Generic program to handle large corrections/updates/modifications of TEI files
import lxml.etree

from buranus_dict import NABC_TO_FONT_ID

import os
import argparse
import xml.etree.ElementTree as ET


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


def propagate_metrical_info(strophe, attrib, value):
	verses_value = value.split('/')
	verses = strophe.findall(".//l")
	assert len(verses_value) == len(verses), f"ERROR: metify.py: mismatch in the number of verses: {len(verses_value)}, {len(verses)}"
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

		for div in tree.getroot().findall(".//div[@type='poem']"):
			try:
				poem_met = div.get('met')
			except:
				print("WARNING: Attribute @met not specified in div of type @poem")
			try:
				rhyme = div.get('rhyme')
			except:
				print("WARNING: Attribute @rhyme not specified in div of type @poem")

			strophes = div.findall(".//lg[@type='strophe']")
			for strophe in strophes:
				if 'met' not in strophe.keys():
					met = poem_met
					strophe.set('met', met)
				else:
					met = strophe.get('met')
				if 'rhyme' not in strophe.keys():
					strophe.set('rhyme', rhyme)
				else:
					rhyme = strophe.get('rhyme')
				propagate_metrical_info(strophe, attrib='met', value=met)
				propagate_metrical_info(strophe, attrib='rhyme', value=rhyme)

		for x in tree.getroot().findall(".//l") + tree.getroot().findall(".//seg[@type='hemistich']"):
			syllables = x.findall(".//w//seg[@type='syll']")
			if len(syllables) and x.get('met') is not None:
				i = last_stressed_syllable_index(x.get('met'))
				try:
					syllables[i].set('met', '+')
				except:
					pass

		#####

		tree.write(name)
