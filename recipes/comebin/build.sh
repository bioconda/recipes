#!/usr/bin/env bash

mkdir -p $PREFIX/bin/ 
cp -r COMEBin $PREFIX/bin/
cp -r auxiliary $PREFIX/bin/
chmod a+x bin/run_comebin.sh
cp bin/run_comebin.sh $PREFIX/bin/

