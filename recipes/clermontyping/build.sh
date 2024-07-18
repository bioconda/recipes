#!/usr/bin/env bash

set -xe

CLERMONTYPING="${PREFIX}/share/${PKG_NAME}-${PKG_VERSION}"
mkdir -p ${PREFIX}/bin ${CLERMONTYPING}

# Use the share folder of R scripts and reference data
mv ${SRC_DIR}/bin ${CLERMONTYPING}
mv ${SRC_DIR}/data ${CLERMONTYPING}
chmod 755 ${CLERMONTYPING}/bin/*

# Edit Wrapper to use Share Folder
sed -i "s,^MY_PATH=$(dirname \"$0\"),MY_PATH=${CLERMONTYPING}," $SRC_DIR/clermonTyping.sh

# Copy wrapper into bin
cp $SRC_DIR/clermonTyping.sh ${PREFIX}/bin/
chmod 755 ${PREFIX}/bin/clermonTyping.sh
