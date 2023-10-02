#!/bin/bash

GENOME_DIR="./"

config_file_path="$HOME/.seqstr.config"
if [ ! -f "$config_file_path" ]; then
    touch "$config_file_path"
fi

echo "GENOME_DIR=$GENOME_DIR" > "$config_file_path"

conda install -c conda-forge -y requests pyfaidx

$PREFIX/bin/python -m pip install .

mkdir -p "$PREFIX/bin"
cp "$SRC_DIR/seqstr/seqstr" "$PREFIX/bin/"
chmod +x "$PREFIX/bin/seqstr"
