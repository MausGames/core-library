#!/bin/bash

_PATH_="$(dirname "$(realpath "$0")")"

_PREFIX_="$_PATH_/../output/glibc"
_ROOT_="$_PATH_/../modules"

export CFLAGS="-Os"

cd "$_ROOT_/glibc"
#rm -r build
mkdir build
cd build
../configure --prefix=$_PREFIX_ --without-selinux --disable-werror --disable-timezone-tools
make -j 10
make install
#make clean