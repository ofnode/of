if(NOT DEFINED CMAKE_MACOSX_RPATH)
  set(CMAKE_MACOSX_RPATH 0)
endif()

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

set(OPENFRAMEWORKS_INCLUDE_DIRS
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

find_package(Boost COMPONENTS filesystem system REQUIRED)
list(APPEND OPENFRAMEWORKS_INCLUDE_DIRS
    ${Boost_INCLUDE_DIRS}
)
list(APPEND OPENFRAMEWORKS_LIBRARIES
    ${Boost_SYSTEM_LIBRARY}
    ${Boost_FILESYSTEM_LIBRARY}
)
message(STATUS "Boost include dir ${Boost_INCLUDE_DIRS}")