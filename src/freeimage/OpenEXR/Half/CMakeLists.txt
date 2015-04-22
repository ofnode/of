find_package(ZLIB REQUIRED)

# List the header files
set(HEADERS eLut.h
            half.h
            halfFunction.h
            halfLimits.h
            toFloat.h
)


# List the source files
set(SRCS eLut.cpp
         toFloat.cpp
         half.cpp
)

include_directories(${ZLIB_INCLUDE_DIRS})

# Declaration of the library
add_library(half STATIC ${HEADERS} ${SRCS})

if(UNIX)
    add_definitions(-fPIC)
endif()

set_target_properties(half PROPERTIES COMPILE_FLAGS "-w")

target_link_libraries(half ${ZLIB_LIBRARIES})

