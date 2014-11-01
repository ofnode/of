cmake_minimum_required(VERSION 2.8)

project(tess2)
set(BIN tess2)

if(NOT CMAKE_BUILD_TYPE)
   set(CMAKE_BUILD_TYPE "Release")
endif()

set(DEBUG_FLAGS "
    -g
    -fPIC
")

string(REPLACE "\n" " " DEBUG_FLAGS ${DEBUG_FLAGS})
set(CMAKE_C_FLAGS_DEBUG "${DEBUG_FLAGS}")

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

