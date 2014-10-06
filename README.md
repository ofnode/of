Cross-compiled [openFrameworks][1]
==================================

CMake-based cross-compilable subset of openFrameworks for Linux.


Features
--------

 - 64-bit, C++11, Clang, CMake, Ninja and Sanitizer ready.

 - Get fully static 64-bit Windows applications from Linux with [MXE][2].

 - Generate project file for your favorite editor with [CMake Generators][3].


Difference
----------

 - Sound and video features are disabled due to use of closed-source FMOD and QuickTime libraries in openFrameworks which are not acceptable for this project.

 - OF_KEY_CTRL/ALT/SHIFT are not working because currently openFrameworks have to callback keyPressed() two times to check both left and right modifiers. Use left or right keys in code directly (e.g. OF_KEY_LEFT_SHIFT).

 - EXR, RAW, WEBP and JXR image formats are not supported.

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


Examples
--------
[ofApp][5]


  [1]: https://github.com/openframeworks/openFrameworks
  [2]: http://mxe.cc
  [3]: http://www.cmake.org/cmake/help/v3.0/manual/cmake-generators.7.html#extra-generators
  [4]: https://github.com/procedural/of/releases
  [5]: https://github.com/procedural/ofApp

