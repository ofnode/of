cmake_minimum_required(VERSION 2.8)

project(tess2)
set(BIN tess2)

if(NOT CMAKE_BUILD_TYPE)
   set(CMAKE_BUILD_TYPE "Release")
endif()

if(UNIX)
add_definitions(-fPIC)
endif()

include_directories(Include)

set(SOURCES
    Source/bucketalloc.c
    Source/priorityq.c
    Source/sweep.c
    Source/dict.c
    Source/geom.c
    Source/mesh.c
    Source/tess.c
)

add_library(
    ${BIN}
    STATIC
    ${SOURCES}
)

