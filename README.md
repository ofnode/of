Cross-compiled [openFrameworks][1]
==================================

CMake-based cross-compilable subset of openFrameworks for Linux.

![OF logo courtesy to: http://julioterra.com](http://i.imgur.com/wKDVkN6.png)


Features
--------

 - 64-bit, C++11, CMake, Ninja, Cotire, Clang and Sanitize ready.

 - Get fully static 64-bit Windows applications from Linux with [MXE][2].

 - Generate project file for your favorite editor with [CMake Generators][3].
 
 - Easy addon system: just use `ofxaddon` command in CMakeLists.txt.


Difference
----------

 - Sound and video features are disabled because of use of closed-source FMOD and QuickTime.

 - OF_KEY_CTRL/ALT/SHIFT won't work, use position keys directly, e.g. OF_KEY_LEFT_SHIFT.

 - EXR, RAW and JXR image formats are not supported.

 - GLUT is deprecated.

For other non-breaking changes see `dev/patches` folder.


Installing
----------

Precompiled libraries are available from [releases][4] page.


Compiling
---------

For Linux build:

Install external dependencies with one of the scripts from `dev/install/linux` folder.

```bash
mkdir build
cd build
cmake .. -G Ninja -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++
ninja
```

For Windows build:

Install MXE with one of the scripts from `dev/install/mxe` folder.

```bash
mkdir build
cd build
cmake .. -G Ninja -DCMAKE_TOOLCHAIN_FILE=/opt/mxe/mingw.cmake
ninja
```


Templates
---------

### [ofApp][5]
### [ofxAddon][6]


Licenses
--------

See `licenses` folder. OF **can** be used for commercial applications without disclosing their source code. OF uses static linking for all the libraries which allow that for commercial applications. OF **does not** use GPL libraries. FreeImage, FreeType and Cairo are dual licensed, and thus OF uses FIPL, FTL and MPL respectively which allow commercial use. GTK uses LGPL which allow dynamic linking to commercial applications, and OF dynamically links to it.


  [1]: https://github.com/openframeworks/openFrameworks
  [2]: http://mxe.cc
  [3]: http://www.cmake.org/cmake/help/v3.0/manual/cmake-generators.7.html#extra-generators
  [4]: https://github.com/procedural/of/releases
  [5]: https://github.com/procedural/ofApp
  [6]: https://github.com/procedural/ofxAddon

