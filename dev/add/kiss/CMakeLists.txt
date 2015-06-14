cmake_minimum_required(VERSION 2.8)

project(kiss)
set(BIN kiss)

if(NOT CMAKE_BUILD_TYPE)
   set(CMAKE_BUILD_TYPE "Release")
endif()

set(CMAKE_C_FLAGS_DEBUG "-g -fPIC")

include_directories(.)
include_directories(tools)

set(SOURCES
    tools/kiss_fftr.c
    kiss_fft.c
)

add_library(
    ${BIN}
    STATIC
    ${SOURCES}
)

