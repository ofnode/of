#!/bin/bash

brew update

brew install Caskroom/cask/xquartz # Needed for Cairo
brew install libsndfile cairo pkgconfig cmake openssl libusb assimp
brew install homebrew/science/opencv --c++11 --without-python --without-numpy --without-tests

# Cairo dependencies automatically installed:
# libpng, freetype, fontconfig, pixman, gettext, libffi, glib
