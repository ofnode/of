cmake_minimum_required(VERSION 2.8)

project(app)
set(BIN app)

set(CMAKE_CXX_FLAGS "-O3 -std=c++11")
set(LIBS -static-libgcc -static-libstdc++)

include(../include.cmake)

set(SOURCES main.cpp)

add_executable(${BIN} ${SOURCES})
target_link_libraries(${BIN} ${CROSSOF_LIBRARIES})
