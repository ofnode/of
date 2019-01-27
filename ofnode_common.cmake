if(NOT DEFINED CMAKE_MACOSX_RPATH)
  set(CMAKE_MACOSX_RPATH 0)
endif()

# "${CMAKE_SYSROOT}/usr/include" is not added to include directories
# see https://gitlab.kitware.com/cmake/cmake/issues/17966
# and it seems to be a bug in crosscompiler
# see https://github.com/abhiTronix/raspberry-pi-cross-compilers/issues/3
unset(CMAKE_C_IMPLICIT_INCLUDE_DIRECTORIES)
unset(CMAKE_CXX_IMPLICIT_INCLUDE_DIRECTORIES)

set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/dev/cmake")
set(OF_STATIC OFF CACHE BOOL "Link openFrameworks libraries statically")

#// Options ////////////////////////////////////////////////////////////////////
if(CMAKE_SYSTEM MATCHES Linux)

  set(OF_AUDIO  ON  CACHE BOOL "Compile audio features of openFrameworks")
  set(OF_VIDEO  ON  CACHE BOOL "Compile video features of openFrameworks")
  set(OF_GTK    ON  CACHE BOOL "Compile with GTK3 (may conficts with Qt).")
  set(OF_GTK2   OFF CACHE BOOL "Compile with GTK2.")

elseif(CMAKE_SYSTEM MATCHES Darwin)

  set(OF_AUDIO ON) # Do not turn off
  set(OF_VIDEO ON) # Do not turn off

elseif(CMAKE_SYSTEM MATCHES Windows)

  set(OF_AUDIO ON) # Do not turn off
  set(OF_VIDEO ON) # Do not turn off

  set(OF_32BIT OFF CACHE BOOL "Compile for 32-bit architectures")

endif()

set(RELEASE_FLAGS "
  -Wno-narrowing
  -Wno-deprecated-declarations
 ")

set(DEBUG_FLAGS "
  -fno-omit-frame-pointer
  -fno-optimize-sibling-calls
")

#// GCC specific flags /////////////////////////////////////////////////////////

if(CMAKE_C_COMPILER_ID STREQUAL GNU)

  set(RELEASE_C_FLAGS_GCC
    -Wno-psabi
  )

  set(DEBUG_C_FLAGS_GCC
    -Wno-psabi
  )

endif()

if(CMAKE_CXX_COMPILER_ID STREQUAL GNU)

  set(RELEASE_CXX_FLAGS_GCC 
    -Wno-psabi
  )

  set(DEBUG_CXX_FLAGS_GCC
    -Wno-psabi
  )

endif()

#// Clang specific flags ///////////////////////////////////////////////////////

if(CMAKE_C_COMPILER_ID STREQUAL Clang)

  set(RELEASE_C_FLAGS_CLANG
    -Wno-switch
    -Wno-ignored-attributes
    -Wno-deprecated-register
  )

  set(DEBUG_C_FLAGS_CLANG
    -Wno-switch
    -Wno-ignored-attributes
    -Wno-deprecated-register
  )

endif()

if(CMAKE_CXX_COMPILER_ID STREQUAL Clang)

  set(RELEASE_CXX_FLAGS_CLANG
    -Wno-switch
    -Wno-ignored-attributes
    -Wno-deprecated-register
  )

  set(DEBUG_CXX_FLAGS_CLANG
    -Wno-switch
    -Wno-ignored-attributes
    -Wno-deprecated-register
  )

endif()

#// Setup //////////////////////////////////////////////////////////////////////

set(OF_ROOT_DIR ${CMAKE_CURRENT_LIST_DIR})

if(NOT CMAKE_BUILD_TYPE)
   set(CMAKE_BUILD_TYPE Release)
endif()

find_package(PkgConfig REQUIRED)

include(TargetArch)
target_architecture(TARGET_ARCH)

if( ( TARGET_ARCH MATCHES "x86_64" OR TARGET_ARCH MATCHES "ia64" ) AND NOT OF_32BIT)
   set(ARCH_BIT 64)
else()
   set(ARCH_BIT 32)
endif()

#// Include directories ////////////////////////////////////////////////////////

list(APPEND OPENFRAMEWORKS_INCLUDE_DIRS
	"${OF_ROOT_DIR}/src/fmodex/include"

	"${OF_ROOT_DIR}/src/glm/include"

	"${OF_ROOT_DIR}/src/json/include"

  "${OF_ROOT_DIR}/src/openframeworks"
  "${OF_ROOT_DIR}/src/openframeworks/3d"
  "${OF_ROOT_DIR}/src/openframeworks/app"
  "${OF_ROOT_DIR}/src/openframeworks/communication"
  "${OF_ROOT_DIR}/src/openframeworks/events"
  "${OF_ROOT_DIR}/src/openframeworks/gl"
  "${OF_ROOT_DIR}/src/openframeworks/graphics"
  "${OF_ROOT_DIR}/src/openframeworks/math"
  "${OF_ROOT_DIR}/src/openframeworks/sound"
  "${OF_ROOT_DIR}/src/openframeworks/types"
  "${OF_ROOT_DIR}/src/openframeworks/utils"
  "${OF_ROOT_DIR}/src/openframeworks/video"

  "${OF_ROOT_DIR}/src/kissfft"
  "${OF_ROOT_DIR}/src/kissfft/tools"

  "${OF_ROOT_DIR}/src/libtess2/Include"

  "${OF_ROOT_DIR}/src/utf8/include"

  "${OF_ROOT_DIR}/src/glm"

  "${OF_ROOT_DIR}/src/rtaudio"

  "${OF_ROOT_DIR}/src/libjasper"
)

if(CMAKE_SYSTEM MATCHES Windows)
  list(APPEND OPENFRAMEWORKS_INCLUDE_DIRS
    "${OF_ROOT_DIR}/src/videoinput"
  )
endif()

if(OF_STATIC)
  set(Boost_USE_STATIC_LIBS ON)
endif()


if(CMAKE_SYSTEM MATCHES Linux)

  set(OPENFRAMEWORKS_DEFINITIONS
      -DOF_USING_MPG123
      -DOF_SOUND_PLAYER_OPENAL
      -DOF_SOUNDSTREAM_RTAUDIO
      -DOF_VIDEO_PLAYER_GSTREAMER
      -DOF_VIDEO_CAPTURE_GSTREAMER
  )

 if(TARGET_ARCH MATCHES arm*)
    # add /opt/vc... to pkgconfig search path
    SET(ENV{PKG_CONFIG_LIBDIR} "${CMAKE_SYSROOT}/usr/lib/arm-linux-gnueabihf/pkgconfig:${CMAKE_SYSROOT}/usr/lib/pkgconfig:${CMAKE_SYSROOT}/usr/share/pkgconfig:${CMAKE_SYSROOT}/opt/vc/lib/pkgconfig")
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
      -DUSE_VCHIQ_ARM
    )

    pkg_check_modules(BCMHOST REQUIRED bcm_host)

    list(APPEND OPENFRAMEWORKS_DEFINITIONS
        -DHAVE_LIBBCM_HOST
        -DUSE_EXTERNAL_LIBBCM_HOST
    ) 

    message(STATUS "BCM include dir ${BCMHOST_INCLUDE_DIRS}")
    message(STATUS "BCM lib ${BCMHOST_LIBRARIES}")

    list(APPEND OPENFRAMEWORKS_INCLUDE_DIRS
              ${BCMHOST_INCLUDE_DIRS}
    )
    
    list(APPEND OPENFRAMEWORKS_LIBRARIES
      ${BCMHOST_LIBRARIES}
    )

    link_directories(${CMAKE_SYSROOT}/opt/vc/lib)
  endif()

  pkg_check_modules(CURL REQUIRED libcurl)
  pkg_check_modules(GLEW REQUIRED glew)

  find_package(Boost COMPONENTS filesystem system REQUIRED)
  find_package(FreeImage REQUIRED)

  set(UTF8_INCLUDE_DIRS ${CMAKE_CURRENT_LIST_DIR}/src/utf8cpp/include)
  set(JSON_INCLUDE_DIRS ${CMAKE_CURRENT_LIST_DIR}/src/json/include)

  list(APPEND OPENFRAMEWORKS_INCLUDE_DIRS
      ${Boost_INCLUDE_DIRS}
      ${CURL_INCLUDE_DIRS}
      ${GLEW_INCLUDE_DIRS}
      ${FREEIMAGE_INCLUDE_PATH}
      ${UTF8_INCLUDE_DIRS}
      ${JSON_INCLUDE_DIRS}
  )
  list(APPEND OPENFRAMEWORKS_LIBRARIES
      ${Boost_SYSTEM_LIBRARY}
      ${Boost_FILESYSTEM_LIBRARY}
      ${CURL_LIBRARIES}
      ${GLEW_LIBRARIES}
      ${FREEIMAGE_LIBRARIES}
  )
  message(STATUS "Boost include dir ${Boost_INCLUDE_DIRS}")
  message(STATUS "Glew lib : ${GLEW_LIBRARIES}")

endif()
