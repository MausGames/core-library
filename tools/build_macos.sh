#!/bin/bash

_PATH_="$(dirname "$(realpath "$0")")"

_PREFIX_="$_PATH_/../output/default"

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$_PREFIX_

_CMAKE_FLAGS_="-DCMAKE_INSTALL_PREFIX=$_PREFIX_ -DCMAKE_BUILD_TYPE=MinSizeRel -DCMAKE_INTERPROCEDURAL_OPTIMIZATION=TRUE -DCMAKE_OSX_ARCHITECTURES=arm64;x86_64 -DCMAKE_OSX_DEPLOYMENT_TARGET=10.13"

export CFLAGS="-Os -flto -fvisibility=hidden"
export CXXFLAGS="-Os -flto -fwhole-program-vtables -fvisibility=hidden -fno-rtti"
export LDFLAGS="-flto -Wl,-rpath,\$ORIGIN"

cd "$_PATH_/../modules/SDL"
./autogen.sh
./configure --prefix=$_PREFIX_ --disable-static --enable-x11-shared --enable-wayland-shared --disable-audio --disable-render --disable-haptic --disable-video-offscreen --disable-video-opengles --disable-video-vulkan --disable-video-metal --disable-video-wayland-qt-touch --disable-ime --disable-ibus --disable-fcitx --disable-joystick-virtual --disable-rpath

cd "$_PATH_/../modules/SDL_image"
./autogen.sh
./configure --prefix=$_PREFIX_ --disable-static --enable-avif=no --enable-bmp=no --enable-gif=no --enable-jpg=no --enable-jxl=no --enable-lbm=no --enable-pcx=no --enable-pnm=no --enable-qoi=no --enable-svg=no --enable-tga=no --enable-tif=no --enable-xcf=no --enable-xpm=no --enable-xv=no --enable-webp=no --enable-png-shared=no

cd "$_PATH_/../modules/SDL_ttf"
./autogen.sh
./configure --prefix=$_PREFIX_ --disable-static

cd "$_PATH_/../modules/zstd"
cd build
cd cmake
rm CMakeCache.txt
cmake $_CMAKE_FLAGS_ -DZSTD_BUILD_PROGRAMS=OFF -DZSTD_BUILD_STATIC=OFF -DZSTD_MULTITHREAD_SUPPORT=OFF -DZSTD_LEGACY_SUPPORT=OFF
make -j 6
make install
make clean

cd "$_PATH_/../modules/openal-soft"
mkdir build
cd build
rm CMakeCache.txt
cmake $_CMAKE_FLAGS_ -S .. -B . -DALSOFT_BACKEND_OSS=OFF -DALSOFT_BACKEND_WAVE=OFF -DALSOFT_EXAMPLES=OFF
make -j 6
make install
make clean