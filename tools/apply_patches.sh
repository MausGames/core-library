#!/bin/bash

_PATH_="$(dirname "$(realpath "$0")")"

find "$_PATH_/../patches" -maxdepth 1 -iname "*.patch" | while read file; do

    git -C "$_PATH_/../modules/$(basename "$file" .patch)" apply "$file"

done