#!/bin/bash
cd "`dirname "$(readlink -f $0)"`"
cd ..
OF="`pwd`"

function apply() {
  echo
  echo  "$1"
  patch -p1 < "$OF/dev/patches/$1"
}

#-------------------------------------------------------------------------------

cd "$OF/src"

apply videoinput_fixes.patch
apply poco_mingw_fixes.patch
apply poco_cmake_changes.patch
apply glfw_cmake_changes.patch
apply openframeworks_fixes.patch

