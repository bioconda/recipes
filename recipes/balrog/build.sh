#!/bin/bash

cmake -DCMAKE_BUILD_TYPE=Release -G "CodeBlocks - Unix Makefiles" .
cmake --build ./cmake-build-release --target Balrog -- -j 3
make install