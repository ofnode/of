find_package(ZLIB REQUIRED)

# List the header files
set(HEADERS pngdebug.h
            pnginfo.h
            pnglibconf.h
            pngpriv.h
            pngstruct.h
            png.h
            pngconf.h
)


# List the source files
set(SRCS png.c
         pngerror.c
         pngget.c
         pngmem.c
         pngpread.c
         pngread.c
         pngrio.c
         pngrtran.c
         pngrutil.c
         pngset.c
         pngtrans.c
         pngwio.c
         pngwrite.c
         pngwtran.c
         pngwutil.c
)

# List the include paths
include_directories(${ZLIB_INCLUDE_DIRS})

# Declaration of the library
add_library(png STATIC ${HEADERS} ${SRCS})

if(UNIX)
    add_definitions(-fPIC)
endif()

if(MSVC)
    set_target_properties(png PROPERTIES COMPILE_DEFINITIONS "Z_SOLO")
endif()

set_target_properties(png PROPERTIES COMPILE_FLAGS "-w")

target_link_libraries(png ${ZLIB_LIBRARIES})

