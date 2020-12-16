#!/bin/bash

# Info we do not use the Makefile provided by the tool because include the building of an third part tool (bamtools)
# that can be retrived already compiled from conda.
#

export INCLUDE_PATH="${PREFIX}/include/"
export LIBRARY_PATH="${PREFIX}/lib"
export LD_LIBRARY_PATH="${PREFIX}/lib"

echo "print prefix"
ls -s ${PREFIX}
echo "print reicpe dir"
ls -s ${RECIPE_DIR}

# prepare lib installed from bamtools
cp ${PREFIX}/lib/libbamtools.a .
cp -r ${PREFIX}/include/bamtools/api/ .
for i in api/*.h;do sed -i.bak "s#api/##g" $i;done
cp -r ${PREFIX}/include/bamtools/shared/ api/
for i in api/shared/*.h;do sed -i.bak "s#shared/##g" $i;done

# prepare flag
CXXFLAGS="-O3 -L./"
#now compile
${CXX} ${CXXFLAGS} bamaddrg.cpp -o ${PREFIX}/bin/bamaddrg -lbamtools -lz
# make it executable
chmod +x ${PREFIX}/bin/bamaddrg
