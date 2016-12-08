#!/bin/bash

brew update

brew unlink boost
brew install boost --c++11
brew install Caskroom/cask/xquartz # Needed for Cairo
brew install libsndfile cairo ninja libusb assimp mpg123 tbb
travis_wait 30 brew install homebrew/science/opencv --c++11 --without-python --without-numpy --without-test

# Cairo dependencies automatically installed:
# libpng, freetype, fontconfig, pixman, gettext, libffi, glib, openssl, pkgconfig, cmake
