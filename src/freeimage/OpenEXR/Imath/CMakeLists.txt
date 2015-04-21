# List the header files
set(HEADERS ImathBox.h
            ImathColorAlgo.h
            ImathFun.h
            ImathMatrixAlgo.h
            ImathRandom.h
            ImathShear.h
            ImathVec.h
)


# List the source files
set(SRCS ImathBox.cpp
         ImathColorAlgo.cpp
         ImathFun.cpp
         ImathMatrixAlgo.cpp
         ImathRandom.cpp
         ImathShear.cpp
         ImathVec.cpp
)


include_directories(${CMAKE_CURRENT_LIST_DIR}/..
                    ${CMAKE_CURRENT_LIST_DIR}/../Half
                    ${CMAKE_CURRENT_LIST_DIR}/../Iex
)

# Declaration of the library
add_library(imath STATIC ${HEADERS} ${SRCS})

if(UNIX AND CMAKE_BUILD_TYPE STREQUAL Debug)
    set_target_properties(imath PROPERTIES COMPILE_FLAGS "-g -fPIC")
endif()

