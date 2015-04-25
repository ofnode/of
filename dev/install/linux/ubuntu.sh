#!/bin/bash
# Tested on Ubuntu 12.04 and 14.04

sudo apt-get update
sudo apt-get -y upgrade

sudo apt-get -y install   \
git                       \
pkg-config                \
xorg-dev                  \
libgtk-3-dev              \
libudev-dev               \
llvm                      \
clang                     \
cmake                     \
ninja-build               \
libcairo2-dev             \
libusb-1.0-0-dev          \
libssl-dev                \
libfreetype6-dev          \
libfontconfig1-dev        \
libglu1-mesa-dev          \
libopenal-dev             \
libopencv-dev             \
libtbb-dev                \
libasound2-dev            \
libsndfile1-dev           \
gstreamer1.0-x            \
gstreamer1.0-alsa         \
gstreamer1.0-libav        \
gstreamer1.0-pulseaudio   \
gstreamer1.0-plugins-base \
gstreamer1.0-plugins-good \
gstreamer1.0-plugins-bad  \
gstreamer1.0-plugins-ugly \
libgstreamer1.0-dev       \
libgstreamer-plugins-base1.0-dev

# Use gold linker
sudo rm /usr/bin/ld && sudo ln -s `which gold` /usr/bin/ld

# Use default linker
#sudo rm /usr/bin/ld && sudo apt-get install --reinstall binutils

# Reinstall Mesa if CMake can't find OpenGL
#sudo apt-get -y install --reinstall libgl1-mesa-glx libgl1-mesa-dev

sudo ln -s /usr/bin/llvm-symbolizer* /usr/bin/llvm-symbolizer 2> /dev/null
