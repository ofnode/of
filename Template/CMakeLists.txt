cmake_minimum_required(VERSION 2.8)

project(testApp)
set(BIN testApp)

set(CMAKE_CXX_FLAGS "-O3 -std=c++11")

include(../include.cmake)

set(SOURCES main.cpp testApp.cpp)

add_executable(${BIN} ${SOURCES})
target_link_libraries(${BIN} ${CROSSOF_LIBRARIES})
