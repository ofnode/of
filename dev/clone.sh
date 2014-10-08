#!/bin/bash
cd `dirname $(readlink -f $0)`
cd ..
OF=`pwd`

cd src

function setup() {
  rm -rf $1
  if [ ! -f $2.zip ]; then
    wget $3/archive/$2.zip
  fi
  unzip -q $2.zip
  mv  $1-* $1
}

# v 1.5.3
setup poco cecf7cd https://github.com/pocoproject/poco

# v 3.1.0
setup glfw 0a6cb3 https://github.com/arturoc/glfw

# v 1.11.0
setup glew 442545 https://github.com/omniavinco/glew-cmake

# v 3.16.0
setup freeimage e550ad https://github.com/procedural/freeimage

# v 2.11.1
setup fontconfig 9da280 https://github.com/procedural/fontconfig

# v 0.8.4
setup openFrameworks 94f50e https://github.com/openframeworks/openFrameworks


rm -rf openframeworks
mv     openFrameworks/libs/openFrameworks openframeworks

rm -rf tess2
mkdir  tess2

mv     openFrameworks/libs/tess2/include tess2/include
mv     openFrameworks/libs/tess2/Sources tess2/src

rm -rf kiss
mkdir  kiss

mv     openFrameworks/libs/kiss/include kiss/include
mv     openFrameworks/libs/kiss/src     kiss/src

rm -rf openFrameworks

