export CXXFLAGS=-I$PREFIX/include
export LDFLAGS=-L$PREFIX/lib
cmake -DCMAKE_INSTALL_PREFIX=$PREFIX .
make hyphy HYPHYMPI
make install
