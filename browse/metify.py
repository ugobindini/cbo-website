# Propagate metrical and rhyme information in the html result of a transformation
import itertools

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
					else:
						l.set(attr + "-variant", l.get(attr))
						l.set(attr, met_list[n])
