list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/dev/cmake")

#// MSVC flags /////////////////////////////////////////////////////////////////

if(MSVC)

    set(RELEASE_FLAGS "
      ${RELEASE_FLAGS}
    ")

    set(DEBUG_FLAGS "
      ${DEBUG_FLAGS}
    ")

else()

#// GCC and Clang flags ////////////////////////////////////////////////////////

    set(RELEASE_FLAGS "
      ${RELEASE_FLAGS}
        -g
    ")

    set(DEBUG_FLAGS "
      ${DEBUG_FLAGS}
        -Winline
        -fno-omit-frame-pointer
        -fno-optimize-sibling-calls
    ")

#// Clang specific C flags /////////////////////////////////////////////////////

  if(CMAKE_C_COMPILER_ID STREQUAL Clang)

    set(RELEASE_C_FLAGS_CLANG "
      ${RELEASE_C_FLAGS_CLANG}
        -Wno-switch
        -Wno-deprecated-register
    ")

    set(DEBUG_C_FLAGS_CLANG "
      ${DEBUG_C_FLAGS_CLANG}
        -Wno-switch
        -Wno-deprecated-register
    ")

  endif()

#// Clang specific C++ flags ///////////////////////////////////////////////////

  if(CMAKE_CXX_COMPILER_ID STREQUAL Clang)

    set(RELEASE_CXX_FLAGS_CLANG "
      ${RELEASE_CXX_FLAGS_CLANG}
        -Wno-switch
        -Wno-deprecated-register
    ")

    set(DEBUG_CXX_FLAGS_CLANG "
      ${DEBUG_CXX_FLAGS_CLANG}
        -Wno-switch
        -Wno-deprecated-register
    ")

  endif()

#///////////////////////////////////////////////////////////////////////////////

endif()

#// Options ////////////////////////////////////////////////////////////////////

set(OF_ENABLE_COTIRE ON CACHE BOOL
   "Enable Cotire header precompiler")

if(CMAKE_SYSTEM MATCHES Linux)

  set(OF_ENABLE_AUDIO ON CACHE BOOL
     "Enable audio features of openFrameworks on Linux")

  set(OF_ENABLE_VIDEO ON CACHE BOOL
     "Enable video features of openFrameworks on Linux")

elseif(CMAKE_SYSTEM MATCHES Windows)

  set(OF_ENABLE_CONSOLE OFF CACHE BOOL
     "Enable console window on Windows")

endif()

#// Setup //////////////////////////////////////////////////////////////////////

set(OF_ROOT_DIR ${CMAKE_CURRENT_LIST_DIR})

find_package(PkgConfig REQUIRED)

if(NOT CMAKE_BUILD_TYPE)
   set(CMAKE_BUILD_TYPE Release)
endif()

# Output shared libraries and executables to bin folder of your project tree
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE "${CMAKE_CURRENT_SOURCE_DIR}/bin")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE "${CMAKE_CURRENT_SOURCE_DIR}/bin")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG   "${CMAKE_CURRENT_SOURCE_DIR}/bin")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG   "${CMAKE_CURRENT_SOURCE_DIR}/bin")

set(OPENFRAMEWORKS_INCLUDE_DIRS
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

    "${OF_ROOT_DIR}/src/freeimage"
    "${OF_ROOT_DIR}/src/freeimage/OpenEXR"
    "${OF_ROOT_DIR}/src/freeimage/OpenEXR/Half"
    "${OF_ROOT_DIR}/src/freeimage/OpenEXR/Iex"
    "${OF_ROOT_DIR}/src/freeimage/OpenEXR/IlmImf"
    "${OF_ROOT_DIR}/src/freeimage/OpenEXR/IlmThread"
    "${OF_ROOT_DIR}/src/freeimage/OpenEXR/Imath"

    "${OF_ROOT_DIR}/src/glew"
    "${OF_ROOT_DIR}/src/glew/include"

    "${OF_ROOT_DIR}/src/glfw"
    "${OF_ROOT_DIR}/src/glfw/include"
    "${OF_ROOT_DIR}/src/glfw/include/GLFW"

    "${OF_ROOT_DIR}/src/kiss"
    "${OF_ROOT_DIR}/src/kiss/src"
    "${OF_ROOT_DIR}/src/kiss/tools"

    "${OF_ROOT_DIR}/src/libtess2"
    "${OF_ROOT_DIR}/src/libtess2/Include"
    "${OF_ROOT_DIR}/src/libtess2/Source"

    "${OF_ROOT_DIR}/src/poco"
    "${OF_ROOT_DIR}/src/poco/Crypto/include"
    "${OF_ROOT_DIR}/src/poco/Foundation/include"
    "${OF_ROOT_DIR}/src/poco/Net/include"
    "${OF_ROOT_DIR}/src/poco/NetSSL_OpenSSL/include"
    "${OF_ROOT_DIR}/src/poco/Util/include"
    "${OF_ROOT_DIR}/src/poco/XML/include"
    "${OF_ROOT_DIR}/src/poco/Zip/include"

    "${OF_ROOT_DIR}/src/rtaudio"
    "${OF_ROOT_DIR}/src/rtaudio/include"

    "${OF_ROOT_DIR}/src/utf8cpp"
    "${OF_ROOT_DIR}/src/utf8cpp/include"
)

if(CMAKE_SYSTEM MATCHES Windows)
list(APPEND OPENFRAMEWORKS_INCLUDE_DIRS
    "${OF_ROOT_DIR}/src/videoinput"
)
endif()

if(MSVC)
list(APPEND OPENFRAMEWORKS_INCLUDE_DIRS
    "${OF_ROOT_DIR}/dev/include/msvc"
)
endif()

#// Platform-specific commands /////////////////////////////////////////////////

if(CMAKE_SYSTEM MATCHES Linux)

    set(OPENFRAMEWORKS_DEFINITIONS
        -DOF_USING_MPG123
        -DOF_SOUND_PLAYER_OPENAL
        -DOF_SOUNDSTREAM_RTAUDIO
        -DOF_VIDEO_PLAYER_GSTREAMER
        -DOF_VIDEO_CAPTURE_GSTREAMER
    )

    #// Local dependencies /////////////////////////////////////////////////////

    # The folder of executable will be
    # search path for shared libraries
    set(OPENFRAMEWORKS_LIBRARIES
        -Wl,-rpath,'$$ORIGIN'
    )

    if(CMAKE_BUILD_TYPE MATCHES Release)
        set(OF_LIB_DIR "${OF_ROOT_DIR}/lib-linux/release")
    elseif(CMAKE_BUILD_TYPE MATCHES Debug)
        set(OF_LIB_DIR "${OF_ROOT_DIR}/lib-linux/debug")
    endif()

    list(APPEND OPENFRAMEWORKS_LIBRARIES -L"${OF_LIB_DIR}")
    file(GLOB_RECURSE OPENFRAMEWORKS_LIBS  "${OF_LIB_DIR}/*.a")

    if(NOT OPENFRAMEWORKS_LIBS)
        message(FATAL_ERROR "No openFrameworks libraries found in ${OF_LIB_DIR} folder.")
    endif()

    list(APPEND OPENFRAMEWORKS_LIBRARIES
        -Wl,-Bstatic
        -Wl,--start-group
        ${OPENFRAMEWORKS_LIBS}
        -Wl,--end-group
        -Wl,-Bdynamic
    )

    #// Global dependencies ////////////////////////////////////////////////////

    set(Boost_USE_STATIC_LIBS ON)

    find_package(X11 REQUIRED)
    find_package(ZLIB REQUIRED)
    find_package(Cairo REQUIRED)
    find_package(OpenGL REQUIRED)
    find_package(OpenSSL REQUIRED)
    find_package(Threads REQUIRED)
    find_package(Freetype REQUIRED)
    find_package(Fontconfig REQUIRED)
    find_package(Boost COMPONENTS filesystem system REQUIRED)

    set(STATIC_LIB_PATHS
        "/usr/lib/x86_64-linux-gnu"
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

    if(FREETYPE_LIB MATCHES FREETYPE_LIB-NOTFOUND)
      message(STATUS "Using dynamic FreeType")
    else()
      message(STATUS "Using static FreeType")
      set(FREETYPE_LIBRARIES
        ${FREETYPE_LIB}
      )
    endif()

    if(FONTCONFIG_LIB MATCHES FONTCONFIG_LIB-NOTFOUND)
      message(STATUS "Using dynamic Fontconfig")
    else()
      message(STATUS "Using static Fontconfig")
      set(FONTCONFIG_LIBRARIES
        ${FONTCONFIG_LIB}
      )
    endif()

    list(APPEND OPENFRAMEWORKS_DEFINITIONS
        ${FONTCONFIG_DEFINITIONS}
    )

    list(APPEND OPENFRAMEWORKS_INCLUDE_DIRS
        ${X11_INCLUDE_DIR}
        ${ZLIB_INCLUDE_DIRS}
        ${CAIRO_INCLUDE_DIR}
        ${Boost_INCLUDE_DIRS}
        ${OPENGL_INCLUDE_DIR}
        ${OPENSSL_INCLUDE_DIR}
        ${FREETYPE_INCLUDE_DIRS}
        ${FONTCONFIG_INCLUDE_DIR}
    )

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
        ${Boost_SYSTEM_LIBRARY}
        ${Boost_FILESYSTEM_LIBRARY}
        ${CMAKE_THREAD_LIBS_INIT}
    )

    if(NOT OF_ENABLE_AUDIO)
      list(APPEND OPENFRAMEWORKS_DEFINITIONS
        -DTARGET_NO_SOUND
      )
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

    if(NOT OF_ENABLE_VIDEO)
      list(APPEND OPENFRAMEWORKS_DEFINITIONS
        -DTARGET_NO_VIDEO
      )
    else()
      list(APPEND OPENFRAMEWORKS_DEFINITIONS
        -DOF_USING_GTK
      )

      find_package(UDev REQUIRED)
      find_package(Glib REQUIRED)
      find_package(GStreamer REQUIRED)
      pkg_check_modules(GTK3 REQUIRED gtk+-3.0)

      list(APPEND OPENFRAMEWORKS_INCLUDE_DIRS
        ${UDEV_INCLUDE_DIR}
        ${GLIB_INCLUDE_DIRS}
        ${GTK3_INCLUDE_DIRS}
        ${GSTREAMER_INCLUDE_DIRS}
      )

      list(APPEND OPENFRAMEWORKS_LIBRARIES
        ${UDEV_LIBRARIES}
        ${GLIB_LIBRARIES}
        ${GTK3_LIBRARIES}
        ${GSTREAMER_LIBRARIES}
        ${GSTREAMER_APP_LIBRARIES}
        ${GSTREAMER_BASE_LIBRARIES}
        ${GSTREAMER_VIDEO_LIBRARIES}
      )
    endif()

elseif(CMAKE_SYSTEM MATCHES Darwin)

    message("OS X support is experimental. Please report issues if you run into something.")

    set(OPENFRAMEWORKS_DEFINITIONS
        -D__MACOSX_CORE__
        -DOF_SOUND_PLAYER_OPENAL
        -DOF_SOUNDSTREAM_RTAUDIO
    )

    #// Local dependencies /////////////////////////////////////////////////////

    if(CMAKE_BUILD_TYPE MATCHES Release)
        set(OF_LIB_DIR "${OF_ROOT_DIR}/lib-osx/release")
    elseif(CMAKE_BUILD_TYPE MATCHES Debug)
        set(OF_LIB_DIR "${OF_ROOT_DIR}/lib-osx/debug")
    endif()

    set(OPENFRAMEWORKS_LIBRARIES -L"${OF_LIB_DIR}")
    file(GLOB_RECURSE OPENFRAMEWORKS_LIBS "${OF_LIB_DIR}/*.a")

    if(NOT OPENFRAMEWORKS_LIBS)
        message(FATAL_ERROR "No openFrameworks libraries found in ${OF_LIB_DIR} folder.")
    endif()

    list(APPEND OPENFRAMEWORKS_LIBRARIES
        ${OPENFRAMEWORKS_LIBS}
    )

    #// Global dependencies ////////////////////////////////////////////////////

    find_package(ZLIB REQUIRED)
    find_package(Cairo REQUIRED)
    find_package(OpenAL REQUIRED) # Should be provided by CoreAudio
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

    list(APPEND OPENFRAMEWORKS_INCLUDE_DIRS
        ${GLIB_INCLUDE_DIRS}
        ${ZLIB_INCLUDE_DIRS}
        ${CAIRO_INCLUDE_DIR}
        ${OPENAL_INCLUDE_DIR}
        ${OPENGL_INCLUDE_DIR}
        ${OPENSSL_INCLUDE_DIR}
        ${SNDFILE_INCLUDE_DIR}
        ${FREETYPE_INCLUDE_DIRS}
    )

    list(APPEND OPENFRAMEWORKS_LIBRARIES
        ${GLIB_LIBRARIES}
        ${ZLIB_LIBRARIES}
        ${OPENAL_LIBRARY}
        ${CAIRO_LIBRARIES}
        ${OPENGL_LIBRARIES}
        ${OPENSSL_LIBRARIES}
        ${SNDFILE_LIBRARIES}
        ${FREETYPE_LIBRARIES}
        ${FONTCONFIG_LIBRARIES}
    )

    # Frameworks
    list(APPEND OPENFRAMEWORKS_LIBRARIES
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
        set(OF_LIB_DIR "${OF_ROOT_DIR}/lib-windows/release")
    elseif(CMAKE_BUILD_TYPE MATCHES Debug)
        set(OF_LIB_DIR "${OF_ROOT_DIR}/lib-windows/debug")
    endif()

    if(MSVC)
        link_directories(${OF_LIB_DIR})
        file(GLOB_RECURSE OPENFRAMEWORKS_LIBS "${OF_LIB_DIR}/*.lib")
    else()
        set(OPENFRAMEWORKS_LIBRARIES -L"${OF_LIB_DIR}")
        file(GLOB_RECURSE OPENFRAMEWORKS_LIBS "${OF_LIB_DIR}/*.a")
    endif()

    if(NOT OPENFRAMEWORKS_LIBS)
        message(FATAL_ERROR "No openFrameworks libraries found in ${OF_LIB_DIR} folder.")
    endif()

    # Hide console by default
    if(NOT OF_ENABLE_CONSOLE)
      if(MSVC)
        set(CMAKE_EXE_LINKER_FLAGS
         "${CMAKE_EXE_LINKER_FLAGS} /SUBSYSTEM:windows /ENTRY:mainCRTStartup")
      else()
        list(APPEND OPENFRAMEWORKS_LIBRARIES
            -mwindows
        )
      endif()
    endif()

    # If we are on Windows using MSVC
    # we don't need GCC's link groups
    if(MSVC)
      set(OPENFRAMEWORKS_LIBRARIES
        ${OPENFRAMEWORKS_LIBS}
      )
    else()
      list(APPEND OPENFRAMEWORKS_LIBRARIES
        -Wl,-Bstatic
        -Wl,--start-group
        ${OPENFRAMEWORKS_LIBS}
        -Wl,--end-group
        -Wl,-Bdynamic
      )
    endif()

    #// Global dependencies ////////////////////////////////////////////////////

    find_package(ZLIB REQUIRED)
    find_package(BZip2 REQUIRED)
    find_package(Cairo REQUIRED)
    find_package(OpenAL REQUIRED)
    find_package(OpenGL REQUIRED)
    find_package(MPG123 REQUIRED)
    find_package(Pixman REQUIRED)
    find_package(OpenSSL REQUIRED)
    find_package(Sndfile REQUIRED)
    find_package(Threads REQUIRED)
    find_package(LibIntl REQUIRED)
    find_package(Freetype REQUIRED)
    find_package(Fontconfig REQUIRED)

    if(MSVC)
      set(MSVC_PATHS
        "C:/Program Files (x86)/Microsoft SDKs/Windows/v7.1A/Lib/x64"
      )
    endif()

    find_library(WINMM_LIB winmm PATHS ${MSVC_PATHS})
    find_library(GDI32_LIB gdi32 PATHS ${MSVC_PATHS})
    find_library(DSOUND_LIB dsound PATHS ${MSVC_PATHS})
    find_library(WS2_32_LIB ws2_32 PATHS ${MSVC_PATHS})
    find_library(CRYPT32_LIB crypt32 PATHS ${MSVC_PATHS})
    find_library(WSOCK32_LIB wsock32 PATHS ${MSVC_PATHS})
    find_library(IPHLPAPI_LIB iphlpapi PATHS ${MSVC_PATHS})
    find_library(STRMIIDS_LIB strmiids PATHS ${MSVC_PATHS})
    find_library(SETUPAPI_LIB setupapi PATHS ${MSVC_PATHS})

    list(APPEND OPENFRAMEWORKS_DEFINITIONS
        ${FONTCONFIG_DEFINITIONS}
    )

    list(APPEND OPENFRAMEWORKS_INCLUDE_DIRS
        ${ZLIB_INCLUDE_DIRS}
        ${BZIP2_INCLUDE_DIR}
        ${CAIRO_INCLUDE_DIR}
        ${OPENAL_INCLUDE_DIR}
        ${OPENGL_INCLUDE_DIR}
        ${MPG123_INCLUDE_DIRS}
        ${PIXMAN_INCLUDE_DIRS}
        ${OPENSSL_INCLUDE_DIR}
        ${SNDFILE_INCLUDE_DIR}
        ${LIBINTL_INCLUDE_DIR}
        ${FREETYPE_INCLUDE_DIRS}
        ${FONTCONFIG_INCLUDE_DIR}
    )

    list(APPEND OPENFRAMEWORKS_LIBRARIES
        ${OPENAL_LIBRARY}
        ${ZLIB_LIBRARIES}
        ${BZIP2_LIBRARIES}
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
        ${STRMIIDS_LIB}
        ${SETUPAPI_LIB}
    )

endif()

#// Compiler flags /////////////////////////////////////////////////////////////

list(APPEND OPENFRAMEWORKS_DEFINITIONS
    -DFREEIMAGE_LIB
    -DPOCO_STATIC
)

if(MSVC)
list(APPEND OPENFRAMEWORKS_DEFINITIONS
    -D_SCL_SECURE_NO_WARNINGS
    -D_CRT_SECURE_NO_WARNINGS
    -D_WIN32_WINNT=0x0501
    -D_UNICODE -DUNICODE
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

if(CMAKE_SYSTEM MATCHES Linux)
    set(PIC_FLAG -fPIC)
endif()

if(NOT MSVC)
    set(CPP11_FLAG -std=gnu++11)
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
endif()
if(CMAKE_CXX_COMPILER_ID STREQUAL Clang)
string(REPLACE "\n" " " RELEASE_CXX_FLAGS_CLANG ${RELEASE_CXX_FLAGS_CLANG})
string(REPLACE "\n" " "   DEBUG_CXX_FLAGS_CLANG   ${DEBUG_CXX_FLAGS_CLANG})
endif()

string(REGEX REPLACE " +" " " CMAKE_C_FLAGS_RELEASE "${C_COLORIZATION} ${CMAKE_C_FLAGS_RELEASE} ${RELEASE_FLAGS} ${RELEASE_C_FLAGS_CLANG} ${PIC_FLAG}")
string(REGEX REPLACE " +" " " CMAKE_C_FLAGS_DEBUG   "${C_COLORIZATION} ${CMAKE_C_FLAGS_DEBUG}     ${DEBUG_FLAGS}   ${DEBUG_C_FLAGS_CLANG} ${PIC_FLAG} ${O_C_FLAG}")

string(REGEX REPLACE " +" " " CMAKE_CXX_FLAGS_RELEASE "${CXX_COLORIZATION} ${CPP11_FLAG} ${CMAKE_CXX_FLAGS_RELEASE} ${RELEASE_FLAGS} ${RELEASE_CXX_FLAGS_CLANG} ${PIC_FLAG}")
string(REGEX REPLACE " +" " " CMAKE_CXX_FLAGS_DEBUG   "${CXX_COLORIZATION} ${CPP11_FLAG} ${CMAKE_CXX_FLAGS_DEBUG}     ${DEBUG_FLAGS}   ${DEBUG_CXX_FLAGS_CLANG} ${PIC_FLAG} ${O_CXX_FLAG}")

if(MSVC)
string(REPLACE "/MD"  "/MT"  CMAKE_C_FLAGS_RELEASE   ${CMAKE_C_FLAGS_RELEASE})
string(REPLACE "/MDd" "/MTd" CMAKE_C_FLAGS_DEBUG     ${CMAKE_C_FLAGS_DEBUG})
string(REPLACE "/MD"  "/MT"  CMAKE_CXX_FLAGS_RELEASE ${CMAKE_CXX_FLAGS_RELEASE})
string(REPLACE "/MDd" "/MTd" CMAKE_CXX_FLAGS_DEBUG   ${CMAKE_CXX_FLAGS_DEBUG})
endif()

#// ofxAddons //////////////////////////////////////////////////////////////////

function(ofxaddon OFXADDON)

    set(OFXADDON_DIR ${OFXADDON})

    if(OFXADDON STREQUAL ofx3DModelLoader)
        set(OFXADDON_DIR "${OF_ROOT_DIR}/addons/ofx3DModelLoader")
        set(OFXSOURCES
            "${OFXADDON_DIR}/src/3DS/model3DS.cpp"
            "${OFXADDON_DIR}/src/3DS/texture3DS.cpp"
            "${OFXADDON_DIR}/src/ofx3dModelLoader.cpp"
        )
        include_directories("${OFXADDON_DIR}/src")
        include_directories("${OFXADDON_DIR}/src/3DS")


    elseif(OFXADDON STREQUAL ofxAccelerometer)
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
        if(MSVC)
          # pkg-config point to a lib folder, but our lib is in bin folder
          list(APPEND ASSIMP_LIBRARY_DIRS "${ASSIMP_LIBRARY_DIRS}/../bin")
        endif()
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


    elseif(OFXADDON STREQUAL ofxMultiTouch)
        message(FATAL_ERROR "${OFXADDON} is not supported yet.")


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


    elseif(OFXADDON STREQUAL ofxProjectGenerator)
        message(FATAL_ERROR "${OFXADDON} is not supported yet.")


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

        if(NOT EXISTS "${CMAKE_CURRENT_LIST_DIR}/${OFXADDON_DIR}/")
            message(FATAL_ERROR "ofxaddon(${OFXADDON_DIR}): the folder doesn't exist.")
        endif()

        file(GLOB_RECURSE OFXHEADERS
            "${OFXADDON_DIR}/src/*.h"
            "${OFXADDON_DIR}/src/*.hh"
            "${OFXADDON_DIR}/src/*.hpp"
            "${OFXADDON_DIR}/libs/*.h"
            "${OFXADDON_DIR}/libs/*.hh"
            "${OFXADDON_DIR}/libs/*.hpp"
        )

        file(GLOB_RECURSE OFXSOURCES
            "${OFXADDON_DIR}/src/*.c"
            "${OFXADDON_DIR}/src/*.cc"
            "${OFXADDON_DIR}/src/*.cpp"
            "${OFXADDON_DIR}/libs/*.c"
            "${OFXADDON_DIR}/libs/*.cc"
            "${OFXADDON_DIR}/libs/*.cpp"
        )

        foreach(OFXHEADER_PATH ${OFXHEADERS})
            get_filename_component(OFXHEADER_DIR ${OFXHEADER_PATH} PATH)
            set(OFXHEADER_DIRS ${OFXHEADER_DIRS} ${OFXHEADER_DIR})
        endforeach()

        include_directories(${OFXHEADER_DIRS})
        include_directories("${OFXADDON_DIR}/src")
        include_directories("${OFXADDON_DIR}/libs")

    endif()

    if(OFXSOURCES)
        set(OFXADDONS_SOURCES ${OFXADDONS_SOURCES} ${OFXSOURCES} PARENT_SCOPE)
    endif()

endfunction(ofxaddon)

#// Misc ///////////////////////////////////////////////////////////////////////

if(OF_ENABLE_COTIRE)
    include(cotire)
    set(COTIRE_MINIMUM_NUMBER_OF_TARGET_SOURCES 1)
    set_directory_properties(PROPERTIES COTIRE_ADD_UNITY_BUILD FALSE)
else()
    function(cotire NO)
    endfunction(cotire)
endif()

#// Messages ///////////////////////////////////////////////////////////////////

message(STATUS "CMAKE_BUILD_TYPE: " ${CMAKE_BUILD_TYPE})

message(STATUS "CMAKE_C_COMPILER_ID: "   ${CMAKE_C_COMPILER_ID})
message(STATUS "CMAKE_CXX_COMPILER_ID: " ${CMAKE_CXX_COMPILER_ID})

message(STATUS "OF_ENABLE_COTIRE: "  ${OF_ENABLE_COTIRE})
if(CMAKE_SYSTEM MATCHES Linux)
message(STATUS "OF_ENABLE_AUDIO: "   ${OF_ENABLE_AUDIO})
message(STATUS "OF_ENABLE_VIDEO: "   ${OF_ENABLE_VIDEO})
elseif(CMAKE_SYSTEM MATCHES Windows)
message(STATUS "OF_ENABLE_CONSOLE: " ${OF_ENABLE_CONSOLE})
endif()

if(CMAKE_BUILD_TYPE MATCHES Release)
message(STATUS "CMAKE_C_FLAGS_RELEASE: "   ${CMAKE_C_FLAGS_RELEASE})
message(STATUS "CMAKE_CXX_FLAGS_RELEASE: " ${CMAKE_CXX_FLAGS_RELEASE})
elseif(CMAKE_BUILD_TYPE MATCHES Debug)
message(STATUS "CMAKE_C_FLAGS_DEBUG: "     ${CMAKE_C_FLAGS_DEBUG})
message(STATUS "CMAKE_CXX_FLAGS_DEBUG: "   ${CMAKE_CXX_FLAGS_DEBUG})
endif()

