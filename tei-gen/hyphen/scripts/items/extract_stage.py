#!/usr/bin/env python3

import argparse

if __name__ == "__main__":
	parser = argparse.ArgumentParser()
	parser.add_argument('filename', nargs='+')

	args = parser.parse_args()

	for name in args.filename:
		print(f"Reading from input file {name}")

		in_file = open(f"{name}", 'r')

		stage_dirs = []
		for line in in_file.read().splitlines():
			if line.startswith('$'):
				stage_dirs.append(line[1:])

		in_file.close()

		out_file = open(f"stage_{name}", 'w')
		out_file.write("\n".join([f"<stage>{x}</stage>" for x in stage_dirs]))
		out_file.close()