#!/bin/bash

# create IPR dir
IPR_DIR=${PREFIX}/share/InterProScan
mkdir -p ${IPR_DIR}

# cd into the core directory, where the master pom.xml file (Maven build file) is located.
cd core

# copy fingerprintscan exe - version from bioconda does not work
#cp jms-implementation/support-mini-x86-32/bin/prints/fingerPRINTScan ${PREFIX}/bin


# copy coils exe - version from bioconda does not work
#cp jms-implementation/support-mini-x86-32/bin/ncoils/2.2.1/ncoils ${PREFIX}/bin

# Run mvn clean install to build and install (into your local Maven repository) all of the modules for InterProScan 5.
mvn clean install

# cd into the jms-implementation directory and run mvn clean package
cd jms-implementation
mvn clean package

# copy result into the share folder
cp -r target/interproscan-5-dist/* ${IPR_DIR}/

# mv interproscan.sh in the bin
mkdir -p ${PREFIX}/bin
ln -s $IPR_DIR/interproscan.sh  ${PREFIX}/bin/

# copy properties file to replace the default one
cp ${RECIPE_DIR}/interproscan.properties ${IPR_DIR}/interproscan.properties

# Add more build steps here, if they are necessary.

# See
# http://docs.continuum.io/conda/build.html
# for a list of environment variables that are set during the build process.
