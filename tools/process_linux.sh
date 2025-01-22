#!/bin/bash

#patchelf --replace-needed libSDL2-2.0.so libSDL2.so libSDL2_ttf.so
#patchelf --replace-needed libSDL2-2.0.so libSDL2.so libSDL2_image.so

../../CoreEngine/tools/scripts/strip_soname.sh  "$PWD"
../../CoreEngine/tools/scripts/strip_symbols.sh "$PWD"