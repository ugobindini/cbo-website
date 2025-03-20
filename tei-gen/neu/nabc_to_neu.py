#!/usr/bin/env python3

import argparse
import re

def in_out_filenames(name, in_extension, out_extension):
    if name.endswith(f".{in_extension}"):
        # if the given filename already contains the in_extension
        in_filename = name
        out_filename = f"{name.split('.')[0]}.{out_extension}"
    else:
        # the given filename should be without extension
        assert '.' not in name, 'Invalid file name.'
        in_filename = f"{name}.{in_extension}"
        out_filename = f"{name}.{out_extension}"

    return in_filename, out_filename

if __name__ == "__main__":
	parser = argparse.ArgumentParser()
	parser.add_argument('filename', nargs='+')

	args = parser.parse_args()

	for name in args.filename:
		in_filename, out_filename = in_out_filenames(name=name, in_extension="nabc", out_extension="neu")
		input_file = open(in_filename, 'r')
		output_file = open(out_filename, 'w')

		for line in input_file.read().splitlines():
			neumes = re.findall(r"\([^()]*\)", line)
			output_file.write(' '.join([neume[1:-1] for neume in neumes]) + "\n")

		input_file.close()
		output_file.close()
