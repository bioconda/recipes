#!/bin/bash
mkdir -p "$PREFIX/bin"
export MACHTYPE=$(uname -m)
export BINDIR=$(pwd)/bin
export L="${LDFLAGS}"
mkdir -p "$BINDIR"
(cd kent/src/lib && make -j ${CPU_COUNT})
(cd kent/src/htslib && make -j ${CPU_COUNT})
(cd kent/src/jkOwnLib && make -j ${CPU_COUNT})
(cd kent/src/hg/lib && make -j ${CPU_COUNT})
(cd kent/src/hg/makeDb/hgGcPercent && make -j ${CPU_COUNT})
cp bin/hgGcPercent "$PREFIX/bin"
chmod +x "$PREFIX/bin/hgGcPercent"
