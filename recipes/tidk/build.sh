#!/bin/bash -e

# taken from https://github.com/bioconda/bioconda-recipes/blob/25ee21573c577aa1ae899e0f7fbbc848d8a63865/recipes/longshot/build.sh

# this build script is taken from the rust-bio-tools recipe
# https://github.com/bioconda/bioconda-recipes/blob/master/recipes/rust-bio-tools/build.sh

# taken from yacrd recipe, see: https://github.com/bioconda/bioconda-recipes/blob/2b02c3db6400499d910bc5f297d23cb20c9db4f8/recipes/yacrd/build.sh
if [ "$(uname)" == "Darwin" ]; then

    # apparently the HOME variable isn't set correctly, and circle ci output indicates the following as the home directory
    export HOME="/Users/distiller"
    export HOME=`pwd`

    # according to https://github.com/rust-lang/cargo/issues/2422#issuecomment-198458960 removing circle ci default configuration solves cargo trouble downloading crates
    #git config --global --unset url.ssh://git@github.com.insteadOf

fi

RUST_BACKTRACE=1

# build statically linked binary with Rust
C_INCLUDE_PATH=$PREFIX/include OPENSSL_DIR=$PREFIX LIBRARY_PATH=$PREFIX/lib cargo install --verbose --path . --root $PREFIX
