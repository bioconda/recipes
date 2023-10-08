#!/bin/bash

# If it has Build.PL use that, otherwise use Makefile.PL
set -x -e

RM_DIR=${PREFIX}/share/perl-parallel-runner
mkdir -p ${RM_DIR}
cp -r ${SRC_DIR}/perl-parallel-runner-0.013/* ${RM_DIR}

    cpan -i Module::Build
    perl Build.PL
    ./Build
    ./Build test
    # Make sure this goes in site
    ./Build install --installdirs site
