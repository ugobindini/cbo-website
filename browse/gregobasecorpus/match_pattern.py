#!/usr/bin/env python3

import os
import re
from lxml import etree

from django.conf import settings

from .volpiano import *

if settings.LOCAL:
	static_root = settings.STATICFILES_DIRS[0]
else:
	static_root = settings.STATIC_ROOT


def staticfile_path(folder, filename):
	import os.path
	return os.path.join(os.path.join(static_root, folder), filename)


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


PATTERN_TO_REGEX = {'0': '0', 'u': '[A-Z]', 'U': '[0A-Z]', 'd': '[a-z]', 'D': '[0a-z]', '+': 'A', '-': 'a', '?': '.'}


class Pattern:
	def __init__(self, pattern):
		self.pattern = "".join([s for s in pattern if s in PATTERN_TO_REGEX.keys()])
		self.len = len(self.pattern)
		self.regex = re.compile("(?=" + "".join([PATTERN_TO_REGEX[c] for c in self.pattern]) + ")")


class Chant:
	def __init__(self, filename):
		self.filename = filename
		self.title = None
		self.mode = None
		self.sections = []

		with open(staticfile_path("num", filename)) as file:
			lines = [line.rstrip() for line in file]
			for line in lines:
				if line.startswith('@'):
					self.title = line[1:]
				elif line.startswith('$'):
					self.mode = int(line[1:])
				elif len(line):
					self.sections.append([int(s) for s in line.split(' ')])

	def __hash__(self):
		return (str(self.mode) + self.title).__hash__()

	def __eq__(self, other):
		return self.__hash__() == other.__hash__()

	def __repr__(self):
		return "\n".join([self.title, self.mode, self.sections.__repr__()])

	def meta(self):
		return f"{self.chant.title} ({self.chant.mode})"

	def match(self, match_collection, pattern):
		"""
		Given a Pattern object, adds the finds to the MatchCollection
		"""
		k = pattern.len
		for n, section in enumerate(self.sections):
			# Transform the section into a string where the differences are encoded
			diff = "".join([diff_to_str(section[i + 1] - section[i]) for i in range(len(section) - 1)])
			matches = re.finditer(pattern.regex, diff)
			for match in matches:
				i = match.start()
				match_collection.add_match(Match(Melody(section[i:i + k + 1]), self, n))


CHANTS = [Chant(filename) for filename in os.listdir(staticfile_path("num", ""))]


class Melody:
	def __init__(self, sequence):
		self.sequence = tuple(sequence)


class Match:
	def __init__(self, melody, chant, section):
		self.melody = melody
		self.chant = chant
		self.section = section

	def meta(self):
		return f"{self.chant.meta}, {self.section}"


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
		return sorted(self.matches.keys(), key=lambda m: len(set([match.chant for match in self.matches[m]])),
		              reverse=True)

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
			volp = etree.Element('div')
			volp.set('class', 'volpiano')
			volp.text = sequence_to_volpiano(k)
			root.append(volp)
			table = etree.Element('table')
			# th = etree.Element('th')
			# th.extend([etree.Element('td', text='Title'), etree.Element('td', text='Mode'), etree.Element('td', text='Section(s)')])
			# table.append(th)

			for chant in set([match.chant for match in self.matches[k]]):
				chant_matches = [match for match in self.matches[k] if match.chant == chant]
				tr = etree.Element('tr')
				sections = ", ".join(sorted(list(set([str(m.section) for m in chant_matches]))))
				tr.extend([etree.fromstring(f"<td class='title'>{chant.title}</td>"),
				           etree.fromstring(f"<td class='mode'>{chant.mode}</td>"),
				           etree.fromstring(f"<td class='sections'>{sections}</td>")])
				table.append(tr)

			if len(table.findall(".//tr")) > 1:
				button = etree.Element('button')
				button.set('class', 'collapsible')
				button.text = f"Show {len(table.findall('.//tr'))} chants"
				root.append(button)
				table.set('class', 'hidden-table')
			root.append(table)

		return etree.ElementTree(root)


def match_pattern(pattern, modes):
	pattern = Pattern(pattern)
	if len(modes):
		chants = [chant for chant in CHANTS if str(chant.mode) in modes]
	else:
		chants = CHANTS

	match_collection = MatchCollection()

	for chant in chants:
		chant.match(match_collection, pattern)

	return etree.tostring(match_collection.html(), pretty_print=True).decode("utf-8")
