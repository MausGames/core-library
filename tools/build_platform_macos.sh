#!/bin/bash

_PATH_="$(dirname "$(realpath "$0")")"

_PREFIX_="$_PATH_/../output/platform/macos"
_ROOT_="$_PATH_/../modules"

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$_PREFIX_

_CMAKE_FLAGS_="-S .. -B . -DCMAKE_PREFIX_PATH=$_PREFIX_ -DCMAKE_INSTALL_PREFIX=$_PREFIX_ -DCMAKE_BUILD_TYPE=MinSizeRel -DCMAKE_PLATFORM_NO_VERSIONED_SONAME=TRUE -DCMAKE_OSX_ARCHITECTURES=arm64;x86_64 -DCMAKE_OSX_DEPLOYMENT_TARGET=10.13"

_SHARED_FLAGS_="-Os -flto -fvisibility=hidden -fno-strict-overflow -fno-stack-protector -D_Float16=float"

export CFLAGS="$_SHARED_FLAGS_"
export CXXFLAGS="$_SHARED_FLAGS_ -fvirtual-function-elimination -fforce-emit-vtables -fstrict-vtable-pointers -fno-rtti -fno-exceptions"
export LDFLAGS="-flto -Wl,-rpath,\$ORIGIN"

cd "$_ROOT_/SDL"
mkdir build
cd build
rm CMakeCache.txt
cmake $_CMAKE_FLAGS_ -DBUILD_SHARED_LIBS=ON -DSDL_AUDIO=OFF -DSDL_RENDER=OFF -DSDL_GPU=OFF -DSDL_HAPTIC=OFF -DSDL_CAMERA=OFF -DSDL_OPENGLES=OFF -DSDL_VULKAN=OFF -DSDL_METAL=OFF -DSDL_KMSDRM=OFF -DSDL_OFFSCREEN=OFF -DSDL_VIRTUAL_JOYSTICK=OFF -DSDL_RPATH=OFF -DSDL_ASSERTIONS=disabled -DSDL_TESTS=OFF -DSDL_EXAMPLES=OFF
cmake --build . --parallel
cmake --install .

cd "$_ROOT_/SDL_image"
mkdir build
cd build
rm CMakeCache.txt
cmake $_CMAKE_FLAGS_ -DBUILD_SHARED_LIBS=ON -DSDLIMAGE_AVIF=OFF -DSDLIMAGE_BMP=OFF -DSDLIMAGE_GIF=OFF -DSDLIMAGE_JPG=OFF -DSDLIMAGE_JXL=OFF -DSDLIMAGE_LBM=OFF -DSDLIMAGE_PCX=OFF -DSDLIMAGE_PNG=ON -DSDLIMAGE_PNM=OFF -DSDLIMAGE_QOI=OFF -DSDLIMAGE_SVG=OFF -DSDLIMAGE_TGA=OFF -DSDLIMAGE_TIF=OFF -DSDLIMAGE_WEBP=ON -DSDLIMAGE_XCF=OFF -DSDLIMAGE_XPM=OFF -DSDLIMAGE_XV=OFF -DSDLIMAGE_DEPS_SHARED=OFF -DSDLIMAGE_BACKEND_STB=ON -DSDLIMAGE_VENDORED=ON -DSDLIMAGE_BACKEND_IMAGEIO=OFF -DSDLIMAGE_TESTS=OFF -DSDLIMAGE_SAMPLES=OFF
cmake --build . --parallel
cmake --install .

cd "$_ROOT_/SDL_ttf"
mkdir build
cd build
rm CMakeCache.txt
cmake $_CMAKE_FLAGS_ -DBUILD_SHARED_LIBS=ON -DSDLTTF_HARFBUZZ=ON -DSDLTTF_PLUTOSVG=ON -DSDLTTF_VENDORED=ON -DSDLTTF_SAMPLES=OFF
cmake --build . --parallel
cmake --install .

cd "$_ROOT_/zstd"
cd build
cd cmake
rm CMakeCache.txt
cmake $_CMAKE_FLAGS_ -S . -DZSTD_BUILD_STATIC=OFF -DZSTD_BUILD_PROGRAMS=OFF -DZSTD_BUILD_TESTS=OFF -DZSTD_MULTITHREAD_SUPPORT=OFF -DZSTD_LEGACY_SUPPORT=OFF
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
cmake $_CMAKE_FLAGS_ -DBUILD_SHARED_LIBS=ON -DOP_DISABLE_HTTP=ON -DOP_DISABLE_EXAMPLES=ON -DOP_DISABLE_DOCS=ON
cmake --build . --parallel
cmake --install .

export CXXFLAGS="$CXXFLAGS -fwhole-program-vtables -frtti -fexceptions"

cd "$_ROOT_/openal-soft"
mkdir build
cd build
rm CMakeCache.txt
cmake $_CMAKE_FLAGS_ -DBUILD_SHARED_LIBS=ON -DALSOFT_BACKEND_JACK=OFF -DALSOFT_BACKEND_OSS=OFF -DALSOFT_BACKEND_WAVE=OFF -DALSOFT_EXAMPLES=OFF -DALSOFT_TESTS=OFF -DALSOFT_UTILS=OFF
cmake --build . --parallel
cmake --install .