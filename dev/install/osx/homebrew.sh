#!/bin/bash

# Workaround for issue #15
sudo cp /usr/include/assert.h /usr/local/include/

brew update > /dev/null

brew install --quiet boost --c++11
brew install --quiet Caskroom/cask/xquartz # Needed for Cairo
brew install --quiet libsndfile cairo pkgconfig cmake ninja openssl libusb assimp mpg123
brew install --quiet homebrew/science/opencv --c++11 --without-python --without-numpy --without-tests

# Cairo dependencies automatically installed:
# libpng, freetype, fontconfig, pixman, gettext, libffi, glib
