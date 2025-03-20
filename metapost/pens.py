class Pen:
	def __init__(self, name: str, transformation: str):
		self.name = name
		self.transformation = transformation

	def describe(self):
		return f"pencircle {self.transformation}"


PENS = [
	Pen(
		name="punctum",
		transformation="xscaled 4u yscaled 2u rotated 20"
	),
	Pen(
		name="default",
		transformation="xscaled 4u yscaled 1u rotated 22.5"
	),
	Pen(
		name="epiphonus",
		transformation="xscaled 4u yscaled 1u rotated 45"
	)
]


def pen_by_name(name):
	return next((pen for pen in PENS if pen.name == name), None)
