#!/bin/bash
mkdir -p "$PREFIX/bin"
if [ "$(uname)" == "Darwin" ]; then
    cp genePredToMafFrames "$PREFIX/bin"
else
    export MACHTYPE=x86_64
    export BINDIR=$(pwd)/bin
    export C_INCLUDE_PATH="$BUILD_PREFIX/include"
    mkdir -p "$BINDIR"
    (cd kent/src/lib && make)
    (cd kent/src/htslib && make)
    (cd kent/src/jkOwnLib && make)
    (cd kent/src/hg/lib && make)
    (cd kent/src/hg/genePredToMafFrames && make)
    cp bin/genePredToMafFrames "$PREFIX/bin"
fi
chmod +x "$PREFIX/bin/genePredToMafFrames"
