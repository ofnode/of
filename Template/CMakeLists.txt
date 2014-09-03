cmake_minimum_required(VERSION 2.8)

project(testApp)

set(CMAKE_CXX_FLAGS "-std=c++11")

include(../include.cmake)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY
  ${CMAKE_CURRENT_SOURCE_DIR}/App)

set(APP App_${CMAKE_BUILD_TYPE})

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
