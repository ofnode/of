#!/bin/bash

ASAN_OPTIONS="external_symbolizer_path=/usr/bin/llvm-symbolizer:detect_leaks=1" ./$1
