cmake_minimum_required(VERSION 2.8)

project(App)
set(APP App)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY
  ${CMAKE_CURRENT_SOURCE_DIR}/App)

include(../include.cmake)

set(SOURCES main.cpp testApp.cpp)

add_executable(
    ${APP}-${CMAKE_BUILD_TYPE}
    ${SOURCES}
)
target_link_libraries(
    ${APP}-${CMAKE_BUILD_TYPE}
    ${CROSSOF_LIBRARIES}
)
