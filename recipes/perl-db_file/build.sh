#!/bin/bash

export C_INCLUDE_PATH=${PREFIX}/include
export LD_LIBRARY_PATH=${PREFIX}/lib
sed -i 's=/usr/local/BerkeleyDB/include='"${C_INCLUDE_PATH}"'=' config.in

# If it has Build.PL use that, otherwise use Makefile.PL
if [ -f Build.PL ]; then
    Build.PL
    ./Build
    ./Build test
    # Make sure this goes in site
    perl ./Build install --installdirs site
elif [ -f Makefile.PL ]; then
    # Make sure this goes in site
    perl Makefile.PL
    make
    make test
    make install
else
    echo 'Unable to find Build.PL or Makefile.PL. You need to modify build.sh.'
    exit 1
fi
