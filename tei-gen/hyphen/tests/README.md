# Latin hyphenation tests

This directory gathers some interesting tests for an hyphenation algorithm.

## Word lists

The file [listwords.txt](listwords.txt) is a list of words come from multiple sources listing difficult hyphenations.

The files `wordlist-x-y.txt` are lists of hyphenated words reviewed by Claudio Beccari, Solesmes Abbey and Flavigny Abbey. According to current usage in Catholic Church books, only words of more than two syllables carry the accent in the dedicated files.

The file [orberg.txt](orberg.txt) contains a list of etymological hyphenation points given in Hans Ørberg's method ([*Lingua Latina* Pars I, 2003, ISBN 8799701650, Index Vocabulorum, p. 313s](https://books.google.fr/books?id=YyVfH9p9cCIC&printsec=frontcover&hl=fr&source=gbs_ge_summary_r&cad=0#v=onepage&q&f=false)). It does not mark all hyphenation points though.

## Automatic testing

The script `test.py` in the `scripts` folder can automatically test the patterns in the `patterns` folder against the list of words in this folder. See the scripts [Readme.md](../scripts/README.md).
