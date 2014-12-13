#!/bin/bash
# Tested on Fedora 20

sudo yum -y localinstall --nogpgcheck \
http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo yum -y update
sudo yum -y install     \
pkgconfig               \
libstdc++-static        \
xorg-x11-server-devel   \
libXcursor-devel        \
libXrandr-devel         \
libXi-devel             \
gtk3-devel              \
libudev-devel           \
llvm                    \
clang                   \
clang-analyzer          \
cmake                   \
ninja-build             \
cairo-devel             \
libusb-devel            \
openssl-devel           \
freetype-devel          \
fontconfig-devel        \
mesa-libGLU-devel       \
openal-soft-devel       \
opencv-devel            \
tbb-devel               \
mpg123                  \
flac-devel              \
alsa-lib-devel          \
libtheora-devel         \
libvorbis-devel         \
libsndfile-devel        \
pulseaudio-libs-devel   \
ffmpeg-devel            \
libmpg123-devel         \
libraw1394-devel        \
gstreamer1-devel        \
gstreamer1-libav        \
gstreamer1-plugins-ugly \
gstreamer1-plugins-base-devel

sudo ln -s /usr/bin/ninja-build /usr/bin/ninja 2> /dev/null

