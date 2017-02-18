#!/bin/bash

set -eu -o pipefail

cd src

# If it has Build.PL use that, otherwise use Makefile.PL
if [ -f Build.PL ]; then
    (echo yes; yes '') | perl Build.PL
    perl -i.bak -wpe 's[^#!.+][#!/usr/bin/env perl]' Build
    ./Build
    ./Build test
    # Make sure this goes in site
    ./Build install --installdirs site
elif [ -f Makefile.PL ]; then
    # Make sure this goes in site
    perl Makefile.PL INSTALLDIRS=site
    make
    make test
    make install
else
    echo 'Unable to find Build.PL or Makefile.PL. You need to modify build.sh.'
    exit 1
fi

# Add more build steps here, if they are necessary.

# See
# http://docs.continuum.io/conda/build.html
# for a list of environment variables that are set during the build process.

mv ../libexec/bin/gff3_merge $PREFIX/bin/gff3_merge
mv ../libexec/bin/maker $PREFIX/bin/maker
