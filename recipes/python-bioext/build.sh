#!/bin/bash

if [ `uname -s` == "Darwin" ]; then
    export DYLD_FALLBACK_LIBRARY_PATH="${PREFIX}/lib"
else
    export LD_LIBRARY_PATH="${PREFIX}/lib"
fi

export FREETYPE2_ROOT=$PREFIX

$PYTHON setup.py install --single-version-externally-managed --record=record.txt

cp ${RECIPE_DIR}/activate.sh "${PREFIX}/etc/conda/activate.d/${PKG_NAME}_activate.sh"
cp ${RECIPE_DIR}/deactivate.sh "${PREFIX}/etc/conda/deactivate.d/${PKG_NAME}_deactivate.sh"

export TARGET=$PREFIX/usr/share/$PKG_NAME/reference_data

# Symlink reference data to /usr/local/share/$TARGET, since the site-packages
# path may vary depending on the python version
mkdir -p "$TARGET"
ln -s "$SP_DIR/BioExt/data/references" "$TARGET"
