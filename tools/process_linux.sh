#!/bin/bash

#patchelf --replace-needed libSDL2-2.0.so libSDL2.so libSDL2_ttf.so
#patchelf --replace-needed libSDL2-2.0.so libSDL2.so libSDL2_image.so

../../core-engine/tools/scripts/strip_soname.sh  "$PWD"
../../core-engine/tools/scripts/strip_symbols.sh "$PWD"