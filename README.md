Cross-compiled [openFrameworks][1]
==================================

Alternative openFrameworks distribution for Arch Linux, Fedora and Ubuntu.

Features
--------

 - 64-bit, C++11, Clang, CMake and Ninja ready.

 - Get fully static Windows applications from Linux.

 - Latest openFrameworks versions with precompiled libraries and sources.

Limitations
-----------

<b>Arch Linux, Fedora and Ubuntu for now</b>. Install scripts for external dependencies are available only for these systems, but it's possible to add one for your Linux distro.

<b>No sound and video features</b>. openFrameworks uses closed-source FMOD and QuickTime libraries which are not acceptable for this project.

<b>Can't compile to OSX</b>. I have no Mac yet.

Installing:
----------
Install ```wget``` and ```patch``` packages for your distro, run ```./setup``` to download precompiled openFrameworks libraries and install system dependencies with ```Scripts/Arch/*```, ```Scripts/Fedora/*``` or ```Scripts/Ubuntu/*```

Compiling:
---------
Run ```./compile_on_arch```, ```./compile_on_fedora``` or ```./compile_on_ubuntu```

And wait it to finish.

Examples:
--------
See ```Template``` folder.

To compile it for Linux:
```bash
cmake -G Ninja -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ .
ninja
```

To compile it for Windows:
```bash
cmake -G Ninja -DCMAKE_TOOLCHAIN_FILE=/opt/mxe/usr/x86_64-w64-mingw32.static/share/cmake/mxe-conf.cmake .
ninja
```


  [1]: https://github.com/openframeworks/openFrameworks

