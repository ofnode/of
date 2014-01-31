Cross-compiled openFrameworks
=============================

Alternative openFrameworks distribution for Arch Linux. Cross-platform Qt Creator projects.

Features
--------

* Compiling fully static 64bit Windows applications from Linux using MinGW-w64 compiler.

* There's no source code provided for a few dependencies in original openFrameworks distribution, CrossOF is here to solve that with custom scripts.

Limitations
-----------
<b>No sound and video support</b> due to closed-source FMOD and QuickTime used in  Windows related code of openFrameworks.

<b>Arch Linux only</b>. Dependencies are tied to AUR and official repositories.

<b>Can't compile to Mac</b>. I have no Mac machine yet.

Compiling:
---------

1) ./dependencies

2) ./clone

3) ./compile

4) Open and compile <b>of.pro</b> with Qt Creator.

5) Include <b>of.pri</b> in your project.

See template project for example.