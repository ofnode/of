#!/bin/bash
# Tested on Manjaro 0.8.11

sudo pacman -Sy --needed \
git                \
gdb                \
make               \
patch              \
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
boost              \
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
mpg123             \
openal             \
assimp             \
opencv             \
intel-tbb          \
libsndfile         \
gst-libav          \
gstreamer          \
gst-plugins-base   \
gst-plugins-good   \
gst-plugins-bad    \
gst-plugins-ugly

# Use gold linker
sudo rm -f /usr/bin/ld && sudo ln -s /usr/bin/ld.gold /usr/bin/ld

# Use default linker
#sudo rm -f /usr/bin/ld && sudo ln -s /usr/bin/ld.bfd /usr/bin/ld
