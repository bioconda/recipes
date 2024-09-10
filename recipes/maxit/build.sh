#!/bin/bash

set -exo pipefail

# Disable parallel build
export CPU_COUNT=1

export RCSBROOT="${SRC_DIR}"

case "${OSTYPE}" in
    darwin*)
        alias sed="${BUILD_PREFIX}/bin/sed"

        if [[ "$(uname -m)" == "x86_64" ]]; then
            ln -s "${GXX}" "${BUILD_PREFIX}/bin/gcc"
            ln -s "${GXX}" "${BUILD_PREFIX}/bin/g++"
        elif [[ "$(uname -m)" == "arm64" ]]; then
            # ln -s $(which gcc) "${BUILD_PREFIX}/bin/gcc"
            # ln -s $(which g++) "${BUILD_PREFIX}/bin/g++"
            echo '${BUILD_PREFIX}/bin'
            ls -l "${BUILD_PREFIX}/bin"
            export PATH="${CONDA_PREFIX}/bin:${BUILD_PREFIX}/bin:${PATH}"
            echo $(which gcc)
            echo $(which g++)
            echo $(which c++)
            clang_version=$(${BUILD_PREFIX}/bin/clang --version)
            clangxx_version=$(${BUILD_PREFIX}/bin/clangxx --version)
            echo ${clang_version}
            echo ${clangxx_version}
            cxx_version=$(c++ --version)
            gcc_version=$(gcc --version)
            echo ${cxx_version}
            echo ${gcc_version}
        fi
        ;;

    linux*)
        # To pass CI test on amd64 platforms
        ulimit -v 2097152

        ln -s "${CC}" "${BUILD_PREFIX}/bin/gcc"
        ln -s "${GXX}" "${BUILD_PREFIX}/bin/g++"
        ;;
    *)
        exit 1
        ;;
esac

cd ${SRC_DIR}/maxit-v10.1/src && \
sed -i "s|rcsbroot = getenv(\"RCSBROOT\")|rcsbroot = \"${RCSBROOT}\"|g" maxit.C process_entry.C generate_assembly_cif_file.C

cd "${SRC_DIR}/cifparse-obj-v7.0" && sed -i 's|mv |cp |g' Makefile
cd "${SRC_DIR}" && sed -i "s|./data/binary|${RCSBROOT}/data/binary|g" binary.sh
cd "${SRC_DIR}" && make binary -j${CPU_COUNT}

unlink "${BUILD_PREFIX}/bin/gcc"
unlink "${BUILD_PREFIX}/bin/g++"

install -d "${PREFIX}/bin"
install ${SRC_DIR}/bin/* "${PREFIX}/bin"

install -d "${PREFIX}/data"
find "${SRC_DIR}/data" -type d -exec install -d "${PREFIX}/data/{}" \;
find "${SRC_DIR}/data" -type f -exec install -m 644 "{}" "${PREFIX}/data/{}" \;
