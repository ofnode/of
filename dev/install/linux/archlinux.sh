#!/bin/bash
# Tested on Manjaro 0.8.11

yes | sudo pacman -Syu

yes | sudo pacman -Sy --needed \
git                \
make               \
pkg-config         \
xorg-server        \
xorg-server-devel  \
xorg-server-utils  \
xorg-server-common \
libxinerama        \
libxcursor         \
libxrandr          \
libxi              \
gtk3               \
llvm               \
clang              \
clang-analyzer     \
cmake              \
ninja              \
cairo              \
libusb             \
openssl            \
freetype2          \
fontconfig         \
glu                \
openal             \
opencv             \
intel-tbb          \
libsndfile         \
gst-libav          \
gstreamer          \
gst-plugins-base   \
gst-plugins-good   \
gst-plugins-bad    \
gst-plugins-ugly
