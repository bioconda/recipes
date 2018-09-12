#!/usr/bin/env bash
# Build file is copied from VarScan
# https://github.com/bioconda/bioconda-recipes/blob/master/recipes/varscan/build.sh
# This file was automatically generated by the sbt-bioconda plugin.

outdir=$PREFIX/share/$PKG_NAME
mkdir -p $outdir
mkdir -p $PREFIX/bin
cp BamStats-assembly-1.0.jar $outdir/BamStats-assembly-1.0.jar
cp $RECIPE_DIR/biopet-bamstats.py $outdir/biopet-bamstats
ln -s $outdir/biopet-bamstats $PREFIX/bin

