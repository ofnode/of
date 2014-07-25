Cross-compiled [openFrameworks][1]
==================================

Alternative openFrameworks distribution for Arch Linux and Ubuntu. Cross-platform CMake projects.

Features
--------

 - 64-bit, C++11, Clang, CMake and Ninja ready.

 - Get fully static Windows applications from Arch Linux or Ubuntu.

 - Latest openFrameworks versions with precompiled libraries and sources.

Limitations
-----------

<b>Arch Linux and Ubuntu for now</b>. Install scripts for external dependencies are available only for these systems, but it's possible to add one for your Linux distro.

<b>No sound and video features</b>. openFrameworks uses closed-source FMOD and QuickTime libraries which are not acceptable for this project.

<b>Can't compile to OSX</b>. I have no Mac yet.

Installing:
----------
Run:
<pre><code>./setup</pre></code>

And install dependencies with:
<pre><code>Scripts/Arch/*</pre></code>

Or:
<pre><code>Scripts/Ubuntu/*</pre></code>

Compiling:
---------
Run:
<pre><code>./compile_on_arch</pre></code>

Or:
<pre><code>./compile_on_ubuntu</pre></code>

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

