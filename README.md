CMake [openFrameworks](https://github.com/openframeworks/openFrameworks) 0.9.0
==============================================================================

![](http://i.imgur.com/wKDVkN6.png)

[![Build Status](https://travis-ci.org/ofnode/of.svg?branch=master)](https://travis-ci.org/ofnode/of)


Features
--------

 - 64-bit, CMake, Ninja, Cotire, Clang and Sanitize ready.

 - Generate project file for your favorite IDE with [CMake Generators](http://www.cmake.org/cmake/help/v3.0/manual/cmake-generators.7.html#extra-generators).
 
 - Easily add [openFrameworks addons](http://ofxaddons.com) with single `ofxaddon` command.


Difference
----------

The only difference is that this project targets CMake build system and stores source code of some libraries on which openFrameworks depends locally with patches applied if needed.

See [Architecture](https://github.com/ofnode/of/wiki/Architecture) wiki page for details.


Step 1: Clone
-------------

Run `git clone https://github.com/ofnode/of --depth 1 --no-single-branch` to clone repo.

Step 2: Prepare
---------------

Install required developer packages for your OS with:

#### Linux:

[`dev/install/linux`](https://github.com/ofnode/of/tree/master/dev/install/linux) distro script

#### OS X:

[`dev/install/osx/homebrew.sh`](https://github.com/ofnode/of/tree/master/dev/install/osx/homebrew.sh)

#### Windows:

### [See wiki](https://github.com/ofnode/of/wiki/Instructions-for-Windows)


Step 3: Compile
---------------

For Linux, OS X and Windows:

```
mkdir build
cd build
cmake .. -G Ninja
ninja
```

For Raspberry Pi 2, pass `-DOF_PLATFORM=armv7` and `-j3` flags to `cmake` and `ninja` respectively:

```
cmake .. -G Ninja -DOF_PLATFORM=armv7
ninja -j3
```

Also, you can generate project files for IDEs, Xcode example:

```bash
cmake .. -G Xcode -DCMAKE_BUILD_TYPE=Release
xcodebuild -configuration Release
```

**NOTE**: Visual Studio is not supported anymore, [see here why](https://github.com/ofnode/of/wiki/On-removing-support-for-MSVC).


Templates
---------

### [ofApp](https://github.com/ofnode/ofApp)
### [ofLiveApp](https://github.com/ofnode/ofLiveApp)
### [ofxAddon](https://github.com/ofnode/ofxAddon)


Examples
--------

Run `git submodule update --init --recursive` from the repo folder to clone the examples.

<img src="https://i.imgur.com/9iSw2rB.png">

Issues
------

### [Known issues on Linux](https://gist.github.com/0470684110f443ce3f01)
### [Known issues on OS X](https://gist.github.com/85bda4b8cf8016210e4a)
### [Known issues on Windows](https://gist.github.com/9e7635b1a51f65f72062)


Licenses
--------

See `licenses` folder. OF **can** be used for commercial applications **without** disclosing their source code. OF statically links to libraries which allow that for commercial use. OF **does not** use GPL-licensed libraries. FreeImage, FreeType and Cairo are dual licensed, thus OF uses FIPL, FTL and MPL respectively. GTK+ 3, GLib, ALSA, OpenAL Soft, mpg123, libsndfile, Gstreamer, udev and libusb are licensed under LGPL v2.1 or higher which allow dynamic linking to closed source applications and OF dynamically links to them.

Special thanks
--------------

In alphabetical order:

[@aspeteRakete](https://github.com/aspeteRakete) for creating OS X version and continuous support of the project!

[@avilleret](https://github.com/avilleret) for creating Raspberry Pi 2 version!

[@GuidoSchmidt](https://github.com/GuidoSchmidt) for pull requests!
