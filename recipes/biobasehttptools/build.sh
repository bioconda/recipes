#!/bin/bash
export LIBRARY_PATH="${PREFIX}/lib"
export LD_LIBRARY_PATH="${PREFIX}/lib"
export LDFLAGS="-L${PREFIX}/lib"
export CPPFLAGS="-I${PREFIX}/include"

stack setup
stack update
stack install --extra-include-dirs ${PREFIX}/include --local-bin-path ${PREFIX}/bin
chmod 755 ${PREFIX}/bin/FetchSequence
chmod 755 ${PREFIX}/bin/AccessionToTaxId
chmod 755 ${PREFIX}/bin/GeneIdToGOTerms
chmod 755 ${PREFIX}/bin/GeneIdToUniProtId

#cleanup
rm -r .stack-work
