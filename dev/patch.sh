#!/bin/bash
cd "`dirname "$(readlink -f $0)"`"
cd ..
OF="`pwd`"

function apply() {
  echo  "$1"
  patch -p1 < "$OF/dev/patches/$1"
}

cd src

apply of_remove_glut.patch
apply of_mingw_fixes.patch
apply of_audio_video_disable.patch
apply of_glfw_missing_include.patch
apply of_remove_deprecated_registers.patch
apply of_remove_double_key_callbacks.patch

apply poco_mingw_fixes.patch
apply poco_warning_fixes.patch

apply cmake_changes.patch

cp  "$OF/dev/cmake/kiss/CMakeLists.txt" kiss
cp "$OF/dev/cmake/tess2/CMakeLists.txt" tess2
