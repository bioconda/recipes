#!/bin/bash

PVALUE_TABLE="$PREFIX/share/3seq/PVT.3SEQ.2017.700";
mv ${HOME}/Library/3seq/3seq.conf ${HOME}/Library/3seq/default.3seq.conf
echo "$PVALUE_TABLE" > ${HOME}/Library/3seq/3seq.conf
