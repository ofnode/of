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

set_target_properties(png PROPERTIES COMPILE_FLAGS "-w -fPIC")

target_link_libraries(png ${ZLIB_LIBRARIES})

