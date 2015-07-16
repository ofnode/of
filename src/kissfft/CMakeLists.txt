cmake_minimum_required(VERSION 2.8)

project(kissfft)
set(BIN kissfft)

if(NOT CMAKE_BUILD_TYPE)
   set(CMAKE_BUILD_TYPE "Release")
endif()

if(UNIX)
add_definitions(-fPIC)
endif()

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

