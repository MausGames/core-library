#!/bin/bash

strip -S -x libSDL2.dylib
strip -S -x libSDL2_ttf.dylib
strip -S -x libSDL2_image.dylib
strip -S -x libopenal.dylib
strip -S -x libzstd.dylib
strip -S -x libopusfile.dylib

install_name_tool -id @rpath/libSDL2.dylib       libSDL2.dylib
install_name_tool -id @rpath/libSDL2_ttf.dylib   libSDL2_ttf.dylib
install_name_tool -id @rpath/libSDL2_image.dylib libSDL2_image.dylib

install_name_tool -change @rpath/libSDL2-2.0.dylib @rpath/libSDL2.dylib libSDL2_ttf.dylib
install_name_tool -change @rpath/libSDL2-2.0.dylib @rpath/libSDL2.dylib libSDL2_image.dylib
