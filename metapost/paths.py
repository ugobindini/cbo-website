from pens import *

class Path:
	def __init__(self, name: str, command: str, pen=pen_by_name('default')):
		self.name = name
		self.pen = pen
		self.command = command

	def metapost_init(self):
		# Initialize path in metapost header
		return f"path {self.name};" + "\n" + f"{self.name}={self.command};"

	def metapost_draw(self, shifted=None):
		# Draw path
		if shifted is None:
			return f"draw {self.name} withpen {self.pen.describe()};"
		else:
			return f"draw {self.name} shifted {shifted} withpen {self.pen.describe()};"



def path_join(p_name, q_name):
	return f"{p_name}&({q_name} shifted (point 1000 of {p_name} - point 0 of {q_name}))"


PATHS = [
	Path(
		name='punctum',
		command='(0,0){right rotated 20}..{right rotated 70}(u,0.5u)',
		pen=pen_by_name('punctum'),
	),
	Path(
		name='tractulus',
		command='(0,0)..(3u,0)..(6u,0.5u)',
		pen=pen_by_name('punctum'),
	),
	Path(
		name='stropha',
		command='(0,0)..(1.5u,3u)..(0,6u)'
	),
	Path(
		name='substropha',
		command='(0,0)..(1.5u,-2u)..(0,-4u)'
	),
	Path(
		name='virga',
		command='(0,0)--(-9u,-12u)--(-7.5u,-11u)'
	),
	Path(
		name='pes_loop',
		command='(3u,5u)..(0,5u/3)..(3u,0)..(6u,5u/3)'
	),
	Path(
		name='pes',
		command='pes_loop&((6u,5u/3)..(9u,11u)..(12u,15u))'
	),
	Path(
		name='clivis_hor',
		command='(0,0)..(0.75[0,10.5u],3u)..(10.5u,3u)'
	),
	Path(
		name='clivis_end',
		command=path_join('clivis_hor', 'virga')
	),
	Path(
		name='torculus',
		command=path_join('pes', 'clivis_end')
	),
	Path(
		name='porrectus_end',
		command='clivis_hor&((10.5u,3u)--(4.5u,-5u){point 1 of virga}..{-(point 1 of virga)}(12u,-6u)--(15u,-2u))'
	),
	Path(
		name='liquescence_loop',
		command='reverse pes_loop rotated 180'
	),
	Path(
		name='clivis_end_liquescent',
		command=path_join('clivis_end', 'liquescence_loop')
	),
	Path(
		name='torculus_liquescent',
		command=path_join('pes', 'clivis_end_liquescent')
	),
	Path(
		name='cuoricino',
		command='(0,0)--(2u,-2u)..(6u,0)..(9u,-2u)..(6u,-8u)'
	),
	Path(
		name='virga_liq',
		command=path_join('reverse virga', 'liquescence_loop')
	),
	Path(
		name='oriscus',
		command='((0,0){down rotated 45}..(2u,-2u)..{up rotated -45}(4.5u,0)--(7.5u,-2u))'
	),
	Path(
		name='reversed_oriscus',
		command='((0,0){right rotated 30}..(4.5u,2u)..{right rotated -30}(7.5u,0)--(9u,u))'
	),
	Path(
		name='pes_liquescent',
		command=path_join('pes', 'liquescence_loop')
	),
	Path(
		name='epiphonus',
		command='(2u,4.5u)..(0,2u)..(3u,0)..{right rotated 60}(7.5u,4.5u)',
		pen=pen_by_name('epiphonus')
	),
	Path(
		name='episema',
		command='(0,0)--(6u,0)'
	),
	Path(
		name='short_stroke',
		command='(0,0)--(6u,u)'
	),
	Path(
		name='stroke',
		command='(0,0)--(18u,3u)'
	),
	Path(
		name='ancus_loop',
		command='(0,0)..(7.5u,0)..(7.5u,-7.5u)'
	),
	Path(
		name='mystery_loop',
		command='(0,0)..(4.5u,3u)..(9u,-3u)'
	),
	Path(
		name='connector',
		command='(0,0)--(6u,4u)'
	)
]

def path_by_name(name):
	return next((path for path in PATHS if path.name == name), None)