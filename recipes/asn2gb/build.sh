#!/bin/bash
#set -eu -o pipefail

set -e

gunzip -v *asn2gb.gz
mkdir -p "$PREFIX/bin"
cp *asn2gb $PREFIX/bin/asn2gb
chmod +x $PREFIX/bin/asn2gb

