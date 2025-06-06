from paths import *

class Glyph:
	def __init__(self, description: str, code: str, paths: list):
		self.description = description
		self.code = code
		# This argument is a list of pairs ('path_name', shifted)
		self.paths = paths

	def metapost(self):
		return "\n".join([f"% {self.description}"] + [f"% {self.code}"] + [path_by_name(path).metapost_draw(shifted=shifted) for (path, shifted) in self.paths])

	def json(self, n):
		return {"description": self.description, "code": self.code, "n": n}


GLYPHS = [
	Glyph(
		description='Punctum',
		code='pu',
		paths=[('punctum', None)]
	),
	Glyph(
		description='Tractulus',
		code='tr',
		paths=[('tractulus', None)]
	),
	Glyph(
		description='Stropha',
		code='st',
		paths=[('stropha', None)]
	),
	Glyph(
		description='Distropha',
		code='ds',
		paths=[('stropha', None), ('stropha', '(6u,0)')]
	),
	Glyph(
		description='Tristropha',
		code='ts',
		paths=[('stropha', None), ('stropha', '(6u,0)'), ('stropha', '(12u,0)')]
	),
	Glyph(
		description='Virga',
		code='vi',
		paths=[('virga', None)]
	),
	Glyph(
		description='Virga liquescent',
		code='vi)',
		paths=[('virga_liq', None)]
	),
	Glyph(
		description='Special virga (?)',
		code='vi*',
		paths=[('virga', None), ('mystery_loop', None)]
	),
	Glyph(
		description='Virga strata',
		code='vs',
		paths=[('virga', None), ('oriscus', None)]
	),
	Glyph(
		description='Pressus maior',
		code='pr',
		paths=[('virga', None), ('oriscus', None), ('punctum', '(3u,-9u)')]
	),
	Glyph(
		description='Pressus maior + stropha',
		code='pr!st',
		paths=[('virga', None), ('oriscus', None), ('punctum', '(3u,-9u)'), ('stropha', '(15u,-6u)')]
	),
	Glyph(
		description='Virga + oriscus + punctum (separated form) (?)',
		code='vi!or!pu',
		paths=[('virga', None), ('oriscus', '(3u,-3u)'), ('punctum', '(6u,-9u)')]
	),
	Glyph(
		description='Virga strata + 2 subpuncta',
		code='vssu2',
		paths=[('virga', None), ('oriscus', None), ('punctum', '(6u,-7.5u)'), ('punctum', '(9u,-12u)')]
	),
	Glyph(
		description='Virga strata + 2 subpuncta + stropha',
		code='vssu2!st',
		paths=[('virga', None), ('oriscus', None), ('punctum', '(6u,-7.5u)'), ('punctum', '(9u,-12u)'), ('stropha', '(15u,-6u)')]
	),
	Glyph(
		description='Virga liquescent + 1 subpunctum',
		code='vi)su1',
		paths=[('virga_liq', None), ('punctum', '(9u,-9u)')]
	),
	Glyph(
		description='Virga liquescent + 2 subpuncta',
		code='vi)su2',
		paths=[('virga_liq', None), ('punctum', '(9u,-7.5u)'), ('punctum', '(12u,-12u)')]
	),
	Glyph(
		description='Virga + 1 subpunctum + substropha',
		code='visu2-',
		paths=[('virga', None), ('punctum', '(3u,-7.5u)'), ('substropha', '(6u,-12u)')]
	),
	Glyph(
		description='Virga + 3 subpuncta',
		code='visu3',
		paths=[('virga', None), ('punctum', '(3u,-6u)'), ('punctum', '(7.5u,-9u)'), ('punctum', '(12u,-12u)')]
	),
	Glyph(
		description='Virga + 2 subpuncta + substropha',
		code='visu3-',
		paths=[('virga', None), ('punctum', '(3u,-6u)'), ('punctum', '(7.5u,-9u)'), ('substropha', '(12u,-12u)')]
	),
	Glyph(
		description='Virga + 3 subpuncta + stropha',
		code='visu3!st',
		paths=[('virga', None), ('punctum', '(3u,-6u)'), ('punctum', '(7.5u,-9u)'), ('punctum', '(12u,-12u)'), ('stropha', '(18u,-6u)')]
	),
	Glyph(
		description='Virga + 4 subpuncta',
		code='visu4',
		paths=[('virga', None), ('punctum', '(3u,-6u)'), ('punctum', '(7u,-8u)'), ('punctum', '(11u,-10u)'), ('punctum', '(15u,-12u)')]
	),
	Glyph(
		description='Virga + 3 subpuncta + epiphonus (?)',
		code='visu3°',
		paths=[('virga', None), ('punctum', '(3u,-6u)'), ('punctum', '(7u,-8u)'), ('punctum', '(11u,-10u)'), ('epiphonus', '(16.5u,-12u)')]
	),
	Glyph(
		description='Virga + 3 subpuncta + substropha',
		code='visu4-',
		paths=[('virga', None), ('punctum', '(3u,-6u)'), ('punctum', '(7u,-8u)'), ('punctum', '(11u,-10u)'), ('substropha', '(15u,-12u)')]
	),
	Glyph(
		description='Virga + 5 subpuncta',
		code='visu5',
		paths=[('virga', None), ('punctum', '(2u,-6u)'), ('punctum', '(6u,-7.5u)'), ('punctum', '(10u,-9u)'), ('punctum', '(14u,-10.5u)'), ('punctum', '(18u,-12u)')]
	),
	Glyph(
		description='Virga with stroke',
		code='vi/',
		paths=[('virga', None), ('short_stroke', '(-9u,-6u)')]
	),
	Glyph(
		description='Virga liquescent with stroke',
		code='vi)/',
		paths=[('virga_liq', None), ('short_stroke', '(-9u,-6u)')]
	),
	Glyph(
		description='Virga + 2 subpuncta + substropha + stropha',
		code='visu3-!st',
		paths=[('virga', None), ('punctum', '(3u,-6u)'), ('punctum', '(7.5u,-9u)'), ('substropha', '(12u,-12u)'), ('stropha', '(18u,-6u)')]
	),
	Glyph(
		description='Epiphonus',
		code='ep',
		paths=[('epiphonus', None)]
	),
	Glyph(
		description='Epiphonus + 1 prepunctum',
		code='eppp1',
		paths=[('epiphonus', None), ('punctum', '(-6u,0)')]
	),
	Glyph(
		description='Pes',
		code='pe',
		paths=[('pes', None)]
	),
	Glyph(
		description='Pes liquescent',
		code='pe)',
		paths=[('pes_liquescent', None)]
	),
	Glyph(
		description='Pes + 2 subpuncta',
		code='pesu2',
		paths=[('pes', None), ('punctum', '(15u,4.5u)'), ('punctum', '(18u,0)')]
	),
	Glyph(
		description='Pes + 1 subpunctum + substropha',
		code='pesu2-',
		paths=[('pes', None), ('punctum', '(15u,4.5u)'), ('substropha', '(18u,0)')]
	),
	Glyph(
		description='Pes + 2 subpuncta + stropha',
		code='pesu2!st',
		paths=[('pes', None), ('punctum', '(15u,4.5u)'), ('punctum', '(18u,0)'), ('stropha', '(24u, 6u)')]
	),
	Glyph(
		description='Pes + 3 subpuncta',
		code='pesu3',
		paths=[('pes', None), ('punctum', '(15u,6u)'), ('punctum', '(18u,3u)'), ('punctum', '(21u,0)')]
	),
	Glyph(
		description='Pes + 2 subpuncta + substropha',
		code='pesu3-',
		paths=[('pes', None), ('punctum', '(15u,6u)'), ('punctum', '(18u,3u)'), ('substropha', '(21u,0)')]
	),
	Glyph(
		description='Pes + 3 subpuncta + substropha',
		code='pesu4-',
		paths=[('pes', None), ('punctum', '(15u,6u)'), ('punctum', '(18u,4u)'), ('punctum', '(21u,2u)'), ('substropha', '(24u,0)')]
	),
	Glyph(
		description='Pes + 3 subpuncta + stropha',
		code='pesu3!st',
		paths=[('pes', None), ('punctum', '(15u,6u)'), ('punctum', '(18u,3u)'), ('punctum', '(21u,0)'), ('stropha', '(27u,6u)')]
	),
	Glyph(
		description='Pes + 2 subpuncta + substropha + stropha',
		code='pesu3-!st',
		paths=[('pes', None), ('punctum', '(15u,6u)'), ('punctum', '(18u,3u)'), ('substropha', '(21u,0)'), ('stropha', '(27u,6u)')]
	),
	Glyph(
		description='Pes + 1 prepunctum',
		code='pepp1',
		paths=[('pes', None), ('punctum', '(-6u, 0)')]
	),
	Glyph(
		description='Pes liquescent + 1 prepunctum',
		code='pe)pp1',
		paths=[('pes_liquescent', None), ('punctum', '(-6u, 0)')]
	),
	Glyph(
		description='Pes + porrectus',
		code='pe!po',
		paths=[('pes', None), ('porrectus_end', 'point 1000 of pes')]
	),
	Glyph(
		description='Pes + oriscus',
		code='pe!or',
		paths=[('pes', None), ('oriscus', 'point 1000 of pes')]
	),
	Glyph(
		description='Pes + pressus minor',
		code='pe!pm',
		paths=[('pes', None), ('oriscus', 'point 1000 of pes'), ('punctum', '(15u,3u)')]
	),
	Glyph(
		description='Ancus',
		code='an',
		paths=[('virga', None), ('ancus_loop', None)]
	),
	Glyph(
		description='Clivis',
		code='cl',
		paths=[('virga', None), ('clivis_end', None)]
	),
	Glyph(
		description='Clivis liquescent',
		code='cl)',
		paths=[('virga', None), ('clivis_end_liquescent', None)]
	),
	Glyph(
		description='Clivis episemata (?)',
		code='cl-',
		paths=[('virga', None), ('clivis_end', None), ('episema', '(10.5u,3u)')]
	),
	Glyph(
		description='Clivis with stroke',
		code='cl/',
		paths=[('virga', None), ('clivis_end', None), ('stroke', '(-9u,-4.5u)')]
	),
	Glyph(
		description='Clivis + stropha',
		code='cl!st',
		paths=[('virga', None), ('clivis_end', None), ('stropha', '(15u,-3u)')]
	),
	Glyph(
		description='Clivis + 2 prepuncta',
		code='clpp2',
		paths=[('virga', None), ('clivis_end', None), ('punctum', '(-12u,-16.5u)'), ('punctum', '(-15u, -21u)')]
	),
	Glyph(
		description='Clivis + 2 subpuncta',
		code='clsu2',
		paths=[('virga', None), ('clivis_end', None), ('punctum', '(9u,-9u)'), ('punctum', '(13.5u, -12u)')]
	),
	Glyph(
		description='Clivis + 2 subpuncta + stropha',
		code='clsu2!st',
		paths=[('virga', None), ('clivis_end', None), ('punctum', '(9u,-9u)'), ('punctum', '(13.5u, -12u)'), ('stropha', '(25.5u,-6u)')]
	),
	Glyph(
		description='Torculus',
		code='to',
		paths=[('torculus', None)]
	),
	Glyph(
		description='Torculus + oriscus',
		code='to!or',
		paths=[('torculus', None), ('connector', '(point 1000 of torculus)'), ('oriscus', '((6u,4u) + (point 1000 of torculus))')]
	),
	Glyph(
		description='Torculus + pressus minor',
		code='to!pm',
		paths=[('torculus', None), ('connector', '(point 1000 of torculus)'), ('oriscus', '((6u,4u) + (point 1000 of torculus))'), ('punctum', '(24u, 3u)')]
	),
	Glyph(
		description='Porrectus',
		code='po',
		paths=[('virga', None), ('porrectus_end', None)]
	),
	Glyph(
		description='Porrectus liquescent',
		code='po)',
		paths=[('virga', None), ('porrectus_end', None), ('liquescence_loop', '(20.5u,-1u)')]
	),
	Glyph(
		description='Quilisma 2 loops',
		code='qi',
		paths=[('pes', None), ('pes_loop', '(-6u,0)')]
	),
	Glyph(
		description='Quilisma 2 loops liquescent',
		code='qi)',
		paths=[('pes_liquescent', None), ('pes_loop', '(-6u,0)')]
	),
	Glyph(
		description='Quilisma 2 loops + clivis',
		code='qi!cl',
		paths=[('torculus', None), ('pes_loop', '(-6u,0)')]
	),
	Glyph(
		description='Quilisma 2 loops + clivis + 1 subpunctum',
		code='qi!clsu1',
		paths=[('torculus', None), ('pes_loop', '(-6u,0)'), ('punctum', '(15u,3u)')]
	),
	Glyph(
		description='Quilisma 2 loops + clivis + 2 subpuncta',
		code='qi!clsu2',
		paths=[('torculus', None), ('pes_loop', '(-6u,0)'), ('punctum', '(15u,3u)'), ('punctum', '(18u,0)')]
	),
	Glyph(
		description='Quilisma 2 loops + 1 prepunctum + clivis + 1 subpunctum + stropha',
		code='qipp1!clsu1!st',
		paths=[('torculus', None), ('pes_loop', '(-6u,0)'), ('punctum', '(-12u,0)'), ('punctum', '(15u,3u)'), ('stropha', '(27u,9u)')]
	),
	Glyph(
		description='Quilisma 2 loops + 1 prepunctum + clivis',
		code='qipp1!cl',
		paths=[('torculus', None), ('pes_loop', '(-6u,0)'), ('punctum', '(-12u,0)')]
	),
	Glyph(
		description='Quilisma 2 loops + clivis + stropha',
		code='qi!cl!st',
		paths=[('torculus', None), ('pes_loop', '(-6u,0)'), ('stropha', '(27u,9u)')]
	),
	Glyph(
		description='Quilisma 2 loops + 1 prepunctum + clivis + stropha',
		code='qipp1!cl!st',
		paths=[('torculus', None), ('pes_loop', '(-6u,0)'), ('punctum', '(-12u,0)'), ('stropha', '(27u,9u)')]
	),
	Glyph(
		description='Quilisma 2 loops + porrectus',
		code='qi!po',
		paths=[('pes', None), ('pes_loop', '(-6u,0)'), ('porrectus_end', 'point 1000 of pes')]
	),
	Glyph(
		description='Quilisma 2 loops + 1 prepunctum + clivis + oriscus',
		code='qipp1!cl!or',
		paths=[('torculus', None), ('pes_loop', '(-6u,0)'), ('punctum', '(-12u,0)'), ('liquescence_loop', '(point 1000 of torculus - point 0 of liquescence_loop)')]
	),
	Glyph(
		description='Quilisma 2 loops + oriscus',
		code='qi!or',
		paths=[('pes', None), ('pes_loop', '(-6u,0)'), ('oriscus', '(12u,15u)')]
	),
	Glyph(
		description='Quilisma 2 loops + pressus maior',
		code='qi!pr',
		paths=[('pes', None), ('pes_loop', '(-6u,0)'), ('oriscus', '(12u,15u)'), ('punctum', '(15u,3u)')]
	),
	Glyph(
		description='Quilisma 2 loops + oriscus liquescent',
		code='qi!or)',
		paths=[('pes', None), ('pes_loop', '(-6u,0)'), ('cuoricino', '(12u,15u)')]
	),
	Glyph(
		description='Quilisma 2 loops + oriscus liquescent + 1 subpunctum',
		code='qi!or)su1',
		paths=[('pes', None), ('pes_loop', '(-6u,0)'), ('cuoricino', '(12u,15u)'), ('punctum', '(18u,u)')]
	),
	Glyph(
		description='Quilisma 2 loops + oriscus liquescent + 1 prepunctum + 1 substropha',
		code='qi!or)-pp1',
		paths=[('pes', None), ('pes_loop', '(-6u,0)'), ('punctum', '(-12u,0)'), ('cuoricino', '(12u,15u)'), ('substropha', '(18u,3u)')]
	),
	Glyph(
		description='Quilisma 2 loops + 1 prepunctum',
		code='qipp1',
		paths=[('pes', None), ('pes_loop', '(-6u,0)'), ('punctum', '(-12u,0)')]
	),
	Glyph(
		description='Quilisma 2 loops + 2 subpuncta',
		code='qisu2',
		paths=[('pes', None), ('pes_loop', '(-6u,0)'), ('punctum', '(15u,4.5u)'), ('punctum', '(18u,0)')]
	),
	Glyph(
		description='Quilisma 2 loops + 1 prepunctum + 2 subpuncta',
		code='qipp1su2',
		paths=[('pes', None), ('pes_loop', '(-6u,0)'), ('punctum', '(-12u,0)'), ('punctum', '(15u,4.5u)'), ('punctum', '(18u,0)')]
	),
	Glyph(
		description='Quilisma 2 loops + 1 subpunctum + substropha',
		code='qisu2-',
		paths=[('pes', None), ('pes_loop', '(-6u,0)'), ('punctum', '(15u,4.5u)'), ('substropha', '(18u,0)')]
	),
	Glyph(
		description='Quilisma 2 loops + 1 prepunctum + 1 subpunctum + substropha',
		code='qipp1su2-',
		paths=[('pes', None), ('pes_loop', '(-6u,0)'), ('punctum', '(-12u,0)'), ('punctum', '(15u,4.5u)'), ('substropha', '(18u,0)')]
	),
	Glyph(
		description='Quilisma 2 loops + 2 subpuncta + stropha',
		code='qisu2!st',
		paths=[('pes', None), ('pes_loop', '(-6u,0)'), ('punctum', '(15u,4.5u)'), ('punctum', '(18u,0)'), ('stropha', '(24u,6u)')]
	),
	Glyph(
		description='Quilisma 2 loops + 1 prepunctum + 2 subpuncta + stropha',
		code='qipp1su2!st',
		paths=[('pes', None), ('pes_loop', '(-6u,0)'), ('punctum', '(-12u,0)'), ('punctum', '(15u,4.5u)'), ('punctum', '(18u,0)'), ('stropha', '(24u,6u)')]
	),
	Glyph(
		description='Quilisma 2 loops + 3 subpuncta',
		code='qisu3',
		paths=[('pes', None), ('pes_loop', '(-6u,0)'), ('punctum', '(15u,6u)'), ('punctum', '(18u,3u)'), ('punctum', '(21u,0)')]
	),
	Glyph(
		description='Quilisma 2 loops + 2 subpuncta + substropha',
		code='qisu3-',
		paths=[('pes', None), ('pes_loop', '(-6u,0)'), ('punctum', '(15u,6u)'), ('punctum', '(18u,3u)'), ('substropha', '(21u,0)')]
	),
	Glyph(
		description='Quilisma 2 loops + 1 prepunctum + 2 subpuncta + substropha',
		code='qipp1su3-',
		paths=[('pes', None), ('pes_loop', '(-6u,0)'), ('punctum', '(-12u,0)'), ('punctum', '(15u,6u)'), ('punctum', '(18u,3u)'), ('substropha', '(21u,0)')]
	),
	Glyph(
		description='Quilisma 2 loops + 3 subpuncta + substropha',
		code='qisu4-',
		paths=[('pes', None), ('pes_loop', '(-6u,0)'), ('punctum', '(15u,6u)'), ('punctum', '(18u,4u)'), ('punctum', '(21u,2u)'), ('substropha', '(24u,0)')]
	),
	Glyph(
		description='Quilisma 2 loops + ancus + 2 subpuncta',
		code='qi!ansu2',
		paths=[('pes', None), ('pes_loop', '(-6u,0)'), ('ancus_loop', 'point 1000 of pes'), ('punctum', '(18u,3u)'), ('punctum', '(21u,0u)')]
	),
	Glyph(
		description='Quilisma 3 loops',
		code='ql',
		paths=[('pes', None), ('pes_loop', '(-6u,0)'), ('pes_loop', '(-12u,0)')]
	),
	Glyph(
		description='Quilisma 3 loops liquescent',
		code='ql)',
		paths=[('pes_liquescent', None), ('pes_loop', '(-6u,0)'), ('pes_loop', '(-12u,0)')]
	),
	Glyph(
		description='Quilisma 3 loops + ancus',
		code='ql!an',
		paths=[('pes', None), ('pes_loop', '(-6u,0)'), ('pes_loop', '(-12u,0)'), ('ancus_loop', 'point 1000 of pes')]
	),
	Glyph(
		description='Quilisma 3 loops + clivis',
		code='ql!cl',
		paths=[('torculus', None), ('pes_loop', '(-6u,0)'), ('pes_loop', '(-12u,0)')]
	),
	Glyph(
		description='Quilisma 3 loops + clivis liquescent',
		code='ql!cl)',
		paths=[('torculus_liquescent', None), ('pes_loop', '(-6u,0)'), ('pes_loop', '(-12u,0)')]
	),
	Glyph(
		description='Quilisma 3 loops + 1 prepunctum + clivis',
		code='qlpp1!cl',
		paths=[('torculus', None), ('pes_loop', '(-6u,0)'), ('pes_loop', '(-12u,0)'), ('punctum', '(-18u,0)')]
	),
	Glyph(
		description='Quilisma 3 loops + 1 prepunctum + clivis + 2 subpuncta',
		code='qlpp1!clsu2',
		paths=[('torculus', None), ('pes_loop', '(-6u,0)'), ('pes_loop', '(-12u,0)'), ('punctum', '(-18u,0)'), ('punctum', '(15u,3u)'), ('punctum', '(18u,0)')]
	),
	Glyph(
		description='Quilisma 3 loops + clivis + oriscus',
		code='ql!cl!or',
		paths=[('torculus', None), ('pes_loop', '(-6u,0)'), ('pes_loop', '(-12u,0)'), ('liquescence_loop', '(point 1000 of torculus - point 0 of liquescence_loop)')]
	),
	Glyph(
		description='Quilisma 3 loops + clivis + 1 subpunctum',
		code='ql!clsu1',
		paths=[('torculus', None), ('pes_loop', '(-6u,0)'), ('pes_loop', '(-12u,0)'), ('punctum', '(19.5u,0)')]
	),
	Glyph(
		description='Quilisma 3 loops + clivis + stropha',
		code='ql!cl!st',
		paths=[('torculus', None), ('pes_loop', '(-6u,0)'), ('pes_loop', '(-12u,0)'), ('stropha', '(27u,9u)')]
	),
	Glyph(
		description='Quilisma 3 loops + 1 prepunctum + clivis + stropha',
		code='qlpp1!cl!st',
		paths=[('torculus', None), ('pes_loop', '(-6u,0)'), ('pes_loop', '(-12u,0)'), ('punctum', '(-18u,0)'), ('stropha', '(27u,9u)')]
	),
	Glyph(
		description='Quilisma 3 loops + porrectus',
		code='ql!po',
		paths=[('pes', None), ('pes_loop', '(-6u,0)'), ('pes_loop', '(-12u,0)'), ('porrectus_end', 'point 1000 of pes')]
	),
	Glyph(
		description='Quilisma 3 loops + 1 prepunctum + porrectus',
		code='qlpp1!po',
		paths=[('pes', None), ('pes_loop', '(-6u,0)'), ('pes_loop', '(-12u,0)'), ('punctum', '(-18u,0)'), ('porrectus_end', 'point 1000 of pes')]
	),
	Glyph(
		description='Quilisma 3 loops + oriscus',
		code='ql!or',
		paths=[('pes', None), ('pes_loop', '(-6u,0)'), ('pes_loop', '(-12u,0)'), ('oriscus', 'point 1000 of pes')]
	),
	Glyph(
		description='Quilisma 3 loops + oriscus liquescent',
		code='ql!or)',
		paths=[('pes', None), ('pes_loop', '(-6u,0)'), ('pes_loop', '(-12u,0)'), ('cuoricino', '(12u,15u)')]
	),
	Glyph(
		description='Quilisma 3 loops + pressus maior',
		code='ql!pr',
		paths=[('pes', None), ('pes_loop', '(-6u,0)'), ('pes_loop', '(-12u,0)'), ('oriscus', 'point 1000 of pes'), ('punctum', 'point 1000 of pes shifted (0,-12u)')]
	),
	Glyph(
		description='Quilisma 3 loops + oriscus liquescent + 1 subpunctum',
		code='ql!or)su1',
		paths=[('pes', None), ('pes_loop', '(-6u,0)'), ('pes_loop', '(-12u,0)'), ('cuoricino', '(12u,15u)'), ('punctum', '(20u,u)')]
	),
	Glyph(
		description='Quilisma 3 loops + 2 subpuncta',
		code='qlsu2',
		paths=[('pes', None), ('pes_loop', '(-6u,0)'), ('pes_loop', '(-12u,0)'), ('punctum', '(15u,4.5u)'), ('punctum', '(18u,0)')]
	),
	Glyph(
		description='Quilisma 3 loops + 1 prepunctum + 2 subpuncta',
		code='qlpp1su2',
		paths=[('pes', None), ('pes_loop', '(-6u,0)'), ('pes_loop', '(-12u,0)'), ('punctum', '(-18u,0)'), ('punctum', '(15u,4.5u)'), ('punctum', '(18u,0)')]
	),
	Glyph(
		description='Quilisma 3 loops + 1 subpunctum + substropha',
		code='qlsu2-',
		paths=[('pes', None), ('pes_loop', '(-6u,0)'), ('pes_loop', '(-12u,0)'), ('punctum', '(15u,4.5u)'), ('substropha', '(18u,0)')]
	),
	Glyph(
		description='Quilisma 3 loops + 3 subpuncta',
		code='qlsu3',
		paths=[('pes', None), ('pes_loop', '(-6u,0)'), ('pes_loop', '(-12u,0)'), ('punctum', '(15u,6u)'), ('punctum', '(18u,3u)'), ('punctum', '(21u,0)')]
	),
	Glyph(
		description='Quilisma 3 loops + 2 subpuncta + substropha',
		code='qlsu3-',
		paths=[('pes', None), ('pes_loop', '(-6u,0)'), ('pes_loop', '(-12u,0)'), ('punctum', '(15u,6u)'), ('punctum', '(18u,3u)'), ('substropha', '(21u,0)')]
	),
	Glyph(
		description='Quilisma 3 loops + 1 prepunctum + 2 subpuncta + substropha',
		code='qlpp1su3-',
		paths=[('pes', None), ('pes_loop', '(-6u,0)'), ('pes_loop', '(-12u,0)'), ('punctum', '(-18u,0)'), ('punctum', '(15u,6u)'), ('punctum', '(18u,3u)'), ('substropha', '(21u,0)')]
	),
	Glyph(
		description='Quilisma 3 loops + 2 subpuncta + stropha',
		code='qlsu2!st',
		paths=[('pes', None), ('pes_loop', '(-6u,0)'), ('pes_loop', '(-12u,0)'), ('punctum', '(15u,4.5u)'), ('punctum', '(18u,0)'), ('stropha', '(24u,6u)')]
	),
	Glyph(
		description='Quilisma 3 loops + 1 prepunctum + 2 subpuncta + stropha',
		code='qlpp1su2!st',
		paths=[('pes', None), ('pes_loop', '(-6u,0)'), ('pes_loop', '(-12u,0)'), ('punctum', '(-18u,0)'), ('punctum', '(15u,4.5u)'), ('punctum', '(18u,0)'), ('stropha', '(24u,6u)')]
	),
	Glyph(
		description='Quilisma 3 loops + 1 prepunctum + 2 subpuncta + substropha',
		code='qlpp1su4-',
		paths=[('pes', None), ('pes_loop', '(-6u,0)'), ('pes_loop', '(-12u,0)'), ('punctum', '(-18u,0)'), ('punctum', '(15u,6u)'), ('punctum', '(18u,4u)'), ('punctum', '(21u,2u)'), ('substropha', '(24u,0)')]
	),
	Glyph(
		description='Quilisma 3 loops + 1 prepunctum',
		code='qlpp1',
		paths=[('pes', None), ('pes_loop', '(-6u,0)'), ('pes_loop', '(-12u,0)'), ('punctum', '(-18u,0)')]
	),
	Glyph(
		description='Quilisma 4 loops',
		code='qs',
		paths=[('pes', None), ('pes_loop', '(-6u,0)'), ('pes_loop', '(-12u,0)'), ('pes_loop', '(-18u,0)')]
	),
	Glyph(
		description='Quilisma 4 loops + 3 subpuncta',
		code='qssu3',
		paths=[('pes', None), ('pes_loop', '(-6u,0)'), ('pes_loop', '(-12u,0)'), ('pes_loop', '(-18u,0)'), ('punctum', '(15u,6u)'), ('punctum', '(18u,3u)'), ('punctum', '(21u,0)')]
	),
	Glyph(
		description='Climacus',
		code='ci',
		paths=[('virga', None), ('punctum', '(3u,-7.5u)'), ('punctum', '(6u,-12u)')]
	),
	Glyph(
		description='Climacus with stroke',
		code='ci/',
		paths=[('virga', None), ('short_stroke', '(-9u,-6u)'), ('punctum', '(3u,-7.5u)'), ('punctum', '(6u,-12u)')]
	),
	Glyph(
		description='Climacus + epiphonus (?)',
		code='ci°',
		paths=[('virga', None), ('punctum', '(3u,-6u)'), ('punctum', '(6u,-9u)'), ('epiphonus', '(10.5u,-12u)')]
	),
	Glyph(
		description='Climacus + stropha',
		code='ci!st',
		paths=[('virga', None), ('punctum', '(3u,-7.5u)'), ('punctum', '(6u,-12u)'), ('stropha', '(12u,-6u)')]
	),
	Glyph(
		description='Climacus + stropha + pressus minor',
		code='ci!st!pm',
		paths=[('virga', None), ('punctum', '(3u,-7.5u)'), ('punctum', '(6u,-12u)'), ('stropha', '(12u,-6u)'), ('reversed_oriscus', '(12u,0)'), ('punctum', '(18u,-6u)')]
	),
	Glyph(
		description='Climacus + 2 prepuncta',
		code='cipp2',
		paths=[('virga', None), ('punctum', '(3u,-7.5u)'), ('punctum', '(6u,-12u)'), ('punctum', '(-12u,-16.5u)'), ('punctum', '(-15u,-21u)')]
	),
	Glyph(
		description='Climacus + 2 prepuncta + stropha',
		code='cipp2!st',
		paths=[('virga', None), ('punctum', '(3u,-7.5u)'), ('punctum', '(6u,-12u)'), ('stropha', '(12u,-6u)'), ('punctum', '(-12u,-16.5u)'), ('punctum', '(-15u,-21u)')]
	),
	Glyph(
		description='Scandicus',
		code='sc',
		paths=[('virga', None), ('punctum', '(-12u,-16.5u)'), ('punctum', '(-15u,-21u)')]
	),
	Glyph(
		description='Scandicus liquescent',
		code='sc)',
		paths=[('virga_liq', None), ('punctum', '(-12u,-16.5u)'), ('punctum', '(-15u,-21u)')]
	),
	Glyph(
		description='Scandicus with tractulus as middle note',
		code='sc-',
		paths=[('virga', None), ('tractulus', '(-15u,-16.5u)'), ('punctum', '(-15u,-21u)')]
	),
	Glyph(
		description='Scandicus with tractulus as middle note + quilisma 3 loops',
		code='sc-!ql',
		paths=[('pes', None), ('pes_loop', '(-6u,0)'), ('pes_loop', '(-12u,0)'), ('tractulus', '(-12u,-4.5u)'), ('punctum', '(-15u,-9u)')]
	),
]