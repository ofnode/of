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

if(UNIX)
    add_definitions(-fPIC)
endif()

set_target_properties(iex PROPERTIES COMPILE_FLAGS "-w")

