#!/bin/bash

# -e = exit on first error
# -x = print every executed command
set -ex

# use nightly
rustup default nightly

# Build the package using maturin - should produce *.whl files.
maturin build --interpreter "${PYTHON}" --release --strip

# Install *.whl files using pip
$PYTHON -m pip install target/wheels/*.whl --no-deps --no-build-isolation --no-cache-dir -vvv
