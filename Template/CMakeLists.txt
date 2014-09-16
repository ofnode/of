cmake_minimum_required(VERSION 2.8)

project(testApp)
set(APP testApp)

set(CMAKE_CXX_FLAGS "-std=c++11")

include(../include.cmake)

set(SOURCES
    main.cpp
    testApp.cpp
)

add_executable(
    ${APP}
    ${SOURCES}
)

target_link_libraries(
    ${APP}
    ${CROSSOF_LIBRARIES}
)
