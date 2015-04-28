#!/bin/bash

brew update
brew install Caskroom/cask/xquartz # needed for cairo
brew install libsndfile cairo pkgconfig cmake openssl libusb
brew install homebrew/science/opencv --c++11 --without-python --without-numpy --without-tests

# cairo dependencies automatically installed:
# libpng, freetype, fontconfig, pixman, gettext, libffi, glib
