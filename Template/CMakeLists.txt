cmake_minimum_required(VERSION 2.8)

project(ofApp)
set(APP ofApp)

set(CMAKE_CXX_FLAGS "-std=c++11")

include(../include.cmake)

set(SOURCES
    main.cpp
    ofApp.cpp
)

add_executable(
    ${APP}
    ${SOURCES}
)

target_link_libraries(
    ${APP}
    ${OPENFRAMEWORKS_LIBRARIES}
)
