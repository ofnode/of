#!/bin/bash

convert icon.png \
        \( -clone 0 -resize 16x16   \) \
        \( -clone 0 -resize 32x32   \) \
        \( -clone 0 -resize 48x48   \) \
        \( -clone 0 -resize 256x256 \) \
          -delete 0 -colors 256 -alpha background icon.ico

/opt/mxe/usr/bin/x86_64-w64-mingw32.static-windres icon.rc -O coff -o icon.res
