#!/bin/bash

_PATH_="$(dirname "$(realpath "$0")")"

_PREFIX_="$_PATH_/../output/libcxx"
_ROOT_="$_PATH_/../modules"
_GLIBC_="$_PATH_/../output/glibc"

_CMAKE_FLAGS_="-DCMAKE_PREFIX_PATH=$_PREFIX_ -DCMAKE_INSTALL_PREFIX=$_PREFIX_ -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_LINKER_TYPE=MOLD -DCMAKE_BUILD_TYPE=MinSizeRel -DCMAKE_PLATFORM_NO_VERSIONED_SONAME=TRUE"

_SHARED_FLAGS_="-Os -flto -fvisibility=hidden -fno-strict-overflow -fno-stack-protector -fno-semantic-interposition -msse3"

export CC="clang"
export CXX="clang++"
export LD="mold"
export CFLAGS="$_SHARED_FLAGS_ -isystem $_GLIBC_/include"
export CXXFLAGS="$_SHARED_FLAGS_ -fwhole-program-vtables -fvirtual-function-elimination -fforce-emit-vtables -fstrict-vtable-pointers -isystem $_GLIBC_/include"
export LDFLAGS="-fuse-ld=mold -flto -Wl,-rpath,\$ORIGIN -Wl,--gc-sections -Wl,--icf=all -Wl,--ignore-data-address-equality -Wl,--as-needed -Wl,--allow-shlib-undefined -z nodlopen -L$_GLIBC_/lib"

cd "$_ROOT_/llvm-project"
rm -r build
mkdir build
cmake $_CMAKE_FLAGS_ -G Ninja -S runtimes -B build -DLLVM_ENABLE_RUNTIMES="libcxx;libcxxabi" -DLIBCXX_ENABLE_STATIC=OFF -DLIBCXX_ENABLE_RTTI=ON -DLIBCXX_ENABLE_EXCEPTIONS=OFF -DLIBCXX_INCLUDE_TESTS=OFF -DLIBCXX_INCLUDE_BENCHMARKS=OFF -DLIBCXX_INSTALL_MODULES=OFF -DLIBCXX_ABI_UNSTABLE=ON -DLIBCXX_ENABLE_STATIC_ABI_LIBRARY=ON -DLIBCXX_ENABLE_ABI_LINKER_SCRIPT=OFF -DLIBCXXABI_USE_LLVM_UNWINDER=OFF -DLIBCXX_HARDENING_MODE=none
ninja -C build cxx cxxabi
ninja -C build check-cxx check-cxxabi
ninja -C build install-cxx install-cxxabi