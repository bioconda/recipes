#!/usr/bin/env bash

R -e 'install.packages(c("minpack.lm", "argparse"))'
R -e 'install.packages(".", repos=NULL, type="source")'
