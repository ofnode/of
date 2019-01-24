# Prepare sysroot

1. download packages (without installing them) on a fresh raspbian scretch installation (enter commands in the raspberry pi console) :


```
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
    freeglut3 \
    libx11-6 \
	libxext6 \
	libssl1.1 \
	libselinux1 \
	libpcre3 \
	libmount1\
	liblzma5 \
	libxau6 \
	libffi6 \
	libxdmcp6 \
	libbsd0 \
	libblkid1 \
	libdbus-1-3 \
	libdrm2 \
	libsystemd0 \
	libuuid1 \
	liblz4-1 \
	libgcrypt20 \
	libgpg-error0 \
	libusb-1.0 \
	libjpeg62-turbo \
	libcurl3 \
	libxml2 \
	libnghttp2-14 \
	libidn2-0 \
	librtmp1 \
	libglew2.0 \
	libglew-dev
	


```

You might need to re-run the above command with 


2. extract all deb into a sysroot folder (enter commands in the raspberry pi console) :


```
    mkdir ~/sysroot
    cd ~/sysroot
    for deb in /var/cache/apt/archives/*.deb; do dpkg-deb -xv $deb .; done
```

3. use rsync to transfert the sysroot to the host (enter commands in the host console)

```
    mkdir ~/ofnode
    cd ofnode
    rsync -hvrPtl pi@raspberrypi.local:~/sysroot .
```

4. update symlinks

```
    pushd sysroot/usr/lib/arm-linux-gnueabihf
    ln -fs  ../../../lib/arm-linux-gnueabihf/libz.so.1 libz.so
    ln -fs  ../../../lib/arm-linux-gnueabihf/libglib-2.0.so.0 libglib-2.0.so
    ln -fs  ../../../lib/arm-linux-gnueabihf/libpcre.so.3 libpcre.so
    ln -fs  ../../../lib/arm-linux-gnueabihf/libblkid.so.1.1.0 libblkid.so
    ln -fs  ../../../lib/arm-linux-gnueabihf/libusb-1.0.so.0.1.0 libusb-1.0.so
    ln -fs  ../../../lib/arm-linux-gnueabihf/liblzma.so.5.2.2 liblzma.so
	ln -fs  ../../../lib/arm-linux-gnueabihf/libexpat.so.1.6.2 libexpat.so
	ln -fs  ../../../lib/arm-linux-gnueabihf/libdbus-1.so.3.14.15 libdbus-1.so
    popd
```

5. add standards includes : 

```
    pushd sysroot/usr
    rsync -hvrPtl pi@raspberrypi.local:/usr/include .
    popd
```

6. add opt/vc directory (for RPi specific header/lib)

```
    pushd sysroot
    mkdir opt
    cd opt
    rsync -hvrPtl pi@raspberrypi.local:/opt/vc .
    popd
```

# Get ofnode itself

    git clone --depth=1 https://github.com/ofnode/of.git
    git clone --depth=1 https://github.com/ofnode/ofApp.git

# Get a cross crompiler toolchain 

# Build it 

then you could configure and build with the following :

     mkdir build-of-rpi
     pushd build-of-rpi
     cmake ../of -DCMAKE_TOOLCHAIN_FILE=../of/dev/arm-linux-gnueabihf.cmake -GNinja -DCMAKE_SYSROOT=`realpath "${PWD}/../sysroot"`
     ninja

and build test empty app

     mkdir build-ofApp-rpi
     pushd build-ofApp-rpi
     cmake ../ofApp -DCMAKE_TOOLCHAIN_FILE=../of/dev/arm-linux-gnueabihf.cmake -GNinja -DCMAKE_SYSROOT=`realpath "${PWD}/../sysroot"`
     ninja

