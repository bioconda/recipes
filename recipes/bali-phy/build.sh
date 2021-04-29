#!/usr/bin/env bash

set -vex

# C++17 is not properly supported on early OSX versions
if [ "$(uname)" = 'Darwin' ] ; then
    export MACOSX_DEPLOYMENT_TARGET=10.14
fi

export BOOST_ROOT="${PREFIX}"
export PKG_CONFIG_LIBDIR="${PREFIX}"/lib/pkgconfig

pkg-config --list-all
pkg-config --cflags cairo

echo "CC=$CC"
echo "CFLAGS=$CFLAGS"
echo "CXX=$CXX"
echo "CXXFLAGS=$CXXFLAGS"
echo "Removing -O2 and -std=c++14 from CXXFLAGS..."
CXXFLAGS="$(echo $CXXFLAGS | sed 's/-O2//g' | sed 's/-std=c++14//g')"
echo "CXXFLAGS=$CXXFLAGS"

# configure
meson \
    --prefix="$PREFIX" \
    --buildtype=release \
    -Db_ndebug=true \
    builddir .

cd builddir

cat meson-logs/meson-log.txt

# build
meson compile

# test
meson test

# install
meson install
