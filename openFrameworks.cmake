
include(${CMAKE_CURRENT_LIST_DIR}/ofnode_common.cmake)

#// Options ////////////////////////////////////////////////////////////////////

set(OF_COTIRE ON CACHE BOOL "Enable Cotire header precompiler")

if(CMAKE_SYSTEM MATCHES Windows)

  set(OF_CONSOLE OFF CACHE BOOL "Enable console window")

endif()

#// GCC and Clang flags ////////////////////////////////////////////////////////

list(APPEND RELEASE_FLAGS 
  -g1
)

list(APPEND DEBUG_FLAGS
  -Winline
)

#// Clang specific flags ///////////////////////////////////////////////////////

if(CMAKE_C_COMPILER_ID STREQUAL Clang)

  list(APPEND RELEASE_C_FLAGS_CLANG
    ${RELEASE_C_FLAGS_CLANG}
    -Wno-c++11-narrowing
  )

  list(APPEND DEBUG_C_FLAGS_CLANG
    ${DEBUG_C_FLAGS_CLANG}
    -Wno-c++11-narrowing
  )

endif()

if(CMAKE_CXX_COMPILER_ID STREQUAL Clang)

  list(APPEND RELEASE_CXX_FLAGS_CLANG
    -Wno-c++11-narrowing
  )

  list(APPEND DEBUG_CXX_FLAGS_CLANG
    -Wno-c++11-narrowing
  )

endif()

# Output shared libraries and executables to bin folder of your project tree
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE "${CMAKE_CURRENT_SOURCE_DIR}/bin")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE "${CMAKE_CURRENT_SOURCE_DIR}/bin")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG   "${CMAKE_CURRENT_SOURCE_DIR}/bin")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG   "${CMAKE_CURRENT_SOURCE_DIR}/bin")

#// Platform-specific commands /////////////////////////////////////////////////

if(CMAKE_SYSTEM MATCHES Linux)

    if(TARGET_ARCH MATCHES arm*)
      # Assuming Raspberry Pi 2 and Raspbian
      list(APPEND OPENFRAMEWORKS_DEFINITIONS
        -DTARGET_RASPBERRY_PI
        -DUSE_DISPMANX_TRANSFORM_T
        -DSTANDALONE
        -DPIC
        -D_REENTRANT
        -D_LARGEFILE64_SOURCE
        -D_FILE_OFFSET_BITS=64
        -D_FORTIFY_SOURCE
        -D__STDC_CONSTANT_MACROS
        -D__STDC_LIMIT_MACROS
        -DTARGET_POSIX
        -DHAVE_LIBOPENMAX=2
        -DOMX
        -DOMX_SKIP64BIT
        -DUSE_EXTERNAL_OMX
        -DHAVE_LIBBCM_HOST
        -DUSE_EXTERNAL_LIBBCM_HOST
        -DUSE_VCHIQ_ARM
      )
    endif()

    #// Local dependencies /////////////////////////////////////////////////////

    # The folder of executable will be
    # search path for shared libraries
    list(INSERT OPENFRAMEWORKS_LIBRARIES 0
        -Wl,-rpath,'$$ORIGIN'
    )

    if(CMAKE_CROSSCOMPILING)
      list(INSERT OPENFRAMEWORKS_LIBRARIES 0
        -Wl,-rpath-link,${CMAKE_SYSROOT}/usr/lib:${CMAKE_SYSROOT}/usr/lib/arm-linux-gnueabihf:${CMAKE_SYSROOT}/lib:${CMAKE_SYSROOT}/lib/arm-linux-gnueabihf:${CMAKE_SYSROOT}/opt/vc/lib
      )
    endif(CMAKE_CROSSCOMPILING)

    if(CMAKE_BUILD_TYPE MATCHES Release)
        set(OF_LIB_DIR "${OF_ROOT_DIR}/lib-linux/release-${TARGET_ARCH}-${ARCH_BIT}")
    elseif(CMAKE_BUILD_TYPE MATCHES Debug)
        set(OF_LIB_DIR "${OF_ROOT_DIR}/lib-linux/debug-${TARGET_ARCH}-${ARCH_BIT}")
    endif()

    if(OF_STATIC)
      file(GLOB_RECURSE OPENFRAMEWORKS_LIBS "${OF_LIB_DIR}/*.a")
      if(NOT OPENFRAMEWORKS_LIBS)
      message(FATAL_ERROR "No static openFrameworks libraries found in ${OF_LIB_DIR} folder.")
      endif()
    else()
      file(GLOB_RECURSE OPENFRAMEWORKS_LIBS "${OF_LIB_DIR}/*.so")
      if(NOT OPENFRAMEWORKS_LIBS)
      message(FATAL_ERROR "No shared openFrameworks libraries found in ${OF_LIB_DIR} folder.")
      endif()
    endif()

    if(OF_STATIC)
      list(APPEND OPENFRAMEWORKS_LIBRARIES
        -Wl,-Bstatic
        -Wl,--start-group
        ${OPENFRAMEWORKS_LIBS}
        -Wl,--end-group
        -Wl,-Bdynamic
      )
    else()
      list(APPEND OPENFRAMEWORKS_LIBRARIES
        ${OPENFRAMEWORKS_LIBS}
      )
    endif()

    #// Global dependencies ////////////////////////////////////////////////////

    pkg_check_modules(CAIRO REQUIRED cairo)
    pkg_check_modules(FONTCONFIG REQUIRED fontconfig)

    if(TARGET_ARCH MATCHES arm*)
      find_package(OpenGLES REQUIRED)
      message(STATUS "EGL include dir : ${EGL_INCLUDE_DIR}")
      message(STATUS "OpenGLES2 include dir : ${OPENGLES2_INCLUDE_DIR}")
      message(STATUS "EGL library : ${EGL_LIBRARIES}")
      message(STATUS "OpenGLES2 library : ${OPENGLES2_LIBRARIES}")
    else()
      find_package(OpenGL REQUIRED)
    endif()

    find_package(X11 REQUIRED)
    find_package(ZLIB REQUIRED)
    find_package(OpenSSL REQUIRED)
    find_package(Threads REQUIRED)
    find_package(Freetype REQUIRED)

    #// Link static libs if available //////////////////////////////////////////

    if(OF_STATIC)
      set(STATIC_LIB_PATHS
        "/usr/lib/x86_64-linux-gnu"
        "${RPI_ROOT_PATH}/usr/lib/arm-linux-gnueabihf"
        "${RPI_ROOT_PATH}/usr/local/lib"
      )
      find_library(
        ZLIB_LIB NAMES
        libz.a
        PATHS ${STATIC_LIB_PATHS}
      )
      find_library(
        PIXMAN_LIB NAMES
        libpixman-1.a
        PATHS ${STATIC_LIB_PATHS}
      )
      find_library(
        CAIRO_LIB NAMES
        libcairo.a
        PATHS ${STATIC_LIB_PATHS}
      )
      find_library(
        CRYPTO_LIB NAMES
        libcrypto.a
        PATHS ${STATIC_LIB_PATHS}
      )
      find_library(
        SSL_LIB NAMES
        libssl.a
        PATHS ${STATIC_LIB_PATHS}
      )
      find_library(
        FREETYPE_LIB NAMES
        libfreetype.a
        PATHS ${STATIC_LIB_PATHS}
      )
      find_library(
        FONTCONFIG_LIB NAMES
        libfontconfig.a
        PATHS ${STATIC_LIB_PATHS}
      )

    if(ZLIB_LIB MATCHES ZLIB_LIB-NOTFOUND)
      message(STATUS "Using dynamic Zlib")
    else()
      message(STATUS "Using static Zlib")
      set(ZLIB_LIBRARIES
        ${ZLIB_LIB}
      )
    endif()

    if(PIXMAN_LIB MATCHES PIXMAN_LIB-NOTFOUND OR
        CAIRO_LIB MATCHES  CAIRO_LIB-NOTFOUND)
      message(STATUS "Using dynamic Cairo")
    else()
      message(STATUS "Using static Cairo")
      set(CAIRO_LIBRARIES
        -Wl,--start-group
        ${PIXMAN_LIB}
        ${CAIRO_LIB}
        -Wl,--end-group
      )
    endif()

    if(CRYPTO_LIB MATCHES CRYPTO_LIB-NOTFOUND OR
          SSL_LIB MATCHES    SSL_LIB-NOTFOUND)
      message(STATUS "Using dynamic OpenSSL")
    else()
      message(STATUS "Using static OpenSSL")
      find_library(DL_LIB dl)
      set(OPENSSL_LIBRARIES
        -Wl,--start-group
        ${CRYPTO_LIB}
        ${SSL_LIB}
        ${DL_LIB}
        -Wl,--end-group
      )
    endif()

    if(FONTCONFIG_LIB MATCHES FONTCONFIG_LIB-NOTFOUND OR
         FREETYPE_LIB MATCHES   FREETYPE_LIB-NOTFOUND)
      message(STATUS "Using dynamic Fontconfig and FreeType")
    else()
      message(STATUS "Using static Fontconfig and FreeType")
      set(FONTCONFIG_LIBRARIES "")
      set(FREETYPE_LIBRARIES
        -Wl,--start-group
        ${FONTCONFIG_LIB}
        ${FREETYPE_LIB}
        -Wl,--end-group
      )
    endif()

    endif(OF_STATIC)

    #// Global dependencies ////////////////////////////////////////////////////

    list(APPEND OPENFRAMEWORKS_INCLUDE_DIRS
        ${X11_INCLUDE_DIR}
        ${ZLIB_INCLUDE_DIRS}
        ${CAIRO_INCLUDE_DIRS}
        ${OPENGL_INCLUDE_DIR}
        ${OPENSSL_INCLUDE_DIR}
        ${FREETYPE_INCLUDE_DIRS}
        ${FONTCONFIG_INCLUDE_DIRS}
    )

    if(TARGET_ARCH MATCHES arm*)
      list(APPEND OPENFRAMEWORKS_INCLUDE_DIRS
        ${EGL_INCLUDE_DIR}
        ${OPENGLES2_INCLUDE_DIR}
      )
      # Assuming Raspberry Pi 2 and Raspbian
      list(APPEND OPENFRAMEWORKS_INCLUDE_DIRS
        ${RPI_ROOT_PATH}/opt/vc/include
        ${RPI_ROOT_PATH}/opt/vc/include/IL
        ${RPI_ROOT_PATH}/opt/vc/include/interface/vcos/pthreads
        ${RPI_ROOT_PATH}/opt/vc/include/interface/vmcs_host/linux
      )
    endif()

    list(APPEND OPENFRAMEWORKS_LIBRARIES
        ${X11_Xi_LIB}
        ${X11_LIBRARIES}
        ${X11_Xrandr_LIB}
        ${X11_Xcursor_LIB}
        ${X11_Xxf86vm_LIB}
        ${X11_Xinerama_LIB}
        ${ZLIB_LIBRARIES}
        ${CAIRO_LIBRARIES}
        ${OPENGL_LIBRARIES}
        ${OPENSSL_LIBRARIES}
        ${FREETYPE_LIBRARIES}
        ${FONTCONFIG_LIBRARIES}
        ${CMAKE_THREAD_LIBS_INIT}
        pugixml
        glut
        uriparser
        Xmu
	dl
    )

    if(TARGET_ARCH MATCHES arm*)
      list(APPEND OPENFRAMEWORKS_LIBRARIES
        ${EGL_LIBRARIES}
        ${OPENGLES2_LIBRARIES}
      )
    endif()

    if(NOT OF_AUDIO)
      list(APPEND OPENFRAMEWORKS_DEFINITIONS -DTARGET_NO_SOUND)
    else()
      find_package(ALSA REQUIRED)
      find_package(OpenAL REQUIRED)
      find_package(MPG123 REQUIRED)
      find_package(Sndfile REQUIRED)

      list(APPEND OPENFRAMEWORKS_INCLUDE_DIRS
        ${ALSA_INCLUDE_DIRS}
        ${OPENAL_INCLUDE_DIR}
        ${MPG123_INCLUDE_DIRS}
        ${SNDFILE_INCLUDE_DIR}
      )

      list(APPEND OPENFRAMEWORKS_LIBRARIES
        ${ALSA_LIBRARIES}
        ${OPENAL_LIBRARY}
        ${MPG123_LIBRARIES}
        ${SNDFILE_LIBRARIES}
      )
    endif()

    if(NOT OF_VIDEO)
      list(APPEND OPENFRAMEWORKS_DEFINITIONS -DTARGET_NO_VIDEO)
    else()

      find_package(UDev REQUIRED)
      find_package(Glib REQUIRED)

      pkg_check_modules(GSTREAMER gstreamer-1.0)
      pkg_check_modules(GSTREAMER_BASE gstreamer-base-1.0)
      pkg_check_modules(GSTREAMER_VIDEO gstreamer-video-1.0)
      pkg_check_modules(GSTREAMER_APP gstreamer-app-1.0)

      message(STATUS "Gstreamer include dir: " ${GSTREAMER_INCLUDE_DIRS})
      message(STATUS "Gstreamer lib: "       ${GSTREAMER_LIBRARY})
      message(STATUS "Gstreamer lib: "       ${GSTREAMER_LIBRARIES})
      message(STATUS "Gstreamer-app lib: "   ${GSTREAMER_APP_LIBRARIES})
      message(STATUS "Gstreamer-base lib: "  ${GSTREAMER_BASE_LIBRARIES})
      message(STATUS "Gstreamer-video lib: " ${GSTREAMER_VIDEO_LIBRARIES})

      list(APPEND OPENFRAMEWORKS_INCLUDE_DIRS
        ${UDEV_INCLUDE_DIR}
        ${GLIB_INCLUDE_DIRS}
        ${GSTREAMER_INCLUDE_DIRS}
      )

      list(APPEND OPENFRAMEWORKS_LIBRARIES
        ${UDEV_LIBRARIES}
        ${GLIB_LIBRARIES}
        ${GSTREAMER_LIBRARY}
        ${GSTREAMER_LIBRARIES}
        ${GSTREAMER_APP_LIBRARIES}
        ${GSTREAMER_BASE_LIBRARIES}
        ${GSTREAMER_VIDEO_LIBRARIES}
      )

      if ( OF_GTK )
        list(APPEND OPENFRAMEWORKS_DEFINITIONS -DOF_USING_GTK)
        pkg_check_modules(GTK3 REQUIRED gtk+-3.0)
        list(APPEND OPENFRAMEWORKS_INCLUDE_DIRS ${GTK3_INCLUDE_DIRS} )
        list(APPEND OPENFRAMEWORKS_LIBRARIES ${GTK3_LIBRARIES} )
      endif()

      if ( OF_GTK2 )
        list(APPEND OPENFRAMEWORKS_DEFINITIONS -DOF_USING_GTK)
        pkg_check_modules(GTK2 REQUIRED gtk+-2.0)
        list(APPEND OPENFRAMEWORKS_INCLUDE_DIRS ${GTK2_INCLUDE_DIRS} )
        list(APPEND OPENFRAMEWORKS_LIBRARIES ${GTK2_LIBRARIES} )
      endif()

    endif()

elseif(CMAKE_SYSTEM MATCHES Darwin)

    set(CMAKE_OSX_DEPLOYMENT_TARGET 10.9)

    set(OPENFRAMEWORKS_DEFINITIONS
        -DOF_USING_MPG123
        -DOF_SOUND_PLAYER_OPENAL
        -DOF_SOUNDSTREAM_RTAUDIO
    )

    #// Local dependencies /////////////////////////////////////////////////////

    if(CMAKE_BUILD_TYPE MATCHES Release)
        set(OF_LIB_DIR "${OF_ROOT_DIR}/lib-osx/release-${TARGET_ARCH}-${ARCH_BIT}")
    elseif(CMAKE_BUILD_TYPE MATCHES Debug)
        set(OF_LIB_DIR "${OF_ROOT_DIR}/lib-osx/debug-${TARGET_ARCH}-${ARCH_BIT}")
    endif()

    if(OF_STATIC)
      file(GLOB_RECURSE OPENFRAMEWORKS_LIBS "${OF_LIB_DIR}/*.a")
      if(NOT OPENFRAMEWORKS_LIBS)
      message(FATAL_ERROR "No static openFrameworks libraries found in ${OF_LIB_DIR} folder.")
      endif()
    else()
      file(GLOB_RECURSE OPENFRAMEWORKS_LIBS "${OF_LIB_DIR}/*.dylib")
      if(NOT OPENFRAMEWORKS_LIBS)
      message(FATAL_ERROR "No shared openFrameworks libraries found in ${OF_LIB_DIR} folder.")
      endif()
    endif()

    list(APPEND OPENFRAMEWORKS_LIBRARIES
        ${OPENFRAMEWORKS_LIBS}
    )

    #// Global dependencies ////////////////////////////////////////////////////

    set(ENV{PKG_CONFIG_PATH} "$ENV{PKG_CONFIG_PATH}:/usr/local/lib/pkgconfig")

    pkg_check_modules(CAIRO REQUIRED cairo)
    pkg_check_modules(FONTCONFIG REQUIRED fontconfig)

    find_package(ZLIB REQUIRED)
    find_package(MPG123 REQUIRED)
    find_package(Sndfile REQUIRED)
    find_package(Freetype REQUIRED)

    # Homebrew version
    set(OPENSSL_INCLUDE_DIR
        "/usr/local/opt/openssl/include"
    )
    set(OPENSSL_LIBRARIES
        "/usr/local/opt/openssl/lib/libcrypto.a"
        "/usr/local/opt/openssl/lib/libssl.a"
    )

    # Hardcode FreeType path, see issue #15
    list(APPEND OPENFRAMEWORKS_INCLUDE_DIRS
        "/usr/local/include/freetype2"
    )

    list(APPEND OPENFRAMEWORKS_INCLUDE_DIRS
        ${ZLIB_INCLUDE_DIRS}
        ${CAIRO_INCLUDE_DIRS}
        ${OPENGL_INCLUDE_DIR}
        ${OPENSSL_INCLUDE_DIR}
        ${MPG123_INCLUDE_DIRS}
        ${SNDFILE_INCLUDE_DIR}
        ${FONTCONFIG_INCLUDE_DIRS}
    )

    list(APPEND OPENFRAMEWORKS_LIBRARIES
        -L/usr/local/lib
    )

    if(OF_STATIC)

      set(STATIC_LIB_PATHS
        "/usr/local/lib"
        "/usr/lib"
      )

      find_library(
        ZLIB_LIB NAMES
        libz.a
        PATHS ${STATIC_LIB_PATHS}
      )
      find_library(
        CAIRO_LIB NAMES
        libcairo.a
        PATHS ${STATIC_LIB_PATHS}
      )
      find_library(
        PIXMAN_LIB NAMES
        libpixman-1.a
        PATHS ${STATIC_LIB_PATHS}
      )
      find_library(
        CRYPTO_LIB NAMES
        libcrypto.a
        PATHS ${STATIC_LIB_PATHS}
      )
      find_library(
        SSL_LIB NAMES
        libssl.a
        PATHS ${STATIC_LIB_PATHS}
      )
      find_library(
        FREETYPE_LIB NAMES
        libfreetype.a
        PATHS ${STATIC_LIB_PATHS}
      )
      find_library(
        FONTCONFIG_LIB NAMES
        libfontconfig.a
        PATHS ${STATIC_LIB_PATHS}
      )
      find_library(
        BZ2_STATIC_LIB NAMES
        libbz2.a
        PATHS ${STATIC_LIB_PATHS}
      )
      find_library(
        BZ2_SHARED_LIB NAMES
        libbz2.dylib
        PATHS ${STATIC_LIB_PATHS}
      )

    if(ZLIB_LIB MATCHES ZLIB_LIB-NOTFOUND)
      message(STATUS "Using dynamic Zlib")
    else()
      message(STATUS "Using static Zlib")
      set(ZLIB_LIBRARIES
        ${ZLIB_LIB}
      )
    endif()

    if(PIXMAN_LIB MATCHES PIXMAN_LIB-NOTFOUND OR
        CAIRO_LIB MATCHES  CAIRO_LIB-NOTFOUND)
      message(STATUS "Using dynamic Cairo")
    else()
      message(STATUS "Using static Cairo")
      set(CAIRO_LIBRARIES
        ${PIXMAN_LIB}
        ${CAIRO_LIB}
      )
    endif()

    if(CRYPTO_LIB MATCHES CRYPTO_LIB-NOTFOUND OR
          SSL_LIB MATCHES    SSL_LIB-NOTFOUND)
      message(STATUS "Using dynamic OpenSSL")
    else()
      message(STATUS "Using static OpenSSL")
      find_library(DL_LIB dl)
      set(OPENSSL_LIBRARIES
        ${CRYPTO_LIB}
        ${SSL_LIB}
        ${DL_LIB}
      )
    endif()

    if(FONTCONFIG_LIB MATCHES FONTCONFIG_LIB-NOTFOUND OR
         FREETYPE_LIB MATCHES   FREETYPE_LIB-NOTFOUND OR 
         BZ2_SHARED_LIB MATCHES BZ2_SHARED_LIB-NOTFOUND)
      message(STATUS "Using dynamic Fontconfig and FreeType")
    else()
      message(STATUS "Using static Fontconfig and FreeType")
      set(FONTCONFIG_LIBRARIES "")
      set(FREETYPE_LIBRARIES
        ${FONTCONFIG_LIB}
        ${FREETYPE_LIB}
      )
      if(BZ2_STATIC_LIB MATCHES BZ2_STATIC_LIB-NOTFOUND)
        message(STATUS "Using shared BZ2 lib")
        list(APPEND FREETYPE_LIBRARIES
          ${BZ2_SHARED_LIB}
          )
      else()
        message(STATUS "Using static BZ2 lib")
        list(APPEND FREETYPE_LIBRARIES
          ${BZ2_STATIC_LIB}
          )
      endif()
    endif()

    endif(OF_STATIC)

    list(APPEND OPENFRAMEWORKS_LIBRARIES
        ${ZLIB_LIBRARIES}
        ${CAIRO_LIBRARIES}
        ${OPENGL_LIBRARIES}
        ${MPG123_LIBRARIES}
        ${OPENSSL_LIBRARIES}
        ${SNDFILE_LIBRARIES}
        ${FREETYPE_LIBRARIES}
        ${FONTCONFIG_LIBRARIES}
    )

    # Frameworks
    list(APPEND OPENFRAMEWORKS_LIBRARIES
        "-framework OpenAL"
        "-framework OpenGL"
        "-framework Cocoa"
        "-framework IOKit"
        "-framework CoreVideo"
        "-framework QTKit"
        "-framework Accelerate"
        "-framework CoreAudio"
        "-framework AVFoundation"
        "-framework CoreMedia"
    )

elseif(CMAKE_SYSTEM MATCHES Windows)

    set(OPENFRAMEWORKS_DEFINITIONS
        -DOF_USING_MPG123
        -DOF_SOUNDSTREAM_RTAUDIO
        -DOF_SOUND_PLAYER_OPENAL
        -DOF_VIDEO_CAPTURE_DIRECTSHOW
        -DOF_VIDEO_PLAYER_DIRECTSHOW
    )

    #// Local dependencies /////////////////////////////////////////////////////

    if(CMAKE_BUILD_TYPE MATCHES Release)
        set(OF_LIB_DIR "${OF_ROOT_DIR}/lib-windows/release-${TARGET_ARCH}-${ARCH_BIT}")
    elseif(CMAKE_BUILD_TYPE MATCHES Debug)
        set(OF_LIB_DIR "${OF_ROOT_DIR}/lib-windows/debug-${TARGET_ARCH}-${ARCH_BIT}")
    endif()

    if(OF_STATIC)
      file(GLOB_RECURSE OPENFRAMEWORKS_LIBS "${OF_LIB_DIR}/*.a")
      if(NOT OPENFRAMEWORKS_LIBS)
      message(FATAL_ERROR "No static openFrameworks libraries found in ${OF_LIB_DIR} folder.")
      endif()
    else()
      file(GLOB_RECURSE OPENFRAMEWORKS_LIBS "${OF_LIB_DIR}/*.dll")
      if(NOT OPENFRAMEWORKS_LIBS)
      message(FATAL_ERROR "No openFrameworks DLLs found in ${OF_LIB_DIR} folder.")
      endif()
    endif()

    # Hide console by default
    if(NOT OF_CONSOLE)
      list(APPEND OPENFRAMEWORKS_LIBRARIES -mwindows)
    endif()

    if(OF_STATIC)
      list(APPEND OPENFRAMEWORKS_LIBRARIES
        -Wl,-Bstatic
        -Wl,--start-group
        ${OPENFRAMEWORKS_LIBS}
        -Wl,--end-group
        -Wl,-Bdynamic
      )
    else()
      list(APPEND OPENFRAMEWORKS_LIBRARIES
        ${OPENFRAMEWORKS_LIBS}
      )
    endif()

    #// Global dependencies ////////////////////////////////////////////////////

    pkg_check_modules(CAIRO REQUIRED cairo)
    pkg_check_modules(FONTCONFIG REQUIRED fontconfig)

    find_package(ZLIB REQUIRED)
    find_package(OpenAL REQUIRED)
    find_package(OpenGL REQUIRED)
    find_package(MPG123 REQUIRED)
    find_package(Pixman REQUIRED)
    find_package(OpenSSL REQUIRED)
    find_package(Sndfile REQUIRED)
    find_package(Threads REQUIRED)
    find_package(LibIntl REQUIRED)
    find_package(Freetype REQUIRED)

    find_library(WINMM_LIB winmm)
    find_library(GDI32_LIB gdi32)
    find_library(DSOUND_LIB dsound)
    find_library(WS2_32_LIB ws2_32)
    find_library(CRYPT32_LIB crypt32)
    find_library(WSOCK32_LIB wsock32)
    find_library(IPHLPAPI_LIB iphlpapi)
    find_library(SETUPAPI_LIB setupapi)
    find_library(STRMIIDS_LIB strmiids)

    list(APPEND OPENFRAMEWORKS_INCLUDE_DIRS
        ${ZLIB_INCLUDE_DIRS}
        ${CAIRO_INCLUDE_DIRS}
        ${OPENAL_INCLUDE_DIR}
        ${OPENGL_INCLUDE_DIR}
        ${MPG123_INCLUDE_DIRS}
        ${PIXMAN_INCLUDE_DIRS}
        ${OPENSSL_INCLUDE_DIR}
        ${SNDFILE_INCLUDE_DIR}
        ${LIBINTL_INCLUDE_DIR}
        ${FREETYPE_INCLUDE_DIRS}
        ${FONTCONFIG_INCLUDE_DIRS}
    )

    list(APPEND OPENFRAMEWORKS_LIBRARIES
        ${OPENAL_LIBRARY}
        ${ZLIB_LIBRARIES}
        ${CAIRO_LIBRARIES}
        ${OPENGL_LIBRARIES}
        ${MPG123_LIBRARIES}
        ${PIXMAN_LIBRARIES}
        ${OPENSSL_LIBRARIES}
        ${SNDFILE_LIBRARIES}
        ${LIBINTL_LIBRARIES}
        ${FREETYPE_LIBRARIES}
        ${FONTCONFIG_LIBRARIES}
        ${CMAKE_THREAD_LIBS_INIT}
    )

    list(APPEND OPENFRAMEWORKS_LIBRARIES
        ${WINMM_LIB}
        ${GDI32_LIB}
        ${DSOUND_LIB}
        ${WS2_32_LIB}
        ${CRYPT32_LIB}
        ${WSOCK32_LIB}
        ${IPHLPAPI_LIB}
        ${SETUPAPI_LIB}
        ${STRMIIDS_LIB}
    )

    if(NOT OF_STATIC)
      string(REPLACE "/" "\\" DLLS "${OF_LIB_DIR}/*.dll")
      string(REPLACE "/" "\\" DEST "${CMAKE_CURRENT_SOURCE_DIR}/bin")
      file(GLOB_RECURSE DLLS_EXIST "${CMAKE_CURRENT_SOURCE_DIR}/bin/*.dll")
      file(MAKE_DIRECTORY ${DEST})
      if(NOT DLLS_EXIST)
        execute_process(COMMAND xcopy /s ${DLLS} ${DEST})
      endif()
    endif()

endif()

#// Compiler flags /////////////////////////////////////////////////////////////

list(APPEND OPENFRAMEWORKS_DEFINITIONS
    -DFREEIMAGE_LIB
    -DPOCO_STATIC
)

list(APPEND OPENFRAMEWORKS_DEFINITIONS
    -DNO_LCMS
    -DOPJ_STATIC
    -DLIBRAW_NODLL
    -DDISABLE_PERF_MEASUREMENT
)

if(CMAKE_SYSTEM MATCHES Linux)
list(APPEND OPENFRAMEWORKS_DEFINITIONS
    -D__ANSI__
)
elseif(CMAKE_SYSTEM MATCHES Darwin)
list(APPEND OPENFRAMEWORKS_DEFINITIONS
    -D__MACOSX_CORE__
)
elseif(CMAKE_SYSTEM MATCHES Windows)
list(APPEND OPENFRAMEWORKS_DEFINITIONS
    -DWIN32
    -DWINVER=0x0500
    -D_WIN32_WINNT=0x0501
    -D_UNICODE
    -DUNICODE
)
endif()

add_definitions(${OPENFRAMEWORKS_DEFINITIONS})
include_directories(${OPENFRAMEWORKS_INCLUDE_DIRS})

if(CMAKE_C_COMPILER_ID STREQUAL Clang)
    set(O_C_FLAG -O0)
elseif(CMAKE_C_COMPILER_ID STREQUAL GNU)
  if(CMAKE_C_COMPILER_VERSION VERSION_GREATER 4.8.0)
    set(O_C_FLAG -Og)
  else()
    set(O_C_FLAG -O0)
  endif()
endif()

if(CMAKE_CXX_COMPILER_ID STREQUAL Clang)
    set(O_CXX_FLAG -O0)
elseif(CMAKE_CXX_COMPILER_ID STREQUAL GNU)
  if(CMAKE_CXX_COMPILER_VERSION VERSION_GREATER 4.8.0)
    set(O_CXX_FLAG -Og)
  else()
    set(O_CXX_FLAG -O0)
  endif()
endif()

if(TARGET_ARCH MATCHES armv7)
    set(ARCH_FLAG "-march=armv7-a -mfpu=vfp -mfloat-abi=hard")
elseif(TARGET_ARCH MATCHES armv6)
    set(ARCH_FLAG "-march=armv6 -mfpu=vfp -mfloat-abi=hard")
elseif(ARCH_BIT MATCHES 32)
    set(ARCH_FLAG "-m32")
endif()

if(CMAKE_SYSTEM MATCHES Linux)
    set(PIC_FLAG -fPIC)
endif()

if(CMAKE_SYSTEM MATCHES Darwin)
    set(CPP11_FLAG -std=c++1y)
else()
    set(CPP11_FLAG -std=gnu++14)
endif()

if(CMAKE_C_COMPILER_ID STREQUAL Clang)
    set(C_COLORIZATION "-fcolor-diagnostics")
elseif(CMAKE_C_COMPILER_ID STREQUAL GNU)
  if(CMAKE_C_COMPILER_VERSION VERSION_GREATER 4.9.0)
    set(C_COLORIZATION "-fdiagnostics-color")
  endif()
endif()

if(CMAKE_CXX_COMPILER_ID STREQUAL Clang)
    set(CXX_COLORIZATION "-fcolor-diagnostics")
elseif(CMAKE_CXX_COMPILER_ID STREQUAL GNU)
  if(CMAKE_CXX_COMPILER_VERSION VERSION_GREATER 4.9.0)
    set(CXX_COLORIZATION "-fdiagnostics-color")
  endif()
endif()

string(REPLACE "\n" " " RELEASE_FLAGS ${RELEASE_FLAGS})
string(REPLACE "\n" " "   DEBUG_FLAGS   ${DEBUG_FLAGS})

if(CMAKE_C_COMPILER_ID STREQUAL Clang)
string(REPLACE "\n" " " RELEASE_C_FLAGS_CLANG ${RELEASE_C_FLAGS_CLANG})
string(REPLACE "\n" " "   DEBUG_C_FLAGS_CLANG   ${DEBUG_C_FLAGS_CLANG})
elseif(CMAKE_C_COMPILER_ID STREQUAL GNU)
string(REPLACE "\n" " " RELEASE_C_FLAGS_GCC ${RELEASE_C_FLAGS_GCC})
string(REPLACE "\n" " "   DEBUG_C_FLAGS_GCC   ${DEBUG_C_FLAGS_GCC})
endif()
if(CMAKE_CXX_COMPILER_ID STREQUAL Clang)
string(REPLACE "\n" " " RELEASE_CXX_FLAGS_CLANG ${RELEASE_CXX_FLAGS_CLANG})
string(REPLACE "\n" " "   DEBUG_CXX_FLAGS_CLANG   ${DEBUG_CXX_FLAGS_CLANG})
elseif(CMAKE_CXX_COMPILER_ID STREQUAL GNU)
string(REPLACE "\n" " " RELEASE_CXX_FLAGS_GCC ${RELEASE_CXX_FLAGS_GCC})
string(REPLACE "\n" " "   DEBUG_CXX_FLAGS_GCC   ${DEBUG_CXX_FLAGS_GCC})
endif()

string(REGEX REPLACE " +" " " CMAKE_C_FLAGS_RELEASE "${C_COLORIZATION} ${CMAKE_C_FLAGS_RELEASE} ${RELEASE_FLAGS} ${RELEASE_C_FLAGS_CLANG} ${RELEASE_C_FLAGS_GCC} ${ARCH_FLAG} ${PIC_FLAG}")
string(REGEX REPLACE " +" " " CMAKE_C_FLAGS_DEBUG   "${C_COLORIZATION} ${CMAKE_C_FLAGS_DEBUG}     ${DEBUG_FLAGS}   ${DEBUG_C_FLAGS_CLANG}   ${DEBUG_C_FLAGS_GCC} ${ARCH_FLAG} ${PIC_FLAG} ${O_C_FLAG}")

string(REGEX REPLACE " +" " " CMAKE_CXX_FLAGS_RELEASE "${CXX_COLORIZATION} ${CPP11_FLAG} ${CMAKE_CXX_FLAGS_RELEASE} ${RELEASE_FLAGS} ${RELEASE_CXX_FLAGS_CLANG} ${RELEASE_CXX_FLAGS_GCC} ${ARCH_FLAG} ${PIC_FLAG}")
string(REGEX REPLACE " +" " " CMAKE_CXX_FLAGS_DEBUG   "${CXX_COLORIZATION} ${CPP11_FLAG} ${CMAKE_CXX_FLAGS_DEBUG}     ${DEBUG_FLAGS}   ${DEBUG_CXX_FLAGS_CLANG}   ${DEBUG_CXX_FLAGS_GCC} ${ARCH_FLAG} ${PIC_FLAG} ${O_CXX_FLAG}")

if(OF_STATIC)
  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -static-libstdc++")
endif()

#// ofxAddons //////////////////////////////////////////////////////////////////

function(ofxaddon OFXADDON)

    set(OFXADDON_DIR ${OFXADDON})

    if(OFXADDON STREQUAL ofxAccelerometer)
        message(FATAL_ERROR "${OFXADDON} is not supported yet.")


    elseif(OFXADDON STREQUAL ofxAndroid)
        message(FATAL_ERROR "${OFXADDON} is not supported yet.")


    elseif(OFXADDON STREQUAL ofxAssimpModelLoader)
        set(OFXADDON_DIR "${OF_ROOT_DIR}/addons/ofxAssimpModelLoader")
        set(OFXSOURCES
            "${OFXADDON_DIR}/src/ofxAssimpAnimation.cpp"
            "${OFXADDON_DIR}/src/ofxAssimpMeshHelper.cpp"
            "${OFXADDON_DIR}/src/ofxAssimpModelLoader.cpp"
            "${OFXADDON_DIR}/src/ofxAssimpTexture.cpp"
        )
        include_directories("${OFXADDON_DIR}/src")
        pkg_check_modules(ASSIMP REQUIRED assimp)
        include_directories(${ASSIMP_INCLUDE_DIRS})
        link_directories(${ASSIMP_LIBRARY_DIRS})
        set(OPENFRAMEWORKS_LIBRARIES
          ${OPENFRAMEWORKS_LIBRARIES} ${ASSIMP_LIBRARIES} PARENT_SCOPE)


    elseif(OFXADDON STREQUAL ofxEmscripten)
        message(FATAL_ERROR "${OFXADDON} is not supported yet.")


    elseif(OFXADDON STREQUAL ofxGui)
        set(OFXADDON_DIR "${OF_ROOT_DIR}/addons/ofxGui")
        set(OFXSOURCES
            "${OFXADDON_DIR}/src/ofxBaseGui.cpp"
            "${OFXADDON_DIR}/src/ofxButton.cpp"
            "${OFXADDON_DIR}/src/ofxGuiGroup.cpp"
            "${OFXADDON_DIR}/src/ofxLabel.cpp"
            "${OFXADDON_DIR}/src/ofxPanel.cpp"
            "${OFXADDON_DIR}/src/ofxSlider.cpp"
            "${OFXADDON_DIR}/src/ofxSliderGroup.cpp"
            "${OFXADDON_DIR}/src/ofxToggle.cpp"
        )
        include_directories("${OFXADDON_DIR}/src")


    elseif(OFXADDON STREQUAL ofxiOS)
        message(FATAL_ERROR "${OFXADDON} is not supported yet.")


    elseif(OFXADDON STREQUAL ofxKinect)
        set(OFXADDON_DIR "${OF_ROOT_DIR}/addons/ofxKinect")
        set(OFXSOURCES
            "${OFXADDON_DIR}/libs/libfreenect/src/audio.c"
            "${OFXADDON_DIR}/libs/libfreenect/src/cameras.c"
            "${OFXADDON_DIR}/libs/libfreenect/src/core.c"
            "${OFXADDON_DIR}/libs/libfreenect/src/flags.c"
            "${OFXADDON_DIR}/libs/libfreenect/src/keep_alive.c"
            "${OFXADDON_DIR}/libs/libfreenect/src/loader.c"
            "${OFXADDON_DIR}/libs/libfreenect/src/registration.c"
            "${OFXADDON_DIR}/libs/libfreenect/src/tilt.c"
            "${OFXADDON_DIR}/libs/libfreenect/src/usb_libusb10.c"
            "${OFXADDON_DIR}/src/extra/ofxKinectExtras.cpp"
            "${OFXADDON_DIR}/src/ofxKinect.cpp"
        )
        include_directories("${OFXADDON_DIR}/src")
        include_directories("${OFXADDON_DIR}/src/extra")
        include_directories("${OFXADDON_DIR}/libs/libfreenect/src")
        include_directories("${OFXADDON_DIR}/libs/libfreenect/include")
        find_package(LibUSB REQUIRED)
        add_definitions(${LIBUSB_1_DEFINITIONS})
        include_directories(${LIBUSB_1_INCLUDE_DIRS})
        set(OPENFRAMEWORKS_LIBRARIES
          ${OPENFRAMEWORKS_LIBRARIES} ${LIBUSB_1_LIBRARIES} PARENT_SCOPE)


    elseif(OFXADDON STREQUAL ofxNetwork)
        set(OFXADDON_DIR "${OF_ROOT_DIR}/addons/ofxNetwork")
        set(OFXSOURCES
            "${OFXADDON_DIR}/src/ofxTCPClient.cpp"
            "${OFXADDON_DIR}/src/ofxTCPManager.cpp"
            "${OFXADDON_DIR}/src/ofxTCPServer.cpp"
            "${OFXADDON_DIR}/src/ofxUDPManager.cpp"
        )
        include_directories("${OFXADDON_DIR}/src")


    elseif(OFXADDON STREQUAL ofxOpenCv)
        set(OFXADDON_DIR "${OF_ROOT_DIR}/addons/ofxOpenCv")
        set(OFXSOURCES
            "${OFXADDON_DIR}/src/ofxCvColorImage.cpp"
            "${OFXADDON_DIR}/src/ofxCvContourFinder.cpp"
            "${OFXADDON_DIR}/src/ofxCvFloatImage.cpp"
            "${OFXADDON_DIR}/src/ofxCvGrayscaleImage.cpp"
            "${OFXADDON_DIR}/src/ofxCvHaarFinder.cpp"
            "${OFXADDON_DIR}/src/ofxCvImage.cpp"
            "${OFXADDON_DIR}/src/ofxCvShortImage.cpp"
        )
        include_directories("${OFXADDON_DIR}/src")
        pkg_check_modules(OPENCV REQUIRED opencv)
        include_directories(${OPENCV_INCLUDE_DIRS})
        link_directories(${OPENCV_LIBRARY_DIRS})
        foreach(LIBRARY ${OPENCV_LIBRARIES})
          if(NOT ${LIBRARY} MATCHES opencv_ts AND
             NOT ${LIBRARY} MATCHES opengl32  AND
             NOT ${LIBRARY} MATCHES glu32)
               find_library(FOUND_${LIBRARY} ${LIBRARY})
               set(OFXADDON_LIBRARIES ${OFXADDON_LIBRARIES} ${FOUND_${LIBRARY}})
          endif()
        endforeach()
        find_package(TBB)
        if(TBB_FOUND AND CMAKE_SYSTEM MATCHES Linux)
            include_directories(${TBB_INCLUDE_DIRS})
            list(APPEND OFXADDON_LIBRARIES ${TBB_LIBRARIES})
        endif()
        set(OPENFRAMEWORKS_LIBRARIES
          ${OPENFRAMEWORKS_LIBRARIES} ${OFXADDON_LIBRARIES} PARENT_SCOPE)


    elseif(OFXADDON STREQUAL ofxOsc)
        set(OFXADDON_DIR "${OF_ROOT_DIR}/addons/ofxOsc")
        set(OFXSOURCES
            "${OFXADDON_DIR}/libs/oscpack/src/ip/IpEndpointName.cpp"
            "${OFXADDON_DIR}/libs/oscpack/src/osc/OscOutboundPacketStream.cpp"
            "${OFXADDON_DIR}/libs/oscpack/src/osc/OscPrintReceivedElements.cpp"
            "${OFXADDON_DIR}/libs/oscpack/src/osc/OscReceivedElements.cpp"
            "${OFXADDON_DIR}/libs/oscpack/src/osc/OscTypes.cpp"
            "${OFXADDON_DIR}/src/ofxOscBundle.cpp"
            "${OFXADDON_DIR}/src/ofxOscMessage.cpp"
            "${OFXADDON_DIR}/src/ofxOscParameterSync.cpp"
            "${OFXADDON_DIR}/src/ofxOscReceiver.cpp"
            "${OFXADDON_DIR}/src/ofxOscSender.cpp"
        )
        if(CMAKE_SYSTEM MATCHES Linux)
            list(APPEND OFXSOURCES
            "${OFXADDON_DIR}/libs/oscpack/src/ip/posix/NetworkingUtils.cpp"
            "${OFXADDON_DIR}/libs/oscpack/src/ip/posix/UdpSocket.cpp"
            )
        elseif(CMAKE_SYSTEM MATCHES Darwin)
            list(APPEND OFXSOURCES
            "${OFXADDON_DIR}/libs/oscpack/src/ip/posix/NetworkingUtils.cpp"
            "${OFXADDON_DIR}/libs/oscpack/src/ip/posix/UdpSocket.cpp"
            )
        elseif(CMAKE_SYSTEM MATCHES Windows)
            list(APPEND OFXSOURCES
            "${OFXADDON_DIR}/libs/oscpack/src/ip/win32/NetworkingUtils.cpp"
            "${OFXADDON_DIR}/libs/oscpack/src/ip/win32/UdpSocket.cpp"
            )
        endif()
        include_directories("${OFXADDON_DIR}/src")
        include_directories("${OFXADDON_DIR}/libs/oscpack/src")
        include_directories("${OFXADDON_DIR}/libs/oscpack/src/ip")
        include_directories("${OFXADDON_DIR}/libs/oscpack/src/osc")


    elseif(OFXADDON STREQUAL ofxSvg)
        set(OFXADDON_DIR "${OF_ROOT_DIR}/addons/ofxSvg")
        set(OFXSOURCES
            "${OFXADDON_DIR}/libs/svgTiny/src/src_colors.cpp"
            "${OFXADDON_DIR}/libs/svgTiny/src/svgtiny.cpp"
            "${OFXADDON_DIR}/libs/svgTiny/src/svgtiny_gradient.cpp"
            "${OFXADDON_DIR}/libs/svgTiny/src/svgtiny_list.cpp"
            "${OFXADDON_DIR}/src/ofxSvg.cpp"
        )
        include_directories("${OFXADDON_DIR}/src")
        include_directories("${OFXADDON_DIR}/libs/svgTiny/src")


    elseif(OFXADDON STREQUAL ofxThreadedImageLoader)
        set(OFXADDON_DIR "${OF_ROOT_DIR}/addons/ofxThreadedImageLoader")
        set(OFXSOURCES "${OFXADDON_DIR}/src/ofxThreadedImageLoader.cpp")
        include_directories("${OFXADDON_DIR}/src")


    elseif(OFXADDON STREQUAL ofxUnitTests)
        message(FATAL_ERROR "${OFXADDON} is not supported yet.")


    elseif(OFXADDON STREQUAL ofxVectorGraphics)
        set(OFXADDON_DIR "${OF_ROOT_DIR}/addons/ofxVectorGraphics")
        set(OFXSOURCES
            "${OFXADDON_DIR}/libs/CreEPS.cpp"
            "${OFXADDON_DIR}/src/ofxVectorGraphics.cpp"
        )
        include_directories("${OFXADDON_DIR}/src")
        include_directories("${OFXADDON_DIR}/libs")


    elseif(OFXADDON STREQUAL ofxXmlSettings)
        set(OFXADDON_DIR "${OF_ROOT_DIR}/addons/ofxXmlSettings")
        set(OFXSOURCES
            "${OFXADDON_DIR}/libs/tinyxml.cpp"
            "${OFXADDON_DIR}/libs/tinyxmlerror.cpp"
            "${OFXADDON_DIR}/libs/tinyxmlparser.cpp"
            "${OFXADDON_DIR}/src/ofxXmlSettings.cpp"
        )
        include_directories("${OFXADDON_DIR}/src")
        include_directories("${OFXADDON_DIR}/libs")

    else()

        if(EXISTS "${CMAKE_CURRENT_LIST_DIR}/${OFXADDON_DIR}/")
            set(OFXADDON_DIR "${CMAKE_CURRENT_LIST_DIR}/${OFXADDON_DIR}")
        elseif(EXISTS "${OF_ROOT_DIR}/addons/${OFXADDON_DIR}/")
            set(OFXADDON_DIR "${OF_ROOT_DIR}/addons/${OFXADDON_DIR}/")
        else()
            string(FIND ${CMAKE_CURRENT_LIST_DIR} "/${OFXADDON_DIR}/" POS REVERSE)
            if(POS GREATER 0)
                string(LENGTH "/${OFXADDON_DIR}" LEN)
                math(EXPR LEN2 "${LEN}+${POS}")
                string(SUBSTRING ${CMAKE_CURRENT_LIST_DIR} 0 ${LEN2} OFXADDON_DIR)
            else()
                message(FATAL_ERROR "ofxaddon(${OFXADDON_DIR}): the folder doesn't exist.")
            endif()
        endif()

        if (${CMAKE_SYSTEM_NAME} MATCHES Linux)
          if (${TARGET_ARCH} MATCHES "x86_64")
            set(ADDON_CONFIG_TARGET linux64)
          else()
            set(ADDON_CONFIG_TARGET linux)
          endif()
        elseif (${CMAKE_SYSTEM_NAME} MATCHES Windows)
          if( ${CMAKE_GENERATOR} MATCHES "Visual Studio")
            set(ADDON_CONFIG_TARGET vs)
          else ()
            set(ADDON_CONFIG_TARGET msys2)
          endif()
        elseif (${CMAKE_SYSTEM_NAME} MATCHES Darwin)
          set(ADDON_CONFIG_TARGET osx)
        endif()

        # parse addon_config.mk
        if(EXISTS "${OFXADDON_DIR}/addon_config.mk")

            FILE(READ "${OFXADDON_DIR}/addon_config.mk" OFXADDON_CONFIG)

            # Convert file contents into a CMake list (where each element in the list
            # is one line of the file)
            #
            STRING(REGEX REPLACE ";" "\\\\;" OFXADDON_CONFIG "${OFXADDON_CONFIG}")
            STRING(REGEX REPLACE "\n" ";" OFXADDON_CONFIG "${OFXADDON_CONFIG}")

            set(ADDON_CONFIG_SCOPE)
            foreach(line ${OFXADDON_CONFIG})
              string(STRIP ${line} line) # strip space
              if ( ${line} MATCHES "^[a-zA-Z1-9]*:$" ) # get addon_config.mk scope
                set(ADDON_CONFIG_SCOPE ${line})
              elseif ( NOT((${line} MATCHES "^#"))) # strip comment

                if ( NOT((${ADDON_CONFIG_SCOPE} MATCHES "${ADDON_CONFIG_TARGET}:") OR (${ADDON_CONFIG_SCOPE} MATCHES "meta:") OR (${ADDON_CONFIG_SCOPE} MATCHES "common:")))
                  # do nothing if not in a relevant scope
                elseif (${line} MATCHES "^ADDON_NAME")
                  string(FIND ${line} "=" pos)
                  if (NOT (${pos} MATCHES "-1"))
                    MATH(EXPR pos "${pos}+1")
                    string(SUBSTRING ${line} ${pos} -1 ADDON_NAME)
                  endif()
                elseif (${line} MATCHES "ADDON_INCLUDES_EXCLUDE")
                  string(FIND ${line} "=" pos)
                  if (NOT (${pos} MATCHES "-1"))
                    MATH(EXPR pos "${pos}+1")
                    string(SUBSTRING ${line} ${pos} -1 ADDON_INCLUDES_EXCLUDE_DIR)
                    string(REPLACE "." "\." ADDON_INCLUDES_EXCLUDE_DIR ${ADDON_INCLUDES_EXCLUDE_DIR})
                    string(REPLACE "%" ".*" ADDON_INCLUDES_EXCLUDE_DIR ${ADDON_INCLUDES_EXCLUDE_DIR})
                    string(REPLACE "/" "\/" ADDON_INCLUDES_EXCLUDE_DIR ${ADDON_INCLUDES_EXCLUDE_DIR})
                    string(STRIP ${ADDON_INCLUDES_EXCLUDE_DIR} ADDON_INCLUDES_EXCLUDE_DIR)
                    list(APPEND ADDON_INCLUDES_EXCLUDE ${ADDON_INCLUDES_EXCLUDE_DIR})
                  endif()
                elseif (${line} MATCHES "ADDON_SOURCES_EXCLUDE")
                  string(FIND ${line} "=" pos)
                  if (NOT (${pos} MATCHES "-1"))
                    MATH(EXPR pos "${pos}+1")
                    string(SUBSTRING ${line} ${pos} -1 ADDON_SOURCES_EXCLUDE_DIR)
                    string(REPLACE "." "\." ADDON_SOURCES_EXCLUDE_DIR ${ADDON_SOURCES_EXCLUDE_DIR})
                    string(REPLACE "%" ".*" ADDON_SOURCES_EXCLUDE_DIR ${ADDON_SOURCES_EXCLUDE_DIR})
                    string(REPLACE "/" "\/" ADDON_SOURCES_EXCLUDE_DIR ${ADDON_SOURCES_EXCLUDE_DIR})
                    string(STRIP ${ADDON_SOURCES_EXCLUDE_DIR} ADDON_SOURCES_EXCLUDE_DIR)
                    list(APPEND ADDON_SOURCES_EXCLUDE ${ADDON_SOURCES_EXCLUDE_DIR})
                  endif()
                elseif (${line} MATCHES "ADDON_INCLUDES")
                  string(FIND ${line} "=" pos)
                  if (NOT (${pos} MATCHES "-1"))
                    MATH(EXPR pos "${pos}+1")
                    string(SUBSTRING ${line} ${pos} -1 ADDON_INCLUDE)
                    string(STRIP ${ADDON_INCLUDE} ADDON_INCLUDE)
                    include_directories(${OFXADDON_DIR}/${ADDON_INCLUDE})
                    list(APPEND ADDON_INCLUDES ${OFXADDON_DIR}/${ADDON_INCLUDE})
                  endif()
                elseif (${line} MATCHES "ADDON_DEPENDENCIES")
                  string(FIND ${line} "=" pos)
                  if (NOT (${pos} MATCHES "-1"))
                    MATH(EXPR pos "${pos}+1")
                    string(SUBSTRING ${line} ${pos} -1 ADDON_DEPENDENCIE)
                    string(STRIP ${ADDON_DEPENDENCIE} ADDON_DEPENDENCIE)
                    list(APPEND ADDON_DEPENDENCIES ${ADDON_DEPENDENCIE})
                  endif()
                elseif (${line} MATCHES "ADDON_LIBS")
                  string(FIND ${line} "=" pos)
                  if (NOT (${pos} MATCHES "-1"))
                    MATH(EXPR pos "${pos}+1")
                    string(SUBSTRING ${line} ${pos} -1 ADDON_LIB)
                    string(STRIP ${ADDON_LIB} ADDON_LIB)
                    if (NOT (IS_ABSOLUTE ${ADDON_LIB}))
                      set(ADDON_LIB ${ADDON_LIB})
                    endif()
                    list(APPEND ADDON_LIBS ${OFXADDON_DIR}/${ADDON_LIB})
                  endif()
                elseif (${line} MATCHES "ADDON_CPPFLAGS")
                  string(FIND ${line} "=" pos)
                  if (NOT (${pos} MATCHES "-1"))
                    MATH(EXPR pos "${pos}+1")
                    string(SUBSTRING ${line} ${pos} -1 ADDON_CPPFLAG)
                    string(STRIP ${ADDON_CPPFLAG} ADDON_CPPFLAG)
                    list(APPEND ADDON_CPPFLAGS ${ADDON_CPPFLAG})
                  endif()
                elseif (${line} MATCHES "ADDON_CFLAGS")
                  string(FIND ${line} "=" pos)
                  if (NOT (${pos} MATCHES "-1"))
                    MATH(EXPR pos "${pos}+1")
                    string(SUBSTRING ${line} ${pos} -1 ADDON_CFLAG)
                    string(STRIP ${ADDON_CFLAG} ADDON_CFLAG)
                    list(APPEND ADDON_CFLAGS ${ADDON_CFLAG})
                  endif()
                elseif (${line} MATCHES "ADDON_LDFLAGS")
                  string(FIND ${line} "=" pos)
                  if (NOT (${pos} MATCHES "-1"))
                    MATH(EXPR pos "${pos}+1")
                    string(SUBSTRING ${line} ${pos} -1 ADDON_LDFLAG)
                    string(STRIP ${ADDON_LDFLAG} ADDON_LDFLAG)
                    list(APPEND ADDON_LDFLAGS ${ADDON_LDFLAG})
                  endif()
                elseif (${line} MATCHES "ADDON_LIBS")
                  string(FIND ${line} "=" pos)
                  if (NOT (${pos} MATCHES "-1"))
                    MATH(EXPR pos "${pos}+1")
                    string(SUBSTRING ${line} ${pos} -1 ADDON_LIB)
                    string(STRIP ${ADDON_LIB} ADDON_LIB)
                    list(APPEND ADDON_LIBS ${OFXADDON_DIR}/${ADDON_LIB})
                  endif()
                endif()
              endif()
            endforeach(line)
                            # ADDON_DESCRIPTION
                            # ADDON_AUTHOR
                            # ADDON_TAGS
                            # ADDON_URL
                            # ADDON_PKG_CONFIG_LIBRARIES
                            # ADDON_FRAMEWORKS
                            # ADDON_SOURCES
                            # ADDON_DATA
                            # ADDON_LIBS_EXCLUDE

            endif()

            if(NOT (EXISTS "${OFXADDON_DIR}/src/"))
                message(WARNING "ofxaddon(${OFXADDON_DIR}): the addon doesn't have src subfolder.")
            endif()

            file(GLOB_RECURSE OFXSOURCES
                "${OFXADDON_DIR}/src/*.c"
                "${OFXADDON_DIR}/src/*.cc"
                "${OFXADDON_DIR}/src/*.cpp"
                "${OFXADDON_DIR}/libs/*.c"
                "${OFXADDON_DIR}/libs/*.cc"
                "${OFXADDON_DIR}/libs/*.cpp"
                )

            # Exclude sources
            set(TMP)
            foreach(SRC ${OFXSOURCES})
                set(KEEP 1)
                foreach(EXC ${ADDON_SOURCES_EXCLUDE})
                    if("${SRC}" MATCHES "^${OFXADDON_DIR}/${EXC}")
                        set(KEEP 0)
                    endif()
                endforeach()
                if(${KEEP})
                    list(APPEND TMP ${SRC})
                endif()
            endforeach()
            set(OFXSOURCES ${TMP})

            FILE(GLOB_RECURSE OFXLIBSINCLUDEDIRS LIST_DIRECTORIES true "${OFXADDON_DIR}/libs/*")
            foreach(OFXLIBHEADER_PATH ${OFXLIBSINCLUDEDIRS})
                if(IS_DIRECTORY "${OFXLIBHEADER_PATH}")
                    string(FIND "${OFXLIBHEADER_PATH}" "include" POS REVERSE)
                    string(LENGTH "${OFXLIBHEADER_PATH}" LEN)
                    math(EXPR POS2 "${LEN}-7")
                    if(POS EQUAL POS2)
                        list(APPEND OFXLIBHEADER_PATHS "${OFXLIBHEADER_PATH}/")
                    endif()
                endif()
            endforeach()

        # Exclude includes
        set(TMP)
        foreach(SRC ${OFXLIBHEADER_PATHS})
          set(KEEP 1)
          foreach(EXC ${ADDON_INCLUDES_EXCLUDE})
            if("${SRC}" MATCHES "^${OFXADDON_DIR}/${EXC}")
              set(KEEP 0)
            endif()
          endforeach()
          if(${KEEP})
            list(APPEND TMP ${SRC})
          endif()
        endforeach()
        set(OFXLIBHEADER_PATHS ${TMP})

        if (OFXLIBHEADER_PATHS)
          include_directories("${OFXLIBHEADER_PATHS}")
        endif()

        if ( ADDON_LIBS )
            set(OPENFRAMEWORKS_LIBRARIES ${OPENFRAMEWORKS_LIBRARIES} ${ADDON_LIBS} PARENT_SCOPE)
        endif()

        SET( CMAKE_C_FLAGS  "${CMAKE_C_FLAGS} ${ADDON_CFLAGS}" PARENT_SCOPE)
        SET( CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} ${ADDON_CPPFLAGS}" PARENT_SCOPE)
        SET( CMAKE_EXE_LINKER_FLAGS  "${CMAKE_EXE_LINKER_FLAGS} ${ADDON_LDFLAGS}" PARENT_SCOPE)

        include_directories("${OFXADDON_DIR}/src")
        include_directories("${OFXADDON_DIR}/libs")

        message(STATUS "ADDON_NAME: ${ADDON_NAME}")
        message(STATUS "ADDON_INCLUDES: ${ADDON_INCLUDES}")
        message(STATUS "SOURCES: ${OFXSOURCES}")
        message(STATUS "OFXLIBHEADER_PATHS: ${OFXLIBHEADER_PATHS}")
        message(STATUS "ADDON_DEPENDENCIES: ${ADDON_DEPENDENCIES}")
        message(STATUS "ADDON_INCLUDES_EXCLUDE: ${ADDON_INCLUDES_EXCLUDE}")
        message(STATUS "ADDON_SOURCES_EXCLUDE: ${ADDON_SOURCES_EXCLUDE}")
        message(STATUS "ADDON_CFLAGS: ${ADDON_CFLAGS}")
        message(STATUS "ADDON_CPPFLAGS: ${ADDON_CPPFLAGS}")
        message(STATUS "ADDON_LDFLAGS: ${ADDON_LDFLAGS}")
        message(STATUS "ADDON_LIBS: ${ADDON_LIBS}")

        foreach(ADDON ${ADDON_DEPENDENCIES})
          list(REMOVE_ITEM ADDON_DEPENDENCIES ${ADDON})
          ofxaddon(${ADDON})
        endforeach()

    endif()

    if(OFXSOURCES)
        set(OFXADDONS_SOURCES ${OFXADDONS_SOURCES} ${OFXSOURCES} PARENT_SCOPE)
    endif()

endfunction(ofxaddon)

#// Misc ///////////////////////////////////////////////////////////////////////

if(OF_COTIRE)
    include(cotire)
    set(COTIRE_MINIMUM_NUMBER_OF_TARGET_SOURCES 1)
    set_directory_properties(PROPERTIES COTIRE_ADD_UNITY_BUILD FALSE)
    set(CMAKE_SUPPRESS_DEVELOPER_WARNINGS 1 CACHE INTERNAL "")
else()
    function(cotire NO)
    endfunction(cotire)
endif()

MACRO(ofSetTargetProperties)
  if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/Info.plist")
    set_target_properties(
        ${PROJECT_NAME} PROPERTIES
        MACOSX_BUNDLE_INFO_PLIST
        "${CMAKE_CURRENT_SOURCE_DIR}/Info.plist"
    )
  elseif(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/openFrameworks-Info.plist")
    set_target_properties(
        ${PROJECT_NAME} PROPERTIES
        MACOSX_BUNDLE_INFO_PLIST
        "${CMAKE_CURRENT_SOURCE_DIR}/openFrameworks-Info.plist"
    )
  endif()

  if(CMAKE_BUILD_TYPE MATCHES Debug)
      set_target_properties( ${PROJECT_NAME} PROPERTIES OUTPUT_NAME "${PROJECT_NAME}-Debug")
  endif()

  if (CMAKE_CROSSCOMPILING)
      set_target_properties( ${PROJECT_NAME} PROPERTIES OUTPUT_NAME
        "${PROJECT_NAME}-${TARGET_ARCH}-${CMAKE_BUILD_TYPE}")
  endif()

  if(OF_COTIRE)
    cotire(${PROJECT_NAME})
  endif()
ENDMACRO()

#// Messages ///////////////////////////////////////////////////////////////////

message(STATUS "TARGET_ARCH: ${TARGET_ARCH} ${ARCH_BIT}bit")
message(STATUS "OF_COTIRE: " ${OF_COTIRE})
message(STATUS "OF_STATIC: " ${OF_STATIC})

if(CMAKE_SYSTEM MATCHES Linux)
message(STATUS "OF_AUDIO: " ${OF_AUDIO})
message(STATUS "OF_VIDEO: " ${OF_VIDEO})
message(STATUS "OF_GTK: " ${OF_GTK})
message(STATUS "OF_GTK2: " ${OF_GTK2})
endif()

if(CMAKE_SYSTEM MATCHES Windows)
message(STATUS "OF_CONSOLE: " ${OF_CONSOLE})
endif()

message(STATUS "CMAKE_BUILD_TYPE: "      ${CMAKE_BUILD_TYPE})
message(STATUS "CMAKE_C_COMPILER_ID: "   ${CMAKE_C_COMPILER_ID})
message(STATUS "CMAKE_CXX_COMPILER_ID: " ${CMAKE_CXX_COMPILER_ID})

message(STATUS "OPENFRAMEWORKS_LIBRARIES : ${OPENFRAMEWORKS_LIBRARIES}")
