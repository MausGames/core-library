#!/bin/bash

strip -S -x libopenal.dylib
strip -S -x libzstd.dylib

install_name_tool -id @rpath/libopenal.dylib libopenal.dylib
install_name_tool -id @rpath/libzstd.dylib libzstd.dylib

#install_name_tool -change @rpath/libvorbis.0.4.9.dylib @rpath/libvorbis.dylib libvorbisfile.dylib