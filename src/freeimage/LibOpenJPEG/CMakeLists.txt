# List the header files
set(HEADERS bio.h
            cio.h
            dwt.h
            event.h
            function_list.h
            image.h
            indexbox_manager.h
            invert.h
            j2k.h
            jp2.h
            mct.h
            mqc.h
            openjpeg.h
            opj_clock.h
            opj_codec.h
            opj_config.h
            opj_config_private.h
            opj_includes.h
            opj_intmath.h
            opj_inttypes.h
            opj_malloc.h
            opj_stdint.h
            pi.h
            raw.h
            t1.h
            t1_luts.h
            t2.h
            tcd.h
            tgt.h
)


# List the source files
set(SRCS bio.c
         cio.c
         dwt.c
         event.c
         function_list.c
         image.c
         invert.c
         j2k.c
         jp2.c
         mct.c
         mqc.c
         openjpeg.c
         opj_clock.c
         pi.c
         raw.c
         t1.c
         t1_generate_luts.c
         t2.c
         tcd.c
         tgt.c
)


# Declaration of the library
add_library(openjpeg STATIC ${HEADERS} ${SRCS})

set_target_properties(openjpeg PROPERTIES COMPILE_DEFINITIONS "OPJ_STATIC")

if(UNIX AND CMAKE_BUILD_TYPE STREQUAL Debug)
    set_target_properties(openjpeg PROPERTIES COMPILE_FLAGS "-g -fPIC")
endif()

