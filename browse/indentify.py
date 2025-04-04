import re


def parse(met):
	elements = met.split('/')
	ints = []
	for element in elements:
		ints.append(sum([int(x) for x in re.findall(r'\d+', element)]))

	return ints

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
	for poem in tree.findall(".//div[@class='poem']"):
		global_met = poem.get('data-met')
		for lg in poem.findall("./div[@class='strophe']"):
			if 'data-met' in lg.keys():
				met = lg.get('data-met')
			else:
				met = global_met

			parsed_met = parse(met)
			for (n, verse) in enumerate(lg.findall(".//div[@class='verse']")):
				verse.set('data-indent', str(parsed_met[n]))

	return tree
