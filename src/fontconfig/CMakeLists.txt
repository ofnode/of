# Copyright (C) 2011 LuaDist.
# Created by Peter Kapec
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

# IMPORTANT!!!! Files: "fcalias.h fcaliastail.h fcftalias.h fcftaliastail.h" generated on Ubuntu by ./configure & make

PROJECT(fontconfig C)
CMAKE_MINIMUM_REQUIRED(VERSION 2.6)
INCLUDE(dist.cmake)

if(NOT CMAKE_BUILD_TYPE)
   set(CMAKE_BUILD_TYPE "Release")
endif()

if(UNIX AND NOT APPLE)
   set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY
     ${CMAKE_CURRENT_SOURCE_DIR}/../../lib/${CMAKE_BUILD_TYPE}/linux)
elseif(WIN32)
   set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY
     ${CMAKE_CURRENT_SOURCE_DIR}/../../lib/${CMAKE_BUILD_TYPE}/windows)
endif()

# Macros
MACRO(ADD_PREFIX prefix rootlist)
  SET(outlist )
  FOREACH(root ${${rootlist}})
    LIST(APPEND outlist ${prefix}${root})
  ENDFOREACH(root)
  SET(${rootlist} ${outlist})
ENDMACRO(ADD_PREFIX)

###########################################################################################

# generating config.h file:
MESSAGE("Configure: Fontconfig - generating config.h:")
    INCLUDE (CheckIncludeFiles)
    INCLUDE (CheckFunctionExists)
    INCLUDE (CheckSymbolExists)
    INCLUDE (CheckStructHasMember)
    INCLUDE (CheckLibraryExists)

    # TODO: taken from Ubuntu generated config.h
    SET(CONFDIR /usr/local/fonts)
    SET(FC_ADD_FONTS "yes")
    SET(FC_DEFAULT_FONTS "\"/usr/share/fonts\"")
    
    # TODO
    #ENABLE_LIBXML2 # we'll us Expat

    CHECK_FUNCTION_EXISTS(chsize HAVE_CHSIZE)
    
    CHECK_INCLUDE_FILES (dirent.h HAVE_DIRENT_H)
    CHECK_INCLUDE_FILES (dlfcn.h HAVE_DLFCN_H)
    
    CHECK_FUNCTION_EXISTS(vprintf HAVE_VPRINTF)
    IF(NOT HAVE_VPRINTF)
        #/* Define to 1 if you don't have `vprintf' but do have `_doprnt.' */
        CHECK_FUNCTION_EXISTS(_doprnt HAVE_DOPRNT)
    ENDIF()
    
    FIND_PACKAGE(EXPAT)
    IF(EXPAT_FOUND)
        INCLUDE_DIRECTORIES (${EXPAT_INCLUDE_DIRS})
        SET(HAVE_EXPAT 1)
    ENDIF()

    CHECK_INCLUDE_FILES (fcntl.h HAVE_FCNTL_H)
    CHECK_FUNCTION_EXISTS(ftruncate HAVE_FTRUNCATE)
    
    FIND_PACKAGE(Freetype)
    IF(FREETYPE_FOUND)    
        INCLUDE_DIRECTORIES (${FREETYPE_INCLUDE_DIRS})
        
        SET(CMAKE_REQUIRED_INCLUDES ${FREETYPE_INCLUDE_DIRS})
        CHECK_STRUCT_HAS_MEMBER ("FT_Bitmap_Size" "y_ppem" "freetype.h" HAVE_FT_BITMAP_SIZE_Y_PPEM)
        
        SET(CMAKE_REQUIRED_LIBRARIES ${FREETYPE_LIBRARIES})
        CHECK_FUNCTION_EXISTS(_FT_Get_BDF_Property HAVE_FT_GET_BDF_PROPERTY)
        CHECK_FUNCTION_EXISTS(FT_Get_Next_Char HAVE_FT_GET_NEXT_CHAR)
        CHECK_FUNCTION_EXISTS(FT_Get_PS_Font_Info HAVE_FT_GET_PS_FONT_INFO)
        CHECK_FUNCTION_EXISTS(FT_Get_X11_Font_Format HAVE_FT_GET_X11_FONT_FORMAT)
        CHECK_FUNCTION_EXISTS(FT_Has_PS_Glyph_Names HAVE_FT_HAS_PS_GLYPH_NAMES)
        CHECK_FUNCTION_EXISTS(FT_Select_Size HAVE_FT_SELECT_SIZE)
    ENDIF()    
    
    CHECK_FUNCTION_EXISTS(geteuid HAVE_GETEUID)
    CHECK_FUNCTION_EXISTS(getopt HAVE_GETOPT)
    CHECK_FUNCTION_EXISTS(getopt_long HAVE_GETOPT_LONG)
    CHECK_FUNCTION_EXISTS(getpagesize HAVE_GETPAGESIZE)
    CHECK_FUNCTION_EXISTS(getuid HAVE_GETUID)
    
    CHECK_INCLUDE_FILES (inttypes.h HAVE_INTTYPES_H)
    
    CHECK_FUNCTION_EXISTS(link HAVE_LINK)
    CHECK_FUNCTION_EXISTS(lrand48 HAVE_LRAND48)
    CHECK_FUNCTION_EXISTS(memmove HAVE_MEMMOVE)
    
    CHECK_INCLUDE_FILES (memory.h HAVE_MEMORY_H)
    
    CHECK_FUNCTION_EXISTS(memset HAVE_MEMSET)
    CHECK_FUNCTION_EXISTS(mkstemp HAVE_MKSTEMP)
    CHECK_FUNCTION_EXISTS(mmap HAVE_MMAP)

    CHECK_INCLUDE_FILES (ndir.h HAVE_NDIR_H)
    
    CHECK_FUNCTION_EXISTS(rand HAVE_RAND)
    CHECK_FUNCTION_EXISTS(random HAVE_RANDOM)
    
    CHECK_INCLUDE_FILES (stdint.h HAVE_STDINT_H)
    CHECK_INCLUDE_FILES (stdlib.h HAVE_STDLIB_H)


    CHECK_FUNCTION_EXISTS(strchr HAVE_STRCHR)

    CHECK_INCLUDE_FILES (strings.h HAVE_STRINGS_H)
    CHECK_INCLUDE_FILES (string.h HAVE_STRING_H)
    
    CHECK_FUNCTION_EXISTS(strrchr HAVE_STRRCHR)    
    CHECK_FUNCTION_EXISTS(strtol HAVE_STRTOL)    
    CHECK_FUNCTION_EXISTS(sysconf HAVE_SYSCONF)    
    
    CHECK_INCLUDE_FILES ("sys/dir.h" HAVE_SYS_DIR_H)
    CHECK_INCLUDE_FILES ("sys/ndir.h" HAVE_SYS_NDIR_H)
    CHECK_INCLUDE_FILES ("sys/stat.h" HAVE_SYS_STAT_H)
    CHECK_INCLUDE_FILES ("sys/types.h" HAVE_SYS_TYPES_H)
    CHECK_INCLUDE_FILES (unistd.h HAVE_UNISTD_H)

    # TODO:    
    # HAVE_WARNING_CPP_DIRECTIVE
    
    IF(NOT EXPAT_FOUND)
        SET(HAVE_XMLPARSE_H 1) # TODO
    ENDIF()
    
    CHECK_FUNCTION_EXISTS(XML_SetDoctypeDeclHandler HAVE_XML_SETDOCTYPEDECLHANDLER)

    # TODO:
    # LT_OBJDIR
    
    SET(PACKAGE "fontconfig")
    SET(PACKAGE_BUGREPORT "")
    SET(PACKAGE_NAME "")
    SET(PACKAGE_STRING "")
    SET(PACKAGE_TARNAME "")
    SET(PACKAGE_VERSION "")
    
    CHECK_INCLUDE_FILES("stdlib.h;stdarg.h;string.h;float.h" STDC_HEADERS)

    CHECK_LIBRARY_EXISTS (iconv "" "" USE_ICONV)
    SET(VERSION "2.8.0")

    # TODO
    # /* Define to empty if `const' does not conform to ANSI C. */
    # /* #undef const */

    # TODO
    # /* Define to `__inline__' or `__inline' if that's what the C compiler
    #    calls it, or to nothing if 'inline' is not supported under any name.  */
    # #ifndef __cplusplus
    # /* #undef inline */
    # #endif
    
    # TODO
    # /* Define to `int' if <sys/types.h> does not define. */
    # /* #undef pid_t */

# all is defined, so generate config.h
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/config.h.cmake ${CMAKE_CURRENT_BINARY_DIR}/config.h)

MESSAGE("Configure: Fontconfig - done.")
# end of generating config.h file:

ADD_DEFINITIONS(-DHAVE_CONFIG_H -DHAVE_SCANDIR -DFC_NO_MT)
INCLUDE_DIRECTORIES (${CMAKE_CURRENT_BINARY_DIR})

###########################################################################################


#   Fontconfig Library
    INCLUDE_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR} fontconfig fc-arch src)


#~  ADD_DEFINITIONS(-DFONTCONFIG_PATH=${CONFDIR} -DFC_CACHEDIR="/usr/local/cache") # TODO: fix FC_CACHEDIR
    ADD_DEFINITIONS(-DFONTCONFIG_PATH="/usr/local/fonts" -DFC_CACHEDIR="/usr/local/cache") # TODO: fix FC_CACHEDIR

    SET(SRC_FONTCONFIG 
        fcatomic.c 
        fcblanks.c 
        fccache.c 
        fccfg.c 
        fccharset.c 
        fcdbg.c 
        fcdefault.c 
        fcdir.c 
        fcformat.c 
        fcfreetype.c 
        fcfs.c 
        fcinit.c 
        fclang.c 
        fclist.c 
        fcmatch.c 
        fcmatrix.c 
        fcname.c 
        fcpat.c 
        fcserialize.c 
        fcstr.c 
        fcxml.c 
        ftglue.h 
        ftglue.c    
        fcarch.c
        fcarch.h
        fcatomic.h
        fccompat.c
        fchash.c
        fcmutex.h
        fcobjs.c
        fcobjs.h
        fcobjshash.gperf
        fcobjshash.gperf.h
        fcobjshash.h
        fcstat.c
        fcstdint.h
        fcwindows.h
    )
    ADD_PREFIX("src/" SRC_FONTCONFIG )

    ADD_LIBRARY(fontconfig STATIC ${SRC_FONTCONFIG} )

    IF(EXPAT_FOUND)
        TARGET_LINK_LIBRARIES(fontconfig ${EXPAT_LIBRARIES})
    ENDIF ()
    IF(FREETYPE_FOUND)
        TARGET_LINK_LIBRARIES(fontconfig ${FREETYPR_LIBRARIES})
    ENDIF ()    

#   Install Fontconfig Library
    INSTALL(TARGETS fontconfig RUNTIME DESTINATION ${INSTALL_BIN} LIBRARY DESTINATION ${INSTALL_LIB} ARCHIVE DESTINATION ${INSTALL_LIB})

#   Install Fontconfig Headers
    INSTALL(DIRECTORY fontconfig DESTINATION ${INSTALL_INC})

#   Install Fontconfig Documentation
    INSTALL(DIRECTORY doc/ DESTINATION ${INSTALL_DOC}
            PATTERN *.am EXCLUDE
            PATTERN *.in EXCLUDE    )
    INSTALL(FILES AUTHORS ChangeLog COPYING  INSTALL NEWS README DESTINATION ${INSTALL_DOC})
