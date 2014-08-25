#!/bin/bash

cd `dirname $(readlink -f $0)`

export ASAN_OPTIONS="external_symbolizer_path=/usr/bin/llvm-symbolizer:detect_leaks=1"
App/*_Debug
