#!/usr/bin/env python3

# Adds adiastematic neumes from an input .neu file to a .tei file
# WARNING: The original input *.tei file will be overwritten

import argparse

from utils import in_out_filenames, neu_parser
from neume import *
from neume_component import register_basic_shapes


def assign_neumes(tei_syllables, neu_syllables):
    if len(tei_syllables) != len(neu_syllables):
        print(' '.join([x.text for x in tei_syllables]))
        print("WARNING: neumify.py: mismatch in the number of sillables.")
    for i in range(min(len(tei_syllables), len(neu_syllables))):
        if neu_syllables[i] != '.':
            music = ET.Element('notatedMusic')
            music.extend([Neume(x).mei() for x in neu_syllables[i].split(',')])
            tei_syllables[i].append(music)

if __name__ == "__main__":
    register_basic_shapes()

    parser = argparse.ArgumentParser()
    parser.add_argument('filename', nargs='+')

    args = parser.parse_args()

    for name in args.filename:
        neu_filename, tei_filename = in_out_filenames(name=name, in_extension="neu", out_extension="tei")
        print(f"Reading neume content information from input file neu/{neu_filename}")

        try:
            neu_file = open(f"neu/{neu_filename}", 'r')
        except:
            print("No .neu file found.")

        neu_strophes = neu_parser(neu_file)
        neu_file.close()

        tei_file = open(f"tei/{tei_filename}", 'r')
        tree = ET.parse(tei_file)
        tei_strophes = tree.getroot().findall(".//lg[@type='strophe']")
        tei_file.close()

        assert len(tei_strophes) == len(neu_strophes), f"ERROR: neumify.py: mismatch in the number of strophes. {len(tei_strophes)} tei, {len(neu_strophes)} neu."

        for i in range(len(tei_strophes)):
            tei_verses = tei_strophes[i].findall("./l")
            for j in range(min(len(tei_verses), len(neu_strophes[i]))):
                if neu_strophes[i][j] != '-':
                    # the verse is not empty
                    neu_syllables = neu_strophes[i][j].split(' ')
                    tei_syllables = tei_verses[j].findall(".//seg[@type='syll']")
                    assign_neumes(tei_syllables, neu_syllables)

        tei_file = open(f"tei/{tei_filename}", 'w')
        ET.indent(tree)
        tree.write(tei_file, encoding="unicode")
        tei_file.close()
