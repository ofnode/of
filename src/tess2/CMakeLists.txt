cmake_minimum_required(VERSION 2.8)

project(tess2)
set(BIN tess2)

if(NOT CMAKE_BUILD_TYPE)
   set(CMAKE_BUILD_TYPE "Release")
endif()

set(CMAKE_C_FLAGS_DEBUG "-g -fPIC")

include_directories(include)

set(SOURCES
    src/bucketalloc.c
    src/priorityq.c
    src/sweep.c
    src/dict.c
    src/geom.c
    src/mesh.c
    src/tess.c
)

add_library(
    ${BIN}
    STATIC
    ${SOURCES}
)

