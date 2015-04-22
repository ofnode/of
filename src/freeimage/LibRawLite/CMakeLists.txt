# List the header files
set(HEADERS internal/defines.h
            internal/libraw_bytebuffer.h
            internal/libraw_internal_funcs.h
            internal/var_defines.h
)


# List the source files
set(SRCS internal/dcraw_common.cpp
         internal/dcraw_fileio.cpp
         internal/demosaic_packs.cpp
         src/libraw_c_api.cpp
         src/libraw_cxx.cpp
         src/libraw_datastream.cpp
)


include_directories(${CMAKE_CURRENT_LIST_DIR})

# Declaration of the library
add_library(rawlite STATIC ${HEADERS} ${SRCS})

set_target_properties(rawlite PROPERTIES COMPILE_DEFINITIONS "LIBRAW_NODLL;NO_LCMS")

if(UNIX AND CMAKE_BUILD_TYPE STREQUAL Debug)
    set_target_properties(rawlite PROPERTIES COMPILE_FLAGS "-w -g -fPIC -Wno-c++11-narrowing")
else()
    set_target_properties(rawlite PROPERTIES COMPILE_FLAGS "-w -Wno-c++11-narrowing")
endif()

