#!/bin/bash

chmod u+x install.sh
./install.sh
mkdir -p ${PREFIX}/bin
cp bin/* ${PREFIX}/bin
cp -r databases ${PREFIX}
