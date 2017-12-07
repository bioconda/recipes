#!/bin/sh

# create ex1.fa
printf ">seq1\nCACTAGTGGCTCATTGTAAATGTGTGGTTTAACTCGTCCATGGCCCAGCATTAGGGAGCTGTGGACCCTGCAGCCTGGCTGTGGGGGCCGCAGTGGCTGAGGGGTGCAGAGCCGAGTCAC\n>seq2\nTTCAAATGAACTTCTGTAATTGAAAAATTCATTTAAGAAATTACAAAATATAGTTGAAAGCTCTAACAATAGACTAAACCAAGCAGAAGAAAGAGGTTCAGAACTTGAAGACAAGTCTCT\n" > ex1.fa

# samtools can fail with exit 255 which is not picked up as an error
samtools faidx ex1.fa || exit 1

wgsim ex1.fa out.r1.fq out.r2.fq
