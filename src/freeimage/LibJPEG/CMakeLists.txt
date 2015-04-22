# List the header files
set(HEADERS jconfig.h
            jdct.h
            jerror.h
            jinclude.h
            jmemsys.h
            jmorecfg.h
            jpegint.h
            jpeglib.h
            jversion.h
            transupp.h
)


# List the source files
set(SRCS jaricom.c
         jcapimin.c
         jcapistd.c
         jcarith.c
         jccoefct.c
         jccolor.c
         jcdctmgr.c
         jchuff.c
         jcinit.c
         jcmainct.c
         jcmarker.c
         jcmaster.c
         jcomapi.c
         jcparam.c
         jcprepct.c
         jcsample.c
         jctrans.c
         jdapimin.c
         jdapistd.c
         jdarith.c
         jdatadst.c
         jdatasrc.c
         jdcoefct.c
         jdcolor.c
         jddctmgr.c
         jdhuff.c
         jdinput.c
         jdmainct.c
         jdmarker.c
         jdmaster.c
         jdmerge.c
         jdpostct.c
         jdsample.c
         jdtrans.c
         jerror.c
         jfdctflt.c
         jfdctfst.c
         jfdctint.c
         jidctflt.c
         jidctfst.c
         jidctint.c
         jmemmgr.c
         jmemnobs.c
         jquant1.c
         jquant2.c
         jutils.c
         transupp.c
)


# Declaration of the library
add_library(jpeg STATIC ${HEADERS} ${SRCS})

if(UNIX AND CMAKE_BUILD_TYPE STREQUAL Debug)
    set_target_properties(jpeg PROPERTIES COMPILE_FLAGS "-w -g -fPIC")
else()
    set_target_properties(jpeg PROPERTIES COMPILE_FLAGS "-w")
endif()

