Cross-compiled openFrameworks
=============================

Alternative openFrameworks distribution for Arch Linux. Cross-platform Qt Creator projects.

Features
--------

* Fully static 64bit Windows applications from Arch Linux using MinGW-w64 compiler.

* Latest openFrameworks commits with dependencies and their sources.

Limitations
-----------

<b>Arch Linux only</b>. Dependencies are tied to AUR and official repositories.

<b>No sound and video</b>. Windows-related code of openFrameworks tied to closed-source FMOD and QuickTime.

<b>Can't compile to OSX</b>. I have no Mac yet.

Compiling:
---------
<pre><h4>./get

./clone

./compile

Open and compile <b>of.pro</b> with Qt Creator.

Include <b>of.pri</b> in your project.</h4></pre>
See template project for example.
