#!/bin/bash
# In addition to the installed lib dir we want to set the path to the share
# when libopenms is used
# TODO does this propagate to dependent packages?
mkdir -p $PREFIX/etc/conda/activate.d/ $PREFIX/etc/conda/deactivate.d/
cp $RECIPE_DIR/activate.sh $PREFIX/etc/conda/activate.d/libopenms.sh
cp $RECIPE_DIR/deactivate.sh $PREFIX/etc/conda/deactivate.d/libopenms.sh


ls -la #TODO remove debug
cp -r build/lib/* $PREFIX/lib/
cp -r build/share/* $PREFIX/share/
cp -r build/include/* $PREFIX/include/