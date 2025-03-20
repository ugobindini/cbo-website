# Metrical information: .met files

This custom file format encodes metrical information. Strophes are separated by a double newline, metrical units (<lg type="metrical-unit") by a single newline.

An optional multiplier 'nx' can precede each strophe to indicate how many times that strophe is repeated (n). Optional attributes in the syntax @attribute=value can be specified for each strophe.

For each metrical unit, first an integer is specified (how many verses it contains), then optional attributes separated by white spaces.

The script `./metify.py` is in charge of parsing the information. It also spreads the metrical and rhyme information from the top level to the bottom level (verse) of the tei file.
