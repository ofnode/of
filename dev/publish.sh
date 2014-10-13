#!/bin/bash
cd "`dirname "$(readlink -f $0)"`"

./clear.sh
./clone.sh
./patch.sh
./build.sh
