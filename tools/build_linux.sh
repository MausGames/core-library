#!/bin/bash

_PATH_="$(dirname "$(realpath "$0")")"

_PREFIX_="$_PATH_/../output/default"
_GLIBC_="$_PATH_/../output/glibc"
_LIBCXX_="$_PATH_/../output/libcxx"

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$_PREFIX_

_CMAKE_FLAGS_="-DCMAKE_INSTALL_PREFIX=$_PREFIX_ -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_BUILD_TYPE=MinSizeRel -DCMAKE_INTERPROCEDURAL_OPTIMIZATION=TRUE -DCMAKE_PLATFORM_NO_VERSIONED_SONAME=TRUE"

export CC="clang"
export CXX="clang++"
export LD="mold"
export CFLAGS="-Os -flto -fno-semantic-interposition -fvisibility=hidden -msse3 -isystem $_GLIBC_/include"
export CXXFLAGS="-Os -flto -fno-semantic-interposition -fvisibility=hidden -msse3 -fno-rtti -fno-exceptions -isystem $_LIBCXX_/include/c++/v1 -isystem $_GLIBC_/include -nostdinc++"
export LDFLAGS="-fuse-ld=mold -flto -L$_LIBCXX_/lib -L/$_GLIBC_/lib -nostdlib++ -l:libc++.so -Wl,-rpath,\$ORIGIN -Wl,--gc-sections -Wl,--icf=all -Wl,--ignore-data-address-equality -Wl,--allow-shlib-undefined -z nodlopen"

cd "$_PATH_/../modules/SDL"
mkdir build
cd build
rm CMakeCache.txt
cmake $_CMAKE_FLAGS_ -S .. -B . -DBUILD_SHARED_LIBS=ON -DSDL_X11_SHARED=ON -DSDL_WAYLAND_SHARED=ON -DSDL_AUDIO=OFF -DSDL_RENDER=OFF -DSDL_HAPTIC=OFF -DSDL_OFFSCREEN=OFF -DSDL_VULKAN=OFF -DSDL_METAL=OFF -DSDL_WAYLAND_QT_TOUCH=OFF -DSDL_DBUS=OFF -DSDL_VIRTUAL_JOYSTICK=OFF -DSDL_RPATH=OFF
make -j 10
make install
make clean

cd "$_PATH_/../modules/SDL_image"
mkdir build
cd build
rm CMakeCache.txt
cmake $_CMAKE_FLAGS_ -S .. -B . -DSDL2IMAGE_AVIF=OFF -DSDL2IMAGE_BMP=OFF -DSDL2IMAGE_GIF=OFF -DSDL2IMAGE_JPG=OFF -DSDL2IMAGE_JXL=OFF -DSDL2IMAGE_LBM=OFF -DSDL2IMAGE_PCX=OFF -DSDL2IMAGE_PNG=ON -DSDL2IMAGE_PNM=OFF -DSDL2IMAGE_QOI=OFF -DSDL2IMAGE_SVG=OFF -DSDL2IMAGE_TGA=OFF -DSDL2IMAGE_TIF=OFF -DSDL2IMAGE_WEBP=OFF -DSDL2IMAGE_XCF=OFF -DSDL2IMAGE_XPM=OFF -DSDL2IMAGE_XV=OFF -DSDL2IMAGE_DEPS_SHARED=OFF -DSDL2IMAGE_BACKEND_STB=ON
make -j 10
make install
make clean

cd "$_PATH_/../modules/SDL_ttf"
mkdir build
cd build
rm CMakeCache.txt
cmake $_CMAKE_FLAGS_ -S .. -B . -DSDL2TTF_HARFBUZZ=ON -DSDL2TTF_VENDORED=ON -DSDL2TTF_SAMPLES=OFF
make -j 10
make install
make clean

cd "$_PATH_/../modules/zstd"
cd build
cd cmake
rm CMakeCache.txt
cmake $_CMAKE_FLAGS_ -DZSTD_BUILD_PROGRAMS=OFF -DZSTD_BUILD_STATIC=OFF -DZSTD_MULTITHREAD_SUPPORT=OFF -DZSTD_LEGACY_SUPPORT=OFF
make -j 10
make install
make clean

export CXXFLAGS="-Os -flto -fwhole-program-vtables -fno-semantic-interposition -fvisibility=hidden -msse3 -fno-rtti -isystem $_LIBCXX_/include/c++/v1 -isystem $_GLIBC_/include -nostdinc++"

cd "$_PATH_/../modules/openal-soft"
mkdir build
cd build
rm CMakeCache.txt
cmake $_CMAKE_FLAGS_ -S .. -B . -DALSOFT_BACKEND_OSS=OFF -DALSOFT_BACKEND_WAVE=OFF -DALSOFT_EXAMPLES=OFF
make -j 10
make install
make clean