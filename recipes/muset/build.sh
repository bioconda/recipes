#!/bin/bash
set -e  # Exit on error
set -x  # Print commands for debugging

# Print the current directory for debugging
echo "Current directory: ${PWD}"
ls -lh

# Navigate to the muset directory (if the source code is in a subdirectory)
cd muset

# Create the output directory
mkdir -p ${PREFIX}/bin

# Create a build directory
mkdir -p build-conda
cd build-conda

# Configure the build with CMake
cmake .. -DCONDA_BUILD=ON

# Build the software
make -j${CPU_COUNT}

# Move back to the source directory
cd ../..

# Copy the binaries to the output directory
cp ./bin/kmat_tools ${PREFIX}/bin
cp ./bin/muset-kmtricks ${PREFIX}/bin
cp ./bin/muset ${PREFIX}/bin
cp ./bin/muset_pa ${PREFIX}/bin