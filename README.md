Cross-compiled [openFrameworks][1]
==================================

Alternative openFrameworks distribution for Arch Linux, Fedora and Ubuntu.

Features
--------

 - 64-bit, C++11, Clang, CMake and Ninja ready.

 - Get fully static 64-bit Windows applications from Linux.

 - Generate project file for your favorite editor with [CMake Generators][2].

 - Debug with Clang Static Analyzer and Clang Address / Leak Sanitizer.

 - Latest openFrameworks versions with precompiled libraries and sources.

Difference
----------

 - Sound and video features are disabled due to use of closed-source FMOD and QuickTime libraries in openFrameworks which are not acceptable for this project.

 - OF_KEY_CTRL/ALT/SHIFT are not working because currently openFrameworks have to callback keyPressed() two times to check both left and right modifiers. Use left or right keys in code directly (e.g. OF_KEY_LEFT_SHIFT).

For other non-breaking changes of openFrameworks see `Patches` folder.

Installing
----------

 1. Install `wget` and `patch` packages for your distro.
 2. Run `./setup` to download precompiled openFrameworks libraries.
 3. Run a script from `Install` folder that matches your Linux distribution.


Compiling
---------
 1. Run a script from `Install` folder that matches your Linux distribution.
 2. Run `./compile` script and wait it to finish.

Examples
--------
See `Template` folder.

To compile it for Linux:
```bash
cmake -G Ninja -DCMAKE_CXX_COMPILER=clang++
ninja
```

To compile it for Windows:
```bash
cmake -G Ninja -DCMAKE_TOOLCHAIN_FILE=/opt/mxe/mingw.cmake
ninja
```

To debug application, run `analyze.sh` and pass resulted binary to `sanitize.sh` script (e.g. `sanitize.sh Debug/ofApp`).


  [1]: https://github.com/openframeworks/openFrameworks
  [2]: http://www.cmake.org/cmake/help/v3.0/manual/cmake-generators.7.html#extra-generators

