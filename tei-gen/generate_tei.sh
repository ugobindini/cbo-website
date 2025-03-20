#!/bin/bash

for piece in "$@"
do
    ./syll_to_tei.py $piece;
    ./neumify.py $piece;
    git add "tei/${piece}.tei";
done