find_package(ZLIB REQUIRED)

# List the header files
set(HEADERS tiffconf.h
            t4.h
            tif_config.h
            tif_dir.h
            tif_fax3.h
            tif_predict.h
            tiff.h
            tiffio.h
            tiffiop.h
            tiffvers.h
            uvcode.h
)


# List the source files
set(SRCS mkg3states.c
         mkspans.c
         tif_jbig.c
         tif_jpeg_12.c
         tif_lzma.c
         tif_aux.c
         tif_close.c
         tif_codec.c
         tif_color.c
         tif_compress.c
         tif_dir.c
         tif_dirinfo.c
         tif_dirread.c
         tif_dirwrite.c
         tif_dumpmode.c
         tif_error.c
         tif_extension.c
         tif_fax3.c
         tif_fax3sm.c
         tif_flush.c
         tif_getimage.c
         tif_jpeg.c
         tif_luv.c
         tif_lzw.c
         tif_next.c
         tif_ojpeg.c
         tif_open.c
         tif_packbits.c
         tif_pixarlog.c
         tif_predict.c
         tif_print.c
         tif_read.c
         tif_strip.c
         tif_swab.c
         tif_thunder.c
         tif_tile.c
         tif_version.c
         tif_warning.c
         tif_write.c
         tif_zip.c
)

# List the include paths
include_directories(${ZLIB_INCLUDE_DIRS})

# Declaration of the library
add_library(tiff STATIC ${HEADERS} ${SRCS})

if(UNIX AND CMAKE_BUILD_TYPE STREQUAL Debug)
    set_target_properties(tiff PROPERTIES COMPILE_FLAGS "-g -fPIC")
endif()

target_link_libraries(tiff ${ZLIB_LIBRARIES})

