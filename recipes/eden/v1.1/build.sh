export CFLAGS="-I$PREFIX/include"
export LDFLAGS="-L$PREFIX/lib"

export CXXFLAGS="$CXXFLAGS -I$PREFIX/include"

sed -i "s|-c EDeN.cc|$CFLAGS $LDFLAGS -c EDeN.cc|" Makefile
make
mkdir -p ${PREFIX}/bin
cp EDeN ${PREFIX}/bin
