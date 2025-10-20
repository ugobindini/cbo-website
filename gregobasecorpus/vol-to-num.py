#!/usr/bin/env python3

import os
import codecs

from volpiano import glyph_to_int

if __name__ == "__main__":

	new_data = {}

	"""
	for filename in os.listdir('num'):
		if filename.endswith('num'):
			with open('num/' + filename, 'r') as num_file:
				lines = [line.rstrip() for line in num_file]
				new_data[filename] = {'title': lines[0][1:], 'mode': lines[1][1:]}
			with open('vol/' + filename, 'r') as vol_file:
				lines = [line.rstrip() for line in vol_file]
				new_data[filename]['vol'] = "/".join([line for line in lines if len(line) > 1])

	for filename in new_data.keys():
		new_data[filename]['num'] = ""
		for line in new_data[filename]['vol'].split('/'):
			new_data[filename]['num'] += ' '.join([str(glyph_to_int(g)) for g in line]) + "\n"
		out_file = open('num/' + filename, 'w')
		out_file.write("@" + new_data[filename]['title'] + "\n")
		out_file.write("$" + new_data[filename]['mode'] + "\n")
		out_file.write(new_data[filename]['num'])

