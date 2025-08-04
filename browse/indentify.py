import re


def parse(met):
	# returns a positional list with the number of left-indents for each verse
	elements = met.split('/')
	ints = []
	for element in elements:
		if 'A' in element:
			# accounting for german metric with 'Auftakt'
			element = element.split('A')[1]
		# sum the integers appearing in the metric (possibly more than one due to hemistichs/composite verses)
		ints.append(sum([int(''.join(filter(str.isdigit, x))) for x in re.findall(r'\d+', element)]))

	ints = [x - max(ints) for x in ints]
	k = 0
	res = [0 for _ in range(len(ints))]
	while min(ints) < 0:
		for n in range(len(ints)):
			if ints[n] == 0:
				res[n] = k
		ints = [x - max([y for y in ints if y < 0]) for x in ints]
		k += 1
	for n in range(len(ints)):
		if ints[n] == 0:
			res[n] = k

	return res


def indentify(tree):
	# Input: a html tree (lxml format)
	for poem in tree.findall(".//div[@data-type='poem']"):
		global_met = poem.get('data-met')
		for lg in poem.findall("./div[@data-type='strophe']"):
			if 'data-met' in lg.keys():
				met = lg.get('data-met')
			else:
				met = global_met

			parsed_met = parse(met)
			for (n, verse) in enumerate(lg.findall(".//div[@class='verse']")):
				verse.set('data-indent', str(parsed_met[n]))
