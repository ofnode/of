# List the header files
set(HEADERS IlmThread.h
            IlmThreadMutex.h
            IlmThreadPool.h
            IlmThreadSemaphore.h
)


# List the source files
set(SRCS IlmThread.cpp
         IlmThreadMutex.cpp
         IlmThreadPool.cpp
         IlmThreadSemaphore.cpp
)


include_directories(${CMAKE_CURRENT_LIST_DIR}/..
                    ${CMAKE_CURRENT_LIST_DIR}/../Half
                    ${CMAKE_CURRENT_LIST_DIR}/../Iex
)

# Declaration of the library
add_library(ilmthread STATIC ${HEADERS} ${SRCS})

if(UNIX)
    add_definitions(-fPIC)
endif()

set_target_properties(ilmthread PROPERTIES COMPILE_FLAGS "-w")

