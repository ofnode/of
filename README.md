CMake-based [openFrameworks][1]
===============================


![](http://i.imgur.com/wKDVkN6.png)


Features
--------

 - 64-bit, C++11, CMake, Ninja, Cotire, Clang and Sanitize ready.

 - Get 64-bit Windows applications from [Linux with MXE][2] or [Windows][3].

 - Generate project file for your favorite editor with [CMake Generators][4].
 
 - Easily add [openFrameworks addons][5] with single `ofxaddon` command.


Difference
----------

The only difference is that this project targets CMake build system and stores source code of some libraries on which openFrameworks depends locally with patches applied if needed.


Installing
----------

1. `git clone --recursive https://github.com/ofnode/of` will clone this repository.
2. Install developer files for your Linux distro with a script from `dev/install/linux` folder.
3. Optionally: install developer files for MXE with a script from `dev/install/mxe` folder.
4. Download precompiled libraries from [releases][6] page and extract `lib-*` folder to `of`.


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


Templates
---------

### [ofApp][7]
### [ofxAddon][8]


Issues
------

### [Known issues on Linux][9]
### [Known issues on Windows][10]


Licenses
--------

See `licenses` folder. OF **can** be used for commercial applications without disclosing their source code. OF statically links to all libraries which allow that for commercial use. OF **does not** use GPL libraries. FreeImage, FreeType and Cairo are dual licensed, and thus OF uses FIPL, FTL and MPL respectively. OpenAL Soft, libmpg123, libsndfile and libusb are licensed under LGPL which allow dynamic linking to closed source applications, and OF dynamically links to them.


  [1]: https://github.com/openframeworks/openFrameworks
  [2]: http://mxe.cc
  [3]: https://github.com/ofnode/of/blob/da05b1d/dev/install/windows/msys2.sh
  [4]: http://www.cmake.org/cmake/help/v3.0/manual/cmake-generators.7.html#extra-generators
  [5]: http://ofxaddons.com
  [6]: https://github.com/ofnode/of/releases
  [7]: https://github.com/ofnode/ofApp
  [8]: https://github.com/ofnode/ofxAddon
  [9]: https://gist.github.com/0470684110f443ce3f01
  [10]: https://gist.github.com/9e7635b1a51f65f72062
