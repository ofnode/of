#!/bin/bash

brew update
brew install Caskroom/cask/xquartz # needed for cairo
brew install libsndfile cairo pkgconfig

# cairo dependencies automatically installed:
# libpng, freetype, fontconfig, pixman, gettext, libffi, glib
