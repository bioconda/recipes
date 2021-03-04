#!/bin/bash

set -eu -o pipefail

export CPATH=${PREFIX}/include
export CMAKE_LDFLAGS="-L${PREFIX}/lib"
export LIBRARY_PATH=${PREFIX}/lib

scripts/install.py \
    --prefix ${PREFIX} \
    --gmp ${PREFIX} \
    --boost ${PREFIX} \
    --htslib ${PREFIX} \
    --architecture haswell \
    --static \
    --threads 2 \
    --verbose
