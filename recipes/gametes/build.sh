#!/bin/bash
set -eu -o pipefail

#create target directory
PACKAGE_HOME=$PREFIX/share/$PKG_NAME-$PKG_VERSION-$PKG_BUILDNUM
mkdir -p "$PACKAGE_HOME"

#create bin
BINARY_HOME="$PREFIX/bin"
mkdir -p "$BINARY_HOME"

#cd $SRC_DIR
#cp -R * $PACKAGE_HOME

JAR_NAME=GAMETES_2.1.jar

mv $JAR_NAME $PACKAGE_HOME
cp $RECIPE_DIR/gametes.py ${PACKAGE_HOME}/gametes
#ln -s ${PACKAGE_HOME}/gametes.py ${BINARY_HOME}/gametes
ls -l $PACKAGE_HOME

chmod 0755 ${BINARY_HOME}/gametes

ln -s "$PACKAGE_HOME/gametes" "$BINARY_HOME"





