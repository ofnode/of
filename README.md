CMake-based [openFrameworks](https://github.com/openframeworks/openFrameworks)
==============================================================================


![](http://i.imgur.com/wKDVkN6.png)


Features
--------

 - 64-bit, C++11, CMake, Ninja, Cotire, Clang and Sanitize ready.

 - Generate project file for your favorite IDE with [CMake Generators](http://www.cmake.org/cmake/help/v3.0/manual/cmake-generators.7.html#extra-generators).
 
 - Easily add [openFrameworks addons](http://ofxaddons.com) with single `ofxaddon` command.


Difference
----------

The only difference is that this project targets CMake build system and stores source code of some libraries on which openFrameworks depends locally with patches applied if needed.


Installing
----------

1. `git clone --recursive --depth 1 https://github.com/ofnode/of` will clone this repo.
2. Install developer files for your Linux distro with a script from `dev/install/linux` folder.
3. Download precompiled libraries from [releases](https://github.com/ofnode/of/releases) page and extract `lib-linux` folder to `of`.


Compiling
---------

Release build:

```bash
mkdir build
cd build
cmake .. -G Ninja
ninja
```

Debug build:

```bash
mkdir build
cd build
cmake .. -G Ninja -DCMAKE_BUILD_TYPE=Debug
ninja
```


Windows
-------

### [See wiki](https://github.com/ofnode/of/wiki)


Templates
---------

### [ofApp](https://github.com/ofnode/ofApp)
### [ofxAddon](https://github.com/ofnode/ofxAddon)


Issues
------

### [Known issues on Linux](https://gist.github.com/0470684110f443ce3f01)
### [Known issues on Windows](https://gist.github.com/9e7635b1a51f65f72062)


Licenses
--------

See `licenses` folder. OF **can** be used for commercial applications without disclosing their source code. OF statically links to all libraries which allow that for commercial use. OF **does not** use GPL libraries. FreeImage, FreeType and Cairo are dual licensed, and thus OF uses FIPL, FTL and MPL respectively. OpenAL Soft, libmpg123, libsndfile and libusb are licensed under LGPL which allow dynamic linking to closed source applications, and OF dynamically links to them.
