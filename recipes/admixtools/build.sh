# clear out pre-built objects and executables
cd src
make clobber

make CFLAGS="$CFLAGS" LDFLAGS="$LDFLAGS" LDLIBS="-lpthread" all

make install TOP=$PREFIX/bin
