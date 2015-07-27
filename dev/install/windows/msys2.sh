# Download links:
# 
# Git: http://git-scm.com/download/win
# CMake: http://www.cmake.org/download
# MSYS2: http://msys2.github.io
# 
# PATH environment:
# 
# C:\msys64\usr\bin
# C:\msys64\usr\lib
# C:\msys64\usr\include
# C:\msys64\mingw64\bin
# C:\msys64\mingw64\lib
# C:\msys64\mingw64\include
# C:\msys64\mingw64\include\AL
# C:\msys64\mingw64\include\cairo
# C:\msys64\mingw64\x86_64-w64-mingw32\lib
# 
# Windows Dev Tips:
# 
#  * For easy environment variable editing you can use a free program called Windows Environment Variables Editor: http://eveditor.com
#  * Don't generate project files from Git console: its folder is included by default which causes linker to link against its libz.dll
# 
# Run this command from MSYS2 Shell:

yes | pacman -Sy --needed   \
mingw-w64-x86_64-clang-svn  \
mingw-w64-x86_64-gdb        \
mingw-w64-x86_64-zlib       \
mingw-w64-x86_64-tools      \
mingw-w64-x86_64-ninja      \
mingw-w64-x86_64-boost      \
mingw-w64-x86_64-cairo      \
mingw-w64-x86_64-mpg123     \
mingw-w64-x86_64-openal     \
mingw-w64-x86_64-assimp     \
mingw-w64-x86_64-opencv     \
mingw-w64-x86_64-libusb     \
mingw-w64-x86_64-openssl    \
mingw-w64-x86_64-libiconv   \
mingw-w64-x86_64-freetype   \
mingw-w64-x86_64-libsndfile \
mingw-w64-x86_64-fontconfig \
mingw-w64-x86_64-pkg-config
