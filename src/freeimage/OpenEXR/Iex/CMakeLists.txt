# List the header files
set(HEADERS Iex.h
            IexBaseExc.h
            IexErrnoExc.h
            IexMacros.h
            IexMathExc.h
            IexThrowErrnoExc.h
)


# List the source files
set(SRCS IexBaseExc.cpp
         IexThrowErrnoExc.cpp
)


# Declaration of the library
add_library(iex STATIC ${HEADERS} ${SRCS})

if(UNIX AND CMAKE_BUILD_TYPE STREQUAL Debug)
    set_target_properties(iex PROPERTIES COMPILE_FLAGS "-w -g -fPIC")
else()
    set_target_properties(iex PROPERTIES COMPILE_FLAGS "-w")
endif()

