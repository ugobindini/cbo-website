def glyph_to_int(glyph):
	"""
	Given a volpiano glyph (character), returns an int corresponding to the note.
	1 is the low F, 0 for unrecognized characters
	"""
	if glyph == '(' or glyph == '8':
		return 1
	elif glyph == ')' or glyph == '9':
		return 2
	elif ord('a') <= ord(glyph.lower()) <= ord('h'):
		return 3 + ord(glyph.lower()) - ord('a')
	elif ord('j') <= ord(glyph.lower()) <= ord('s'):
		return 2 + ord(glyph.lower()) - ord('a')
	else:
		return 0

def int_to_glyph(n):
	"""
	Given an integer, returns the corresponding glyph.
	If 0 is encountered (it shouldn't be the case), return a comma ',' (smallest empty staff)
	"""
	if n == 1:
		return '8'
	elif n == 2:
		return '9'
	elif 3 <= n <= 10:
		return chr(ord('a') + n - 3)
	elif 11 <= n <= 20:
		return chr(ord('a') + n - 2)
	else:
		return ','
