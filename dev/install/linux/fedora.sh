#!/bin/bash
# Tested on Fedora 20

sudo yum -y update
sudo yum -y install    \
pkgconfig              \
libstdc++-static       \
xorg-x11-server-devel  \
libXcursor-devel       \
libXrandr-devel        \
libXi-devel            \
gtk2-devel             \
gtk3-devel             \
libudev-devel          \
llvm                   \
clang                  \
clang-analyzer         \
cmake                  \
ninja-build            \
cairo-devel            \
libusb-devel           \
openssl-devel          \
freetype-devel         \
mesa-libGLU-devel      \
alsa-lib-devel         \
flac-devel             \
libtheora-devel        \
libvorbis-devel        \
libsndfile-devel       \
pulseaudio-libs-devel  \
assimp-devel           \
openal-soft-devel      \
opencv-devel           \
tbb-devel              \
mpg123                 \
ffmpeg-devel           \
libmpg123-devel        \
libraw1394-devel       \
gstreamer-devel        \
gstreamer-ffmpeg       \
gstreamer-plugins-ugly \
gstreamer-plugins-base-devel

sudo ln -s /usr/bin/ninja-build /usr/bin/ninja 2> /dev/null

