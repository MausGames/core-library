#!/bin/bash

_PATH_="$(dirname "$(realpath "$0")")"

_PREFIX_="$_PATH_/../output/platform/emscripten"
_ROOT_="$_PATH_/../modules"
_EMSCRIPTEN_="/opt/emsdk/upstream/emscripten"

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$_PREFIX_

_CMAKE_FLAGS_="-S .. -B . -DCMAKE_PREFIX_PATH=$_PREFIX_ -DCMAKE_INSTALL_PREFIX=$_PREFIX_ -DSDL3_DIR=$_PREFIX_/lib/cmake/SDL3 -DCMAKE_BUILD_TYPE=MinSizeRel -DCMAKE_TOOLCHAIN_FILE=$_EMSCRIPTEN_/cmake/Modules/Platform/Emscripten.cmake"

# fwhole-program-vtables (and others) needs to be in CFLAGS to prevent strange linker errors
_SHARED_FLAGS_="-Os -flto -fwhole-program-vtables -fvirtual-function-elimination -fforce-emit-vtables -fstrict-vtable-pointers -fno-strict-overflow -fno-stack-protector -msse3 -matomics -mbulk-memory -mextended-const -mmultivalue -mmutable-globals -mnontrapping-fptoint -mreference-types -msign-ext -msimd128 -mtail-call"

export CFLAGS="$_SHARED_FLAGS_"
export CXXFLAGS="$_SHARED_FLAGS_ -fno-rtti -fno-exceptions"
export LDFLAGS="-flto"

cd "$_ROOT_/SDL"
mkdir build
cd build
rm CMakeCache.txt
cmake $_CMAKE_FLAGS_ -DBUILD_SHARED_LIBS=OFF -DSDL_AUDIO=OFF -DSDL_RENDER=OFF -DSDL_GPU=OFF -DSDL_HAPTIC=OFF -DSDL_CAMERA=OFF -DSDL_OPENGL=OFF -DSDL_VULKAN=OFF -DSDL_KMSDRM=OFF -DSDL_OFFSCREEN=OFF -DSDL_VIRTUAL_JOYSTICK=OFF -DSDL_RPATH=OFF -DSDL_ASSERTIONS=disabled -DSDL_TESTS=OFF -DSDL_EXAMPLES=OFF
cmake --build . --parallel
cmake --install .

cd "$_ROOT_/SDL_image"
mkdir build
cd build
rm CMakeCache.txt
cmake $_CMAKE_FLAGS_ -DBUILD_SHARED_LIBS=OFF -DSDLIMAGE_AVIF=OFF -DSDLIMAGE_BMP=OFF -DSDLIMAGE_GIF=OFF -DSDLIMAGE_JPG=OFF -DSDLIMAGE_JXL=OFF -DSDLIMAGE_LBM=OFF -DSDLIMAGE_PCX=OFF -DSDLIMAGE_PNG=ON -DSDLIMAGE_PNM=OFF -DSDLIMAGE_QOI=OFF -DSDLIMAGE_SVG=OFF -DSDLIMAGE_TGA=OFF -DSDLIMAGE_TIF=OFF -DSDLIMAGE_WEBP=ON -DSDLIMAGE_XCF=OFF -DSDLIMAGE_XPM=OFF -DSDLIMAGE_XV=OFF -DSDLIMAGE_DEPS_SHARED=OFF -DSDLIMAGE_BACKEND_STB=ON -DSDLIMAGE_VENDORED=ON -DSDLIMAGE_TESTS=OFF -DSDLIMAGE_SAMPLES=OFF
cmake --build . --parallel
cmake --install .

cd "$_ROOT_/SDL_ttf"
mkdir build
cd build
rm CMakeCache.txt
cmake $_CMAKE_FLAGS_ -DBUILD_SHARED_LIBS=OFF -DSDLTTF_HARFBUZZ=ON -DSDLTTF_PLUTOSVG=ON -DSDLTTF_VENDORED=ON -DSDLTTF_SAMPLES=OFF
cmake --build . --parallel
cmake --install .

cd "$_ROOT_/zstd"
cd build
cd cmake
rm CMakeCache.txt
cmake $_CMAKE_FLAGS_ -S . -DZSTD_BUILD_SHARED=OFF -DZSTD_BUILD_PROGRAMS=OFF -DZSTD_BUILD_TESTS=OFF -DZSTD_MULTITHREAD_SUPPORT=OFF -DZSTD_LEGACY_SUPPORT=OFF
cmake --build . --parallel
cmake --install .

cd "$_ROOT_/ogg"
mkdir build
cd build
rm CMakeCache.txt
cmake $_CMAKE_FLAGS_ -DBUILD_SHARED_LIBS=OFF -DINSTALL_DOCS=OFF
cmake --build . --parallel
cmake --install .

cd "$_ROOT_/opus"
mkdir build
cd build
rm CMakeCache.txt
cmake $_CMAKE_FLAGS_ -DBUILD_SHARED_LIBS=OFF -DOPUS_HARDENING=OFF -DOPUS_FORTIFY_SOURCE=OFF -DOPUS_STACK_PROTECTOR=OFF
cmake --build . --parallel
cmake --install .

cd "$_ROOT_/opusfile"
mkdir build
cd build
rm CMakeCache.txt
cmake $_CMAKE_FLAGS_ -DBUILD_SHARED_LIBS=OFF -DOP_DISABLE_HTTP=ON -DOP_DISABLE_EXAMPLES=ON -DOP_DISABLE_DOCS=ON
cmake --build . --parallel
cmake --install .