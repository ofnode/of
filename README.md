Cross-compiled openFrameworks
=============================

Alternative openFrameworks distribution for Arch Linux. Cross-platform CMake projects.

Features
--------

 - 64bit, C++11, Clang, CMake and Ninja ready.

 - Get fully static Windows applications from Arch Linux with MinGW-w64.

 - Latest openFrameworks commits with dependencies and their sources.

Limitations
-----------

<b>Arch Linux only</b>. Dependencies are tied to AUR and official repositories.

<b>No sound and video</b>. Windows-related code of openFrameworks tied to closed-source FMOD and QuickTime.

<b>Can't compile to OSX</b>. I have no Mac yet.

[Download][1]
---------

Compiling:
---------
Run:
<pre><code>./compile</pre></code>

That's it. The process can take a while though - be patient.
If you don't want to wait - download sources and precompiled libraries with:
<pre><code>./setup</pre></code>

Examples:
--------
See ```Template``` folder.


  [1]: https://github.com/procedural/crossof/releases
