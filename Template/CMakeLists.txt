
cmake_minimum_required(VERSION 2.8)

project(app)
set(BIN app)

set(CMAKE_CXX_FLAGS "-O3 -std=c++11")

set(CROSSOF ${CMAKE_CURRENT_SOURCE_DIR}/..)
include(crossof.cmake)

set(SOURCES
    main.cpp
)

add_definitions(${CROSSOF_DEFINITIONS})
include_directories(${CROSSOF_INCLUDE_DIRS})

add_executable(${BIN} ${SOURCES})
target_link_libraries(${BIN} ${CROSSOF_LIBRARIES})
