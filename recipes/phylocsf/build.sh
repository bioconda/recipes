#!/bin/sh

# Create bin folder
mkdir -p $PREFIX/bin

echo " ======================= Downloading and compiling Opam ... ======================="

# Download and compile Opam to install Ocaml dependencies
wget https://github.com/ocaml/opam/releases/download/2.0.5/opam-full-2.0.5.tar.gz
tar -xf opam-full-2.0.5.tar.gz
cd opam-full-2.0.5
./configure
make lib-ext
make

echo " ======================= Setting up Opam environment ... ======================="
# Setup opam environment
./opam init -a --disable-sandboxing
eval $(./opam env)

echo " ======================= Testing pkg config ... ======================="
export PKG_CONFIG_PATH=$BUILD_PREFIX/lib/pkgconfig
# cd $BUILD_PREFIX/lib/pkgconfig
# pwd
# ls
# echo "Listing lib dir"
# which pkg-config
# echo "Package config output"
# pkg-config --debug --list-all
# pkg-config --debug gsl

echo " ======================= Installing OCaml dependencies ... ======================="
# Install OCaml dependencies
./opam install batteries ocaml-twt gsl ocamlfind -y

cd ..
echo " ======================= Building PhyloCSF ... ======================="
# Build PhyloCSF
make

# Give execution permission to binary
chmod +x PhyloCSF

# Move binary to bin folder
cp PhyloCSF $PREFIX/bin
cp PhyloCSF.Linux.x86_64 $PREFIX/bin
cp PhyloCSF_Parameters $PREFIX/bin
