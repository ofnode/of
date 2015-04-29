list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/dev/cmake")

#// MSVC flags /////////////////////////////////////////////////////////////////

if(MSVC)

    set(RELEASE_FLAGS "
    ")

    set(DEBUG_FLAGS "
    ")

else()

#// GCC and Clang flags ////////////////////////////////////////////////////////

    set(RELEASE_FLAGS "
    ")

    set(DEBUG_FLAGS "
        -Winline
        -fno-omit-frame-pointer
        -fno-optimize-sibling-calls
    ")

endif()

#// Clang specific C flags /////////////////////////////////////////////////////

if(CMAKE_C_COMPILER_ID STREQUAL Clang)

    set(RELEASE_C_FLAGS_CLANG "
        -Wno-deprecated-register
    ")

    set(DEBUG_C_FLAGS_CLANG "
    ")

endif()

#// Clang specific C++ flags ///////////////////////////////////////////////////

if(CMAKE_CXX_COMPILER_ID STREQUAL Clang)

    set(RELEASE_CXX_FLAGS_CLANG "
        -Wno-deprecated-register
    ")

    set(DEBUG_CXX_FLAGS_CLANG "
    ")

endif()

#// Options ////////////////////////////////////////////////////////////////////

set(OF_ENABLE_COTIRE ON CACHE BOOL
  "Enable Cotire header precompiler")

set(OF_ENABLE_CONSOLE OFF CACHE BOOL
  "Enable console window on Windows")

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

#///////////////////////////////////////////////////////////////////////////////

if(CMAKE_SYSTEM MATCHES Linux)

    set(OPENFRAMEWORKS_DEFINITIONS
        -DOF_USING_GTK
        -DOF_SOUND_PLAYER_OPENAL
        -DOF_SOUNDSTREAM_RTAUDIO
        -DOF_VIDEO_PLAYER_GSTREAMER
        -DOF_VIDEO_CAPTURE_GSTREAMER
    )

    # Static C and C++
    set(OPENFRAMEWORKS_LIBRARIES
        -static-libgcc
        -static-libstdc++
    )

    # The folder with executable will be
    # a search path for shared libraries
    list(APPEND OPENFRAMEWORKS_LIBRARIES
        -Wl,-rpath,'$$ORIGIN'
    )

    #// Local dependencies /////////////////////////////////////////////////////

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

    pkg_check_modules(GTK3 REQUIRED gtk+-3.0)

    find_library(RT_LIB rt)
    find_library(DL_LIB dl)
    find_package(X11 REQUIRED)
    find_package(UDev REQUIRED)
    find_package(Glib REQUIRED)
    find_package(ZLIB REQUIRED)
    find_package(ALSA REQUIRED)
    find_package(Cairo REQUIRED)
    find_package(OpenAL REQUIRED)
    find_package(OpenGL REQUIRED)
    find_package(OpenSSL REQUIRED)
    find_package(Sndfile REQUIRED)
    find_package(Threads REQUIRED)
    find_package(Freetype REQUIRED)
    find_package(GStreamer REQUIRED)
    find_package(Fontconfig REQUIRED)

    list(APPEND OPENFRAMEWORKS_DEFINITIONS
        ${FONTCONFIG_DEFINITIONS}
    )

    set(OPENFRAMEWORKS_INCLUDE_DIRS
        ${X11_INCLUDE_DIR}
        ${UDEV_INCLUDE_DIR}
        ${GTK3_INCLUDE_DIRS}
        ${GLIB_INCLUDE_DIRS}
        ${ZLIB_INCLUDE_DIRS}
        ${ALSA_INCLUDE_DIRS}
        ${CAIRO_INCLUDE_DIR}
        ${OPENAL_INCLUDE_DIR}
        ${OPENGL_INCLUDE_DIR}
        ${OPENSSL_INCLUDE_DIR}
        ${SNDFILE_INCLUDE_DIR}
        ${FREETYPE_INCLUDE_DIRS}
        ${GSTREAMER_INCLUDE_DIRS}
        ${FONTCONFIG_INCLUDE_DIR}
    )

    list(APPEND OPENFRAMEWORKS_LIBRARIES
        ${RT_LIB}
        ${DL_LIB}
        ${X11_Xi_LIB}
        ${X11_LIBRARIES}
        ${X11_Xrandr_LIB}
        ${X11_Xcursor_LIB}
        ${X11_Xxf86vm_LIB}
        ${X11_Xinerama_LIB}
        ${UDEV_LIBRARIES}
        ${GTK3_LIBRARIES}
        ${GLIB_LIBRARIES}
        ${ZLIB_LIBRARIES}
        ${ALSA_LIBRARIES}
        ${OPENAL_LIBRARY}
        ${CAIRO_LIBRARIES}
        ${OPENGL_LIBRARIES}
        ${OPENSSL_LIBRARIES}
        ${SNDFILE_LIBRARIES}
        ${FREETYPE_LIBRARIES}
        ${GSTREAMER_LIBRARIES}
        ${FONTCONFIG_LIBRARIES}
        ${CMAKE_THREAD_LIBS_INIT}
        ${GSTREAMER_APP_LIBRARIES}
        ${GSTREAMER_BASE_LIBRARIES}
        ${GSTREAMER_VIDEO_LIBRARIES}
    )

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

    set(OPENFRAMEWORKS_INCLUDE_DIRS
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
        -DOF_SOUNDSTREAM_RTAUDIO
        -DOF_SOUND_PLAYER_OPENAL
        -DOF_VIDEO_CAPTURE_DIRECTSHOW
        -DOF_VIDEO_PLAYER_DIRECTSHOW
    )

    if(NOT MSVC)
        # Static C and C++
        set(OPENFRAMEWORKS_LIBRARIES
            -static-libgcc
            -static-libstdc++
        )
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

    #// Local dependencies /////////////////////////////////////////////////////

    if(CMAKE_BUILD_TYPE MATCHES Release)
        set(OF_LIB_DIR "${OF_ROOT_DIR}/lib-windows/release")
    elseif(CMAKE_BUILD_TYPE MATCHES Debug)
        set(OF_LIB_DIR "${OF_ROOT_DIR}/lib-windows/debug")
    endif()

    if(MSVC)
        link_directories(${OF_LIB_DIR})
        file(GLOB_RECURSE OPENFRAMEWORKS_LIBS  "${OF_LIB_DIR}/*.lib")
    else()
        list(APPEND OPENFRAMEWORKS_LIBRARIES -L"${OF_LIB_DIR}")
        file(GLOB_RECURSE OPENFRAMEWORKS_LIBS  "${OF_LIB_DIR}/*.a")
    endif()

    if(NOT OPENFRAMEWORKS_LIBS)
        message(FATAL_ERROR "No openFrameworks libraries found in ${OF_LIB_DIR} folder.")
    endif()

    # If we are on Windows using MSVC
    # we don't need GCC's link groups
    if(MSVC)
        list(APPEND OPENFRAMEWORKS_LIBRARIES
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

    set(OPENFRAMEWORKS_INCLUDE_DIRS
        ${ZLIB_INCLUDE_DIRS}
        ${BZIP2_INCLUDE_DIR}
        ${CAIRO_INCLUDE_DIR}
        ${OPENAL_INCLUDE_DIR}
        ${OPENGL_INCLUDE_DIR}
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

list(APPEND OPENFRAMEWORKS_INCLUDE_DIRS
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
    "${OF_ROOT_DIR}/src/kiss/include"
    "${OF_ROOT_DIR}/src/kiss/src"

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

    "${OF_ROOT_DIR}/src/tess2"
    "${OF_ROOT_DIR}/src/tess2/include"
    "${OF_ROOT_DIR}/src/tess2/Sources"

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

    list(APPEND OPENFRAMEWORKS_DEFINITIONS
        -D_SCL_SECURE_NO_WARNINGS
        -D_CRT_SECURE_NO_WARNINGS
    )

    list(APPEND OPENFRAMEWORKS_DEFINITIONS
        -D_WIN32_WINNT=0x0501
        -D_UNICODE -DUNICODE
    )
endif()

list(APPEND OPENFRAMEWORKS_DEFINITIONS
    -DFREEIMAGE_LIB
    -DPOCO_STATIC
)

add_definitions(${OPENFRAMEWORKS_DEFINITIONS})
include_directories(${OPENFRAMEWORKS_INCLUDE_DIRS})

#// Compiler flags /////////////////////////////////////////////////////////////

if(CMAKE_C_COMPILER_ID STREQUAL Clang)
    set(O_FLAG -O0)
elseif(CMAKE_C_COMPILER_ID STREQUAL GNU)
  if(CMAKE_C_COMPILER_VERSION VERSION_GREATER 4.8.0)
    set(O_FLAG -Og)
  elseif(CMAKE_SYSTEM MATCHES Windows)
    # If GNU compiler's version below 4.8.0 and we are on Windows,
    # then we're using old MinGW compiler. To avoid "File too big"
    # error we have to crank O level up to make object files small
    set(O_FLAG -O2)
  else()
    set(O_FLAG -O0)
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

string(REGEX REPLACE " +" " " CMAKE_C_FLAGS_RELEASE "${C_COLORIZATION} ${CMAKE_C_FLAGS_RELEASE} ${RELEASE_FLAGS} ${RELEASE_C_FLAGS_CLANG}")
string(REGEX REPLACE " +" " " CMAKE_C_FLAGS_DEBUG   "${C_COLORIZATION} ${CMAKE_C_FLAGS_DEBUG}     ${DEBUG_FLAGS}   ${DEBUG_C_FLAGS_CLANG} ${PIC_FLAG}")

string(REGEX REPLACE " +" " " CMAKE_CXX_FLAGS_RELEASE "${CXX_COLORIZATION} ${CPP11_FLAG} ${CMAKE_CXX_FLAGS_RELEASE} ${RELEASE_FLAGS} ${RELEASE_CXX_FLAGS_CLANG}")
string(REGEX REPLACE " +" " " CMAKE_CXX_FLAGS_DEBUG   "${CXX_COLORIZATION} ${CPP11_FLAG} ${CMAKE_CXX_FLAGS_DEBUG}     ${DEBUG_FLAGS}   ${DEBUG_CXX_FLAGS_CLANG} ${PIC_FLAG}")

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
        if(MSVC)
          if(CMAKE_BUILD_TYPE MATCHES Release)
            list(APPEND OFXADDONS_LIBRARIES assimpmd.lib)
          elseif(CMAKE_BUILD_TYPE MATCHES Debug)
            list(APPEND OFXADDONS_LIBRARIES assimpmdd.lib)
          endif()
        else()
          list(APPEND OFXADDONS_LIBRARIES -lassimp)
        endif()
        include_directories("${OF_ROOT_DIR}/src/assimp/include")


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
        list(APPEND OFXADDONS_LIBRARIES ${LIBUSB_1_LIBRARIES})


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
        foreach(LIBRARY ${OPENCV_LIBRARIES})
          if(NOT ${LIBRARY} MATCHES opencv_ts AND
             NOT ${LIBRARY} MATCHES opengl32  AND
             NOT ${LIBRARY} MATCHES glu32)
               find_library(FOUND_${LIBRARY} ${LIBRARY})
               list(APPEND OFXADDONS_LIBRARIES ${FOUND_${LIBRARY}})
          endif()
        endforeach()
        if (CMAKE_SYSTEM MATCHES Linux)
            find_package(TBB REQUIRED)
            include_directories(${TBB_INCLUDE_DIRS})
            list(APPEND OFXADDONS_LIBRARIES ${TBB_LIBRARIES})
        endif()


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

        file(GLOB_RECURSE OFXHEADERS "${OFXADDON_DIR}/src/*.h"
                                     "${OFXADDON_DIR}/src/*.hpp"
                                     "${OFXADDON_DIR}/libs/*.h"
                                     "${OFXADDON_DIR}/libs/*.hpp")

        file(GLOB_RECURSE OFXSOURCES "${OFXADDON_DIR}/src/*.c"
                                     "${OFXADDON_DIR}/src/*.cpp"
                                     "${OFXADDON_DIR}/libs/*.c"
                                     "${OFXADDON_DIR}/libs/*.cpp")

        foreach(OFXHEADER_PATH ${OFXHEADERS})
            get_filename_component(OFXHEADER_DIR ${OFXHEADER_PATH} PATH)
            include_directories(${OFXHEADER_DIR} ${OFXADDON_INCLUDE_DIR})
        endforeach()

    endif()

    if(OFXSOURCES)
        if(ARGV1 STREQUAL SHARED)
            add_library(${OFXADDON} SHARED ${OFXSOURCES})
        else()
            add_library(${OFXADDON} STATIC ${OFXSOURCES})
        endif()
        set(OFXADDONS_LIBRARIES ${OFXADDONS_LIBRARIES} ${OFXADDON} PARENT_SCOPE)
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

if((NOT MSVC) AND (NOT(CMAKE_SYSTEM MATCHES Darwin)) )
    set(OFXADDONS_BEGIN -Wl,--start-group)
    set(OFXADDONS_END -Wl,--end-group)
endif()

#// Messages ///////////////////////////////////////////////////////////////////

message("++ CMAKE_BUILD_TYPE: " ${CMAKE_BUILD_TYPE})

message("++ CMAKE_C_COMPILER_ID: "   ${CMAKE_C_COMPILER_ID})
message("++ CMAKE_CXX_COMPILER_ID: " ${CMAKE_CXX_COMPILER_ID})

message("++ OF_ENABLE_COTIRE: "  ${OF_ENABLE_COTIRE})
message("++ OF_ENABLE_CONSOLE: " ${OF_ENABLE_CONSOLE})

if(CMAKE_BUILD_TYPE MATCHES Release)
    message("++ CMAKE_C_FLAGS_RELEASE: "   ${CMAKE_C_FLAGS_RELEASE})
    message("++ CMAKE_CXX_FLAGS_RELEASE: " ${CMAKE_CXX_FLAGS_RELEASE})
elseif(CMAKE_BUILD_TYPE MATCHES Debug)
    message("++ CMAKE_C_FLAGS_DEBUG: "     ${CMAKE_C_FLAGS_DEBUG})
    message("++ CMAKE_CXX_FLAGS_DEBUG: "   ${CMAKE_CXX_FLAGS_DEBUG})
endif()

message("++ OPENFRAMEWORKS_DEFINITIONS: ${OPENFRAMEWORKS_DEFINITIONS}")
