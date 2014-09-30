cmake_minimum_required(VERSION 2.8)

list(APPEND CMAKE_MODULE_PATH
  "${CMAKE_CURRENT_SOURCE_DIR}/.."
)

project(ofApp)
set(APP ofApp)

include(openFrameworks)

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
