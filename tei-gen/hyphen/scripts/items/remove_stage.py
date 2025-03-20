#!/usr/bin/env python3

import argparse

if __name__ == "__main__":
	parser = argparse.ArgumentParser()
	parser.add_argument('filename', nargs='+')

	args = parser.parse_args()

	for name in args.filename:
		print(f"Reading from input file {name}")

		in_file = open(f"{name}", 'r')

		lines = []
		for line in in_file.read().splitlines():
			if not line.startswith('$'):
				lines.append(line)

		in_file.close()

		out_file = open(f"text_{name}", 'w')
		out_file.write("\n".join(lines))
		out_file.close()