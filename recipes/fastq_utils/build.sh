mkdir -p $PREFIX/bin

# Download the old Samtools fastq_utils needs for its bam.h

tar jxvf deps/samtools-0.1.19.tar.bz2 
pushd samtools-0.1.19
make INCLUDES="-I. -I$PREFIX/include -I$PREFIX/include/ncurses" LIBCURSES="-L$PREFIX/lib -lncurses -ltinfo"
#sed -i.bak -e 's/-lcurses/-lncurses/' Makefile
#sed -i.bak -e "s|CFLAGS=\s*-g\s*-Wall\s*-O2\s*|CFLAGS= -g -Wall -O2 -I$NCURSES_INCLUDE_PATH/ncurses/ -I$NCURSES_INCLUDE_PATH -L$NCURSES_LIB_PATH|g" Makefile
make
make razip
popd

#export C_INCLUDE_PATH="${PREFIX}/include"
#export CPP_INCLUDE_PATH="${PREFIX}/include"
#export CXX_INCLUDE_PATH="${PREFIX}/include"
#export CPLUS_INCLUDE_PATH="${PREFIX}/include"
#export LIBRARY_PATH="${PREFIX}/lib"

# Run the main install

make
make install

# Copy executables into prefix

cp bin/* $PREFIX/bin
