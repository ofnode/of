Cross-compiled [openFrameworks][1]
==================================

Alternative openFrameworks distribution for Arch Linux, Fedora and Ubuntu.

Features
--------

 - 64-bit, C++11, Clang, CMake and Ninja ready.

 - Get fully static 64-bit Windows applications from Linux.

 - Generate project file for your favorite editor with [CMake Generator][2].

 - Debug with Clang Static Analyzer and Clang Address / Leak Sanitizer.

 - Latest openFrameworks versions with precompiled libraries and sources.

Limitations
-----------

<b>Arch Linux, Fedora and Ubuntu for now</b>. Install scripts for external dependencies are available only for these systems, but it's possible to add one for your Linux distro.

<b>No sound and video features</b>. openFrameworks uses closed-source FMOD and QuickTime libraries which are not acceptable for this project.

<b>Can't compile to OSX</b>. I have no Mac yet.

Installing:
----------

 1. Install `wget` and `patch` packages for your distro.
 2. Run `./setup` to download precompiled openFrameworks libraries.
 3. Install system dependencies with `Install/archlinux_dependencies`,
    `Install/fedora_dependencies` or `Install/ubuntu_dependencies`

Compiling:
---------
Run `./compile_on_archlinux`, `./compile_on_fedora` or `./compile_on_ubuntu`

And wait it to finish.

Examples:
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

To debug application, run `analyze.sh` and `sanitize.sh` scripts.


  [1]: https://github.com/openframeworks/openFrameworks
  [2]: http://www.cmake.org/cmake/help/v3.0/manual/cmake-generators.7.html#extra-generators
