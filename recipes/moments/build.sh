#!/bin/bash

cd $SRC_DIR/moments

$PYTHON setup.py build_ext --inplace
$PYTHON setup.py install
