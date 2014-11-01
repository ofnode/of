cmake_minimum_required(VERSION 2.8)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

project(libusb)

option(WITH_SHARED "Build a shared library" ON)
option(WITH_STATIC "Build a static library" OFF)
option(WITH_DOCS "Build the documentation" OFF)

option(WITH_DEBUG_LOG "Enable debug logging" OFF)

option(WITH_LOGGING "if false, disable all logging" ON)

option(WITHOUT_PTHREADS "Force pthreads to not be used. If on, then they are used based on detection logic" OFF)

set(LIBUSB_MAJOR 1)
set(LIBUSB_MINOR 0)
set(LIBUSB_MICRO 19)

macro(append_compiler_flags)
	foreach(FLAG IN ITEMS ${ARGN})
		set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${FLAG}")
		set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${FLAG}")
	endforeach()
endmacro()

if(UNIX AND NOT APPLE)
    add_definitions(-DHAVE_LINUX_NETLINK_H -DHAVE_GETTIMEOFDAY)
elseif(WIN32)
    add_definitions(-DHAVE_GETTIMEOFDAY)
endif()

add_subdirectory(libusb)
