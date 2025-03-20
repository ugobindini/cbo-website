# Adiastematic neumes: .neu files

This custom file format represents the musical content of an adiastematically notated piece.

The syllables are separated by white spaces, the verses by line breaks, the strophes by double line-breaks. 

If a strophe is not neumed, a double-dash '--' replaces the strophe. If a verse is not neumed, a dash '-' replaces the verse (not necessary for verses at the end of a strophe). 

If a syllable carries more than one neume, the neumes are separated by a comma ','. If a syllable carries no neumes, a dot '.' is put.

The script `neumify.py` parses the information from a .neu file into a .tei file (this .tei file must already encode the text).