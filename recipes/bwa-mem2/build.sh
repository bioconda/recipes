#!/bin/bash

# https://github.com/intel/safestringlib/issues/14
if [[ $OSTYPE == "darwin"* ]]; then
    sed -i.bak "s#extern errno_t memset_s#//xxx extern errno_t memset_s#g" ext/safestringlib/include/safe_mem_lib.h
    sed -i.bak 's/memset_s/memset8_s/g' ext/safestringlib/include/safe_mem_lib.h
    sed -i.bak 's/memset_s/memset8_s/g' ext/safestringlib/safeclib/memset16_s.c
    sed -i.bak 's/memset_s/memset8_s/g' ext/safestringlib/safeclib/memset32_s.c
    sed -i.bak 's/memset_s/memset8_s/g' ext/safestringlib/safeclib/memset_s.c
    sed -i.bak 's/memset_s/memset8_s/g' ext/safestringlib/safeclib/wmemset_s.c
fi

case "$(arch)" in
  x86_64)
      LIBS="${LDFLAGS}" make CC="${CC}" CXX="${CXX}" multi ;;
  aarch64)
      mkdir ext/simde
      wget https://github.com/simd-everywhere/simde-no-tests/archive/refs/tags/v0.8.2.tar.gz -O - | tar -xvz
      mv simde-no-tests-0.8.2/* ext/simde/
      LIBS="${LDFLAGS}" make arch=native EXE=bwa-mem2 CC="${CC}" CXX="${CXX}" all
      ;;
  *)
      echo "Error detecting architecture" ;;
esac

mkdir -p $PREFIX/bin
cp bwa-mem2* $PREFIX/bin
