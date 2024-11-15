#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o xtrace

cd "$SRC_DIR"

make -j "$CPU_COUNT"
install -d "$PREFIX/bin"
install -v -m 0755 build/bin/rdeval "$PREFIX/bin/"
