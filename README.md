CMake-based [openFrameworks](https://github.com/openframeworks/openFrameworks)
==============================================================================


![](http://i.imgur.com/wKDVkN6.png)


Features
--------

 - 64-bit, C++11, CMake, Ninja, Cotire, Clang and Sanitize ready.

 - Generate project file for your favorite IDE with [CMake Generators](http://www.cmake.org/cmake/help/v3.0/manual/cmake-generators.7.html#extra-generators).
 
 - Easily add [openFrameworks addons](http://ofxaddons.com) with single `ofxaddon` command.


Difference
----------

The only difference is that this project targets CMake build system and stores source code of some libraries on which openFrameworks depends locally with patches applied if needed.

See [Architecture](https://github.com/ofnode/of/wiki/Architecture) wiki page for details.


Step 1: Clone
-------------

Run `git clone https://github.com/ofnode/of --depth 1 --recursive` in a command line.


Step 2: Prepare
---------------

Install required developer packages for your OS with:

#### For Linux:

Scripts from [`dev/install/linux`](https://github.com/ofnode/of/tree/master/dev/install/linux)

#### For OS X:

[`dev/install/osx/homebrew.sh`](https://github.com/ofnode/of/tree/master/dev/install/osx/homebrew.sh)

#### For Windows:

### [See wiki](https://github.com/ofnode/of/wiki/Instructions-for-Windows)


Step 3: Compile
---------------

#### For Linux:

```bash
mkdir -p build/linux
cd build/linux
cmake ../.. -G Ninja -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_BUILD_TYPE=Release
ninja
```

#### For OS X:

```bash
mkdir -p build/osx
cd build/osx
cmake ../.. -G Xcode -DCMAKE_BUILD_TYPE=Release
xcodebuild -configuration Release
```

#### For Windows:

Open the Start menu and run `VS2013 x64 Native Tools Command Prompt`, then `cd /d` into `of` directory and enter:

```batch
mkdir build\windows
cd build\windows
cmake ..\.. -G "Visual Studio 12 2013 Win64" -DCMAKE_BUILD_TYPE=Release
msbuild openFrameworks.sln /m /p:Configuration=Release
```


Templates
---------

### [ofApp](https://github.com/ofnode/ofApp)
### [ofLiveApp](https://github.com/ofnode/ofLiveApp)
### [ofxAddon](https://github.com/ofnode/ofxAddon)


Issues
------

### [Known issues on Linux](https://gist.github.com/0470684110f443ce3f01)
### [Known issues on OS X](https://gist.github.com/85bda4b8cf8016210e4a)
### [Known issues on Windows](https://gist.github.com/9e7635b1a51f65f72062)


Licenses
--------

See `licenses` folder. OF **can** be used for commercial applications without disclosing their source code. OF statically links to all libraries which allow that for commercial use. OF **does not** use GPL libraries. FreeImage, FreeType and Cairo are dual licensed, and thus OF uses FIPL, FTL and MPL respectively. OpenAL Soft, libsndfile and libusb are licensed under LGPL which allow dynamic linking to closed source applications, and OF dynamically links to them.
