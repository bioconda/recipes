#!/bin/bash
export LIBRARY_PATH="${PREFIX}/lib:/lib64/"
export LD_LIBRARY_PATH="${PREFIX}/lib:/lib64/"

stack setup
stack update
stack install --extra-include-dirs ${PREFIX}/include --local-bin-path ${PREFIX}/bin
#cleanup
rm -r .stack-work

