#!/bin/bash -e

# Build with Rust
cargo build --release

# Install the binaries
cargo install --root $PREFIX
