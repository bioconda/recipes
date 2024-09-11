#!/bin/bash

set -exuo pipefail

readonly PROGRAMS=(
    qTMclust
    USalign
    TMalign
    TMscore
    MMalign
    se
    pdb2xyz
    xyz_sfetch
    pdb2fasta
    pdb2ss
    NWalign
    HwRMSD
    cif2pdb
    pdbAtomName
    addChainID
)

cd "${SRC_DIR}"

make -j${CPU_COUNT} CC="${CXX}" LDFLAGS="-lm"

install -d "${PREFIX}/bin"

install -m 755 "${PROGRAMS[@]}" "${PREFIX}/bin/"
