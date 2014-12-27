CMake-based [openFrameworks][1]
===============================


![OF logo courtesy to: http://julioterra.com](http://i.imgur.com/wKDVkN6.png)


Features
--------

 - 64-bit, C++11, CMake, Ninja, Cotire, Clang and Sanitize ready.

 - Get mostly static 64-bit Windows applications from Linux with [MXE][2].

 - Generate project file for your favorite editor with [CMake Generators][3].
 
 - Easily add [openFrameworks addons][4] with single `ofxaddon` command.


Difference
----------

The only difference is that this project targets CMake build system and stores source code of some libraries on which openFrameworks depends locally with patches applied if needed.


Installing
----------

1. `git clone https://github.com/procedural/of --depth 1` will clone this repository.
2. Install developer files for your Linux distro with a script from `dev/install/linux` folder.
3. Optionally: install developer files for MXE with a script from `dev/install/mxe` folder.
4. Download precompiled libraries from [releases][5] page and extract `lib` folder to `of`.


Compiling
---------

Run `build.sh` script from `dev` folder. Also, you can compile it manually:

For Linux build:

```bash
mkdir build
cd build
cmake .. -G Ninja -DCMAKE_CXX_COMPILER=clang++
ninja
```

For Debug build:

```bash
mkdir build
cd build
cmake .. -G Ninja -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_BUILD_TYPE=Debug
ninja
```

For Windows build:

```bash
mkdir build
cd build
cmake .. -G Ninja -DCMAKE_TOOLCHAIN_FILE=`find /opt/mxe -name mxe-conf.cmake`
ninja
```


Templates
---------

### [ofApp][6]
### [ofxAddon][7]


Licenses
--------

See `licenses` folder. OF **can** be used for commercial applications without disclosing their source code. OF statically links to all libraries which allow that for commercial use. OF **does not** use GPL libraries. FreeImage, FreeType and Cairo are dual licensed, and thus OF uses FIPL, FTL and MPL respectively. OpenAL Soft, libmpg123, libsndfile and libusb are licensed under LGPL which allow dynamic linking to closed source applications, and OF dynamically links to them.


  [1]: https://github.com/openframeworks/openFrameworks
  [2]: http://mxe.cc
  [3]: http://www.cmake.org/cmake/help/v3.0/manual/cmake-generators.7.html#extra-generators
  [4]: http://ofxaddons.com
  [5]: https://github.com/procedural/of/releases
  [6]: https://github.com/procedural/ofApp
  [7]: https://github.com/procedural/ofxAddon

