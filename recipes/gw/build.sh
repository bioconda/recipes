#!/usr/bin/bash
set -e

# Get pre-compiled skia from jetbrains
# USE_GL=1 make prep > /dev/null 2>&1 
# Build skia from scratch
ls

NAME=${PWD}/lib/skia
echo "Skia out folder is: $NAME"

cd ./lib
mkdir -p ${NAME}
mkdir -p build_skia && cd build_skia

# Detect architecture and OS
ARCH=$(uname -m)
OS=$(uname -s)

# Set default flags
EXTRA_CFLAGS=""
EXTRA_LDFLAGS=""

# Architecture-specific flags
if [ "$ARCH" = "x86_64" ]; then
    EXTRA_CFLAGS='extra_cflags=["-mavx2", "-mfma", "-mavx512f", "-mavx512dq", "-msse4.2", "-mpopcnt", "-frtti"]'
    EXTRA_LDFLAGS='extra_ldflags=["-mavx2", "-mfma", "-mavx512f", "-mavx512dq"]'
elif [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then
    EXTRA_CFLAGS='extra_cflags=["-march=armv8-a+crc+crypto", "-frtti"]'
    EXTRA_LDFLAGS='extra_ldflags=["-march=armv8-a+crc+crypto"]'
else
    echo "Unsupported architecture: $ARCH"
    exit 1
fi


# OS-specific flags
if [ "$OS" = "Darwin" ]; then
    # macOS-specific flags
    #SDK_PATH="/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk"
    #echo "SDK_PATH ${SDK_PATH}"
    #EXTRA_CFLAGS=$(echo "$EXTRA_CFLAGS" | sed 's/\]$//')
    #EXTRA_CFLAGS+=", \"-mmacosx-version-min=10.15\", \"-isysroot\", \"${SDK_PATH}\"]"

    #EXTRA_LDFLAGS=$(echo "$EXTRA_LDFLAGS" | sed 's/\]$//')
    #EXTRA_LDFLAGS+=", \"-mmacosx-version-min=10.15\", \"-isysroot\", \"${SDK_PATH}\"]"

    #EXTRA_ARGS="skia_use_gl=true"

    SDK_PATH=$(xcrun --show-sdk-path)
    echo "SDK_PATH ${SDK_PATH}"
    EXTRA_CFLAGS=$(echo "$EXTRA_CFLAGS" | sed 's/\]$//')
    EXTRA_CFLAGS+=", \"-mmacosx-version-min=11.0\", \"-isysroot\", \"${SDK_PATH}\", \"-DZLIB_CONST\", \"-std=c11\", \"-std=c++17\"]"
    EXTRA_LDFLAGS=$(echo "$EXTRA_LDFLAGS" | sed 's/\]$//')
    EXTRA_LDFLAGS+=", \"-mmacosx-version-min=11.0\", \"-isysroot\", \"${SDK_PATH}\"]"
    EXTRA_ARGS="skia_use_gl=true"
    
elif [ "$OS" = "Linux" ]; then
    # Linux-specific flags
    EXTRA_ARGS="skia_use_egl=true skia_use_gl=true skia_use_x11=true"
else
    echo "Unsupported OS: $OS"
    exit 1
fi

echo "Architecture: $ARCH"
echo "Operating System: $OS"
echo "Extra C flags: $EXTRA_CFLAGS"
echo "Extra LD flags: $EXTRA_LDFLAGS"
echo "Extra arguments: $EXTRA_ARGS"
export PATH="${CONDA_PREFIX}/bin:$PATH"

# Check system build tools available
echo "Using gn from: $(which gn)"
echo "Using ninja from: $(which ninja)"

#git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
#export PATH="${PWD}/depot_tools:${PATH}"
#depot_tools/fetch skia

git clone https://skia.googlesource.com/skia.git

cd skia
VERSION=m93
git checkout origin/chrome/${VERSION}
echo "Checked out Skia version: ${VERSION}"
echo "Using python3: " $(which python3)

# Patch gn to map aarch64 to arm64
sed -i.bak 's/cpu = {/cpu = {"aarch64": "arm64", /g' bin/fetch-gn

python3 tools/git-sync-deps

REL=Release

echo "STARTING SKIA BUILD"
which gn
which ninja

# Generate build files
gn gen out/${REL} --args="is_official_build=true \
    skia_use_system_icu=false \
    skia_use_system_zlib=false \
    skia_use_system_expat=false \
    skia_use_system_libjpeg_turbo=false \
    skia_use_system_libpng=false \
    skia_use_system_libwebp=false \
    skia_use_system_harfbuzz=false \
    skia_pdf_subset_harfbuzz=true \
    skia_enable_skottie=false \
    skia_use_dng_sdk=false \
    target_cpu=\"${ARCH}\" \
    ${EXTRA_CFLAGS} \
    ${EXTRA_LDFLAGS} \
    cc=\"clang\" \
    cxx=\"clang++\" \
    ${EXTRA_ARGS}"
gn args out/${REL} --list
ninja -C out/${REL}

echo "------------SKIA BUILD FINISHED---------------"
pwd
ls

mkdir -p ${NAME}/out/${REL}
mkdir -p ${NAME}/third_party/externals

cp -rf out/${REL}/* ${NAME}/out/${REL}
cp -rf include ${NAME}
cp -rf modules ${NAME}
cp -rf src ${NAME}

libs=( "freetype" "harfbuzz" "icu" "libpng" "zlib" )

for l in "${libs[@]}"
do
  echo $l
  mkdir -p ${NAME}/third_party/externals/${l}
  cp -rf third_party/externals/${l}/src ${NAME}/third_party/externals/${l}
  cp -rf third_party/externals/${l}/include ${NAME}/third_party/externals/${l}
  cp -rf third_party/externals/${l}/source ${NAME}/third_party/externals/${l}
  cp third_party/externals/${l}/*.h ${NAME}/third_party/externals/${l}
done

cp -rf third_party/icu ${NAME}/third_party

# clean up
cd ${NAME}
#rm -rf modules/skottie/tests
#rm -rf out/${REL}/obj
#rm -rf out/${REL}/gen
#rm -rf out/${REL}/gcc_like_host
#find . -name "*.clang-format" -type f -delete
#find . -name "*.gitignore" -type f -delete
#find . -name "*.md" -type f -delete
#find . -name "*.gn" -type f -delete
#find . -name "*.ninja" -type f -delete
#find . -name "*.cpp" -type f -delete
#find . -name "*.ninja.d" -type f -delete
#find . -name "*BUILD*" -type f -delete
#find . -name "*.txt" -type f -delete
#find . -name "test*" -type d -exec rm -rv {} +
cd ../

pwd
rm -rf build_skia
cd ../
echo "----------DONE PREPARING SKIA-------------"
pwd

if [[ "$OSTYPE" != "darwin"* ]]; then
  sed -i 's/-lEGL -lGLESv2/-lEGL -lGLESv2 -lGL -lGLX/' Makefile
  sed -i 's/GLFW_EGL_CONTEXT_API/GLFW_NATIVE_CONTEXT_API/' src/plot_manager.cpp
fi

# Set flags conditionally based on the OS type
if [[ "$OSTYPE" != "darwin"* ]]; then
  SYSROOT_FLAGS="--sysroot=${BUILD_PREFIX}/${HOST}/sysroot"
  CPPFLAGS="${CPPFLAGS} -I${BUILD_PREFIX}/${HOST}/sysroot/usr/include ${SYSROOT_FLAGS}"
  LDFLAGS="${LDFLAGS} -L${PREFIX}/lib -L${BUILD_PREFIX}/${HOST}/sysroot/usr/lib -L${BUILD_PREFIX}/${HOST}/sysroot/usr/lib64 ${SYSROOT_FLAGS}"
else
  # No sysroot settings for macOS
  SYSROOT_FLAGS=""
  CPPFLAGS="${CPPFLAGS}"
  LDFLAGS="${LDFLAGS} -L${PREFIX}"
fi

CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY" \
CPPFLAGS="${CPPFLAGS}" \
LDFLAGS="${LDFLAGS}" \
prefix="${PREFIX}" \
make -j ${CPU_COUNT}

mkdir -p $PREFIX/bin
cp gw $PREFIX/bin/gw
cp -n .gw.ini $PREFIX/bin/.gw.ini
chmod +x $PREFIX/bin/gw
chmod +rw $PREFIX/bin/.gw.ini
