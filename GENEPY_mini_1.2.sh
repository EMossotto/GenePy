#!/bin/bash

GENE=$1

## WELCOME TO Mini GenePy

#module load conda/py2-latest

# store all the relevant GENE lines from the ALL_genepy.meta files and put it in a new file
grep "$GENE\s" ALL_genepy.meta > "$GENE".tmp1

# header is generated by doing |grep "^Chr" ALL_genepy.meta> header in the GenePy_Pipeline file
# combine the header and the relevant GENE data from ALL_genepy.meta into a new file
cat header "$GENE".tmp1 > "$GENE".meta

# Check if there is at least 1 variant within the GENE of interest
# if so then it will run the make_scores_mat_5.py with Subsetted variant file "$GENE".meta and gene name "$GENE" 
l=$(wc -l "$GENE".meta| cut -d " " -f 1)
if [ $l -gt 1 ]; then python make_scores_mat_5.py "$GENE".meta "$GENE"; echo DONE:$GENE; else echo ERROR:$GENE; fi
rm "$GENE".tmp1 "$GENE".meta 