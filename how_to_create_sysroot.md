
    sudo aptitude --download-only install \
	xorg-dev                  \
	libgtk-3-dev              \
	libboost-filesystem-dev   \
	libboost-system-dev       \
	libboost-filesystem1.62.0 \
	libboost-system1.62.0     \
	libudev-dev               \
	libcairo2-dev             \
	libusb-1.0-0-dev          \
	libssl-dev                \
	libfreetype6-dev          \
	libfreetype6              \
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
	libgstreamer-plugins-base1.0-dev \
	libcurl4-openssl-dev \
	liburiparser-dev \
	libpugixml-dev \
	zlibg1-dev \
	zlibg1 \
	libpng16-16 \
	libasound2 \
	libudev1 \
	libglib2.0-0 \
	libfreeimage-dev \
    freeglut3-dev \
    freeglut3

extract all deb into a sysroot folder :

    mkdir ~/sysroot
    cd ~/sysroot
    for deb in /var/cache/apt/archives/*.deb; do dpkg-deb -xv $deb .; done
  
use rsync to transfert the sysroot

    mkdir ~/ofnode
    cd ofnode
    rsync -avz pi@raspberrypi.local:~/sysroot .

update links

    pushd sysroot/usr/lib/arm-linux-gnueabihf
    ln -fs  ../../../lib/arm-linux-gnueabihf/libz.so.1 libz.so
    ln -fs  ../../../lib/arm-linux-gnueabihf/libglib-2.0.so.0 libglib-2.0.so
    popd

add standards includes : 

    pushd sysroot/usr
    rsync -avz pi@raspberrypi.local:/usr/include .
    popd

add opt/vc directory (for RPi specific header/lib)

    pushd sysroot
    mkdir opt
    cd opt
    rsync -avz pi@raspberrypi.local:/opt/vc .
    popd
