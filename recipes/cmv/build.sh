#!/bin/bash
export LIBRARY_PATH="${PREFIX}/lib:/lib64/"
export LD_LIBRARY_PATH="${PREFIX}/lib:/lib64/"
export LDFLAGS="-L${PREFIX}/lib -pthread -lpthread"
export CPPFLAGS="-I${PREFIX}/include"

stack setup -ghc-build 'standard'
stack update
stack install --extra-include-dirs ${PREFIX}/include --local-bin-path ${PREFIX}/bin
#cleanup
rm -r .stack-work

