#!/usr/bin/bash
set -xe
export USE_GL=1
if [[ "$OSTYPE" != "darwin"* ]]; then
  sed -i 's/-lEGL -lGLESv2/-lGL/' Makefile
fi
make prep
CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY" LDFLAGS="${LDFLAGS} -Wl,-rpath,$(PREFIX)/lib -Wl,-rpath-link,$(PREFIX)/lib" LDLIBS="-lxcb-glx -lxcb-dri2 -lexpat" prefix="${PREFIX}"  make -j ${CPU_COUNT}
mkdir -p $PREFIX/bin
cp gw $PREFIX/bin/gw
cp -n .gw.ini $PREFIX/bin/.gw.ini
chmod +x $PREFIX/bin/gw
chmod +rw $PREFIX/bin/.gw.ini

