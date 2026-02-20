# Propagate metrical and rhyme information in the html result of a transformation
import itertools


def upbeat_variant(met1, met2):
	hemistichs1 = met1.split('+')
	hemistichs2 = met2.split('+')
	assert len(hemistichs1) == len(hemistichs2)
	print(hemistichs1, hemistichs2)
	diff = sum([1 for n in range(len(hemistichs1)) if hemistichs1[n] != hemistichs2[n] and "A" + hemistichs2[n] != hemistichs1[n]])
	print(diff)
	if diff:
		return False
	else:
		return True


def metify(tree):
	for attr in ['met', 'rhyme']:
		poem_types = ['poem', 'sequence', 'leich']
		for div in list(itertools.chain.from_iterable([tree.findall(f".//div[@type='{t}']") for t in poem_types])):
			if attr in div.keys():
				poem_met = div.get(attr)
			else:
				poem_met = None
			lg_types = ['strophe', 'refrain', 'versicle']
			for lg in list(itertools.chain.from_iterable([div.findall(f".//lg[@type='{t}']") for t in lg_types])):
				if attr in lg.keys():
					met = lg.get(attr)
				else:
					assert poem_met is not None, "ERROR: Undefined metric"
					lg.set(attr, poem_met)
					met = poem_met
				met_list = met.split('/')
				for (n, l) in enumerate(lg.findall(".//l")):
					if attr not in l.keys():
						l.set(attr, met_list[n])
					elif attr == 'met' and upbeat_variant(l.get(attr), met_list[n]):
						pass
					else:
						l.set(attr + "-variant", l.get(attr))
						l.set(attr, met_list[n])
