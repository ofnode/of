cmake_minimum_required(VERSION 2.8)

project(kiss)
set(BIN kiss)

if(NOT CMAKE_BUILD_TYPE)
   set(CMAKE_BUILD_TYPE "Release")
endif()

if(UNIX AND NOT APPLE)
   set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY
     ${CMAKE_CURRENT_SOURCE_DIR}/../../lib/${CMAKE_BUILD_TYPE}/linux)
elseif(WIN32)
   set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY
     ${CMAKE_CURRENT_SOURCE_DIR}/../../lib/${CMAKE_BUILD_TYPE}/windows)
endif()

set(DEBUG_FLAGS "
    -g
    -fPIC
    -fcolor-diagnostics
")

string(REPLACE "\n" " " DEBUG_FLAGS ${DEBUG_FLAGS})
set(CMAKE_C_FLAGS_DEBUG "${DEBUG_FLAGS}")

include_directories(include)

set(SOURCES
    src/kiss_fftr.c
    src/kiss_fft.c
)

add_library(
    ${BIN}
    STATIC
    ${SOURCES}
)

