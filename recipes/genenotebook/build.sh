#!/bin/bash

set -exo pipefail

# sudo yum install libstdc++

outdir=${PREFIX}/share/${PKG_NAME}-${PKG_VERSION}-${PKG_BUILDNUM}
mkdir -p $outdir $PREFIX/bin
pwd
ls -lah .

npm install --unsafe-perm
# ls -lah /usr/lib64/libstdc*
# strings /usr/lib64/libstdc* | grep GLIBC

METEOR_NODE_PATH=$(meteor node -e 'console.log(process.execPath)')
NODE_PATH=$(which node)

mv ${METEOR_NODE_PATH} ${METEOR_NODE_PATH}.bak
cp ${NODE_PATH} ${METEOR_NODE_PATH}
meteor node -v

METEOR_ALLOW_SUPERUSER=1 METEOR_DISABLE_OPTIMISTIC_CACHING=1 npm run bundle

cp -R genenotebook_v${PKG_VERSION}/* $outdir

ln -s ${outdir}/genenotebook ${PREFIX}/bin/genenotebook

