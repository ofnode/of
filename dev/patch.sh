#!/bin/bash
cd "`dirname "$(readlink -f $0)"`"
cd ..
OF="`pwd`"

function apply() {
  echo  "$1"
  patch -p1 < "$OF/dev/patches/$1"
}

#---------------------------------

cd src

apply cmake_changes.patch
apply poco_mingw_fixes.patch
apply poco_warning_fixes.patch
apply openframeworks_fixes.patch
