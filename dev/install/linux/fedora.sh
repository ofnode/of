#!/bin/bash
# Tested on Fedora 22

sudo dnf -y install --nogpgcheck \
http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo dnf -y update

sudo dnf groups install "C Development Tools and Libraries"

sudo dnf -y install     \
git                     \
patch                   \
pkgconfig               \
libstdc++-static        \
xorg-x11-server-devel   \
libXinerama-devel       \
libXcursor-devel        \
libXrandr-devel         \
libXi-devel             \
gtk3-devel              \
libudev-devel           \
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
assimp-devel            \
opencv-devel            \
tbb-devel               \
flac-devel              \
alsa-lib-devel          \
libmpg123-devel         \
libtheora-devel         \
libvorbis-devel         \
libsndfile-devel        \
pulseaudio-libs-devel   \
ffmpeg-devel            \
libraw1394-devel        \
gstreamer1-devel        \
gstreamer1-libav        \
gstreamer1-plugins-base \
gstreamer1-plugins-good \
gstreamer1-plugins-ugly \
gstreamer1-plugins-bad-free \
gstreamer1-plugins-base-devel

sudo ln -s /usr/bin/ninja-build /usr/bin/ninja 2> /dev/null

# Use gold linker
sudo rm /usr/bin/ld && sudo ln -s /usr/bin/ld.gold /usr/bin/ld

# Use default linker
#sudo rm /usr/bin/ld && sudo ln -s /usr/bin/ld.bfd /usr/bin/ld

