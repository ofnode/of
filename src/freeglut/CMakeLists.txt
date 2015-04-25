# Copyright (C) 2007-2009 LuaDist.
# Created by Peter Kapec
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

project ( freeglut C )
cmake_minimum_required ( VERSION 2.8 )

find_package ( X11 )

###########################################################################################

# generating config.h file:
message ( "Configure: FreeGLUT - generating config.h:" )
include ( CheckIncludeFiles )
include ( CheckFunctionExists )
include ( CheckSymbolExists )

check_include_files ( dlfcn.h HAVE_DLFCN_H )
check_include_files ( fcntl.h HAVE_FCNTL_H )
check_include_files ( "GL/glu.h" HAVE_GL_GLU_H )
check_include_files ( "GL/glx.h" HAVE_GL_GLX_H )
check_include_files ( "GL/gl.h" HAVE_GL_GL_H )
check_include_files ( inttypes.h HAVE_INTTYPES_H )
check_include_files ( limits.h HAVE_LIMITS_H )
check_include_files ( memory.h HAVE_MEMORY_H )
check_include_files ( stdint.h HAVE_STDINT_H )
check_include_files ( stdlib.h HAVE_STDLIB_H )
check_include_files ( strings.h HAVE_STRINGS_H )
check_include_files ( string.h HAVE_STRING_H )
check_include_files ( "sys/ioctl.h" HAVE_SYS_IOCTL_H )
check_include_files ( "sys/param.h" HAVE_SYS_PARAM_H )
check_include_files ( "sys/stat.h" HAVE_SYS_STAT_H )
check_include_files ( "sys/time.h" HAVE_SYS_TIME_H )
check_include_files ( "sys/types.h" HAVE_SYS_TYPES_H )
check_include_files ( unistd.h HAVE_UNISTD_H )

#/* Define to 1 if you have the `vprintf' function. */
check_function_exists ( vprintf HAVE_VPRINTF )
if ( NOT HAVE_VPRINTF )
  #/* Define to 1 if you don't have `vprintf' but do have `_doprnt.' */
  check_function_exists ( _doprnt HAVE_DOPRNT )
endif ( )

check_include_files ( "X11/extensions/xf86vmode.h" HAVE_X11_EXTENSIONS_XF86VMODE_H )

set ( PACKAGE_BUGREPORT "expat-bugs@libexpat.org" )
set ( PACKAGE_NAME "freeglut" )
set ( PACKAGE_STRING "freeglut 2.8.1" )
set ( PACKAGE_TARNAME "freeglut" )
set ( PACKAGE_VERSION "2.8.1" )

check_include_files ( "stdlib.h;stdarg.h;string.h;float.h" STDC_HEADERS )

#/* Define to 1 if the X Window System is missing or not being used. */
if ( NOT HAVE_X11 )
  set ( X_DISPLAY_MISSING 1 )
endif ( )

# all is defined, so generate config.h
configure_file ( "${CMAKE_CURRENT_SOURCE_DIR}/config.h.cmake" "${CMAKE_CURRENT_BINARY_DIR}/config.h" )

message ( "Configure: FreeGLUT - done." )
# end of generating config.h file:

add_definitions ( -DHAVE_CONFIG_H )
include_directories ( ${CMAKE_CURRENT_BINARY_DIR} )

###########################################################################################

find_package ( OpenGL REQUIRED )

# FreeGLUT Library
include_directories ( "include" "src" )

file ( GLOB SRC_FREEGLUTLIB "src/*.c" )

add_library ( freeglut STATIC ${SRC_FREEGLUTLIB} )

if ( CYGWIN OR MSYS OR MINGW OR MSVC )
    add_definitions ( -DWIN32 -DFREEGLUT_EXPORTS )
    target_link_libraries ( freeglut winmm user32 gdi32 ${OPENGL_LIBRARIES} )
elseif ( UNIX AND NOT APPLE )
    find_package ( X11 REQUIRED )
    include_directories ( ${X11_INCLUDE_DIR} )
    target_link_libraries ( freeglut ${OPENGL_LIBRARIES} ${X11_LIBRARIES} )
endif ( )

if ( UNIX )
    add_definitions ( -fPIC )
endif ( )

if ( MSVC )
	add_definitions ( -D_SCL_SECURE_NO_WARNINGS )
	add_definitions ( -D_CRT_SECURE_NO_WARNINGS )
endif ( MSVC )
