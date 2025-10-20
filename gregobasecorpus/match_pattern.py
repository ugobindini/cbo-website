#!/usr/bin/env python3

import os
import re
import argparse
from lxml import etree

import lxml.html

from volpiano import *

PATTERN_TO_REGEX = {'0': '0', 'u': '[A-Z]', 'U': '[0A-Z]', 'd': '[a-z]', 'D': '[0a-z]', '+': 'A', '-': 'a', '?': '.'}

def diff_to_str(n):
	# Code: uppercase letters for upward intervals, lowercase letters for downward intervals, 0 for note repetition
	# 'a' or 'A' represent a second, 'b' or 'B' a third and so on
	if n == 0:
		return '0'
	elif n > 0:
		return chr(ord('A') + n - 1)
	else:
		return chr(ord('a') - n - 1)

def sequence_to_volpiano(seq):
	return "1" + ",".join([int_to_glyph(s) for s in seq])

class Pattern:
	def __init__(self, pattern):
		self.pattern = pattern
		self.len = len(pattern)
		self.regex = re.compile("(?=" + "".join([PATTERN_TO_REGEX[c] for c in pattern]) + ")")


class Chant:
	def __init__(self, filename):
		self.filename = filename
		self.title = None
		self.mode = None
		self.sections = []

		with open("num/" + filename) as file:
			lines = [line.rstrip() for line in file]
			for line in lines:
				if line.startswith('@'):
					self.title = line[1:]
				elif line.startswith('$'):
					self.mode = int(line[1:])
				elif len(line):
					self.sections.append([int(s) for s in line.split(' ')])

	def __repr__(self):
		return "\n".join([self.title, self.mode, self.sections.__repr__()])

	def match(self, match_collection, pattern):
		"""
		Given a Pattern object, adds the finds to the MatchCollection
		"""
		k = pattern.len
		for n, section in enumerate(self.sections):
			# Transform the section into a string where the differences are encoded
			diff = "".join([diff_to_str(section[i+1] - section[i]) for i in range(len(section) - 1)])
			matches = re.finditer(pattern.regex, diff)
			for match in matches:
				i = match.start()
				match_collection.add_match(Match(Melody(section[i:i+k+1]), self, n))


class Melody:
	def __init__(self, sequence):
		self.sequence = tuple(sequence)


class Match:
	def __init__(self, melody, chant, section):
		self.melody = melody
		self.chant = chant
		self.section = section

	def meta(self):
		return f"{self.chant.title} ({self.chant.mode}), {self.section}"


class MatchCollection:
	"""
	Keeps Match objects stored by sequence.
	Keys for the dictionary are volpiano strings (normalized, i.e. without liquescences)
	"""
	def __init__(self):
		self.matches = {}

	def clear(self):
		self.matches = {}

	def add_match(self, match):
		if match.melody.sequence in self.matches.keys():
			self.matches[match.melody.sequence].append(match)
		else:
			self.matches[match.melody.sequence] = [match]

	def sorted_keys(self):
		return sorted(self.matches.keys(), key=lambda m: len(self.matches[m]), reverse=True)

	def print(self, volpiano=False):
		for k in self.sorted_keys():
			if volpiano:
				print(sequence_to_volpiano(k))
			else:
				print(k)
			for match in self.matches[k]:
				print(match.meta())

	def html(self):
		root = etree.Element('div')
		for k in self.sorted_keys():
			volp = lxml.html.Element('div')
			volp.set('class', 'volpiano')
			volp.text = sequence_to_volpiano(k)
			root.append(volp)
			for match in self.matches[k]:
				match_meta = lxml.html.Element('p')
				match_meta.text = match.meta()
				root.append(match_meta)

		return etree.ElementTree(root)


if __name__ == "__main__":
	parser = argparse.ArgumentParser()
	parser.add_argument('--pattern', '-p')
	parser.add_argument('--mode', '-m', nargs='+', default=None)
	args = parser.parse_args()

	pattern = Pattern(args.pattern)
	chants = [Chant(filename) for filename in os.listdir('num')]
	if args.mode:
		chants = [chant for chant in chants if str(chant.mode) in args.mode]

	match_collection = MatchCollection()

	for chant in chants:
		chant.match(match_collection, pattern)

	print(etree.tostring(match_collection.html(), pretty_print=True).decode("utf-8"))
