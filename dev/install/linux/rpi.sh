#!/bin/bash
# Tested on Ubuntu 14.04

sudo apt-get update
sudo apt-get -y upgrade

sudo apt-get -y install   \
git                       \
gdb                       \
pkg-config                \
xorg-dev                  \
libgtk-3-dev              \
libboost-filesystem-dev   \
libboost-system-dev       \
libudev-dev               \
clang-3.6                 \
cmake                     \
ninja-build               \
libcairo2-dev             \
libusb-1.0-0-dev          \
libssl-dev                \
libfreetype6-dev          \
libfontconfig1-dev        \
libglu1-mesa-dev          \
libmpg123-dev             \
libopenal-dev             \
libassimp-dev             \
libopencv-dev             \
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
# libtbb-dev                \

sudo rm -f /usr/bin/clang   && sudo ln -s /usr/bin/clang-3.6   /usr/bin/clang
sudo rm -f /usr/bin/clang++ && sudo ln -s /usr/bin/clang++-3.6 /usr/bin/clang++
sudo rm -f /usr/bin/llvm-symbolizer && sudo ln -s /usr/bin/llvm-symbolizer-3.6 /usr/bin/llvm-symbolizer

# Use gold linker
sudo rm -f /usr/bin/ld && sudo ln -s /usr/bin/ld.gold /usr/bin/ld

# Use default linker
#sudo rm -f /usr/bin/ld && sudo ln -s /usr/bin/ld.bfd /usr/bin/ld

# Reinstall Mesa if CMake can't find OpenGL headers and libraries
#sudo apt-get -y install --reinstall libgl1-mesa-glx libgl1-mesa-dev libglu1-mesa-dev

