list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/dev/cmake")

#-- Compiler-neutral flags ----------------

set(RELEASE_FLAGS "
")

set(DEBUG_FLAGS "
    -g
    -fPIC
    -fsanitize=address
")

#-- GCC specific flags --------------------

if(CMAKE_C_COMPILER_ID STREQUAL GNU)
    set(RELEASE_C_FLAGS_GCC "
    ")

    set(DEBUG_C_FLAGS_GCC "
        -Og
    ")
endif()

if(CMAKE_CXX_COMPILER_ID STREQUAL GNU)
    set(RELEASE_CXX_FLAGS_GCC "
    ")

    set(DEBUG_CXX_FLAGS_GCC "
        -Og
    ")
endif()

#-- Clang specific flags ------------------

if(CMAKE_C_COMPILER_ID STREQUAL Clang)
    set(RELEASE_C_FLAGS_CLANG "
        -Wno-deprecated-register
    ")

    set(DEBUG_C_FLAGS_CLANG "
        -Wno-deprecated-register
        -fsanitize-address-zero-base-shadow
    ")
endif()

#------------------------------------------

if(CMAKE_CXX_COMPILER_ID STREQUAL Clang)
    set(RELEASE_CXX_FLAGS_CLANG "
        -Wno-deprecated-register
    ")

    set(DEBUG_CXX_FLAGS_CLANG "
        -Wno-deprecated-register
        -fsanitize-address-zero-base-shadow
    ")
endif()

if(NOT CMAKE_BUILD_TYPE)
   set(CMAKE_BUILD_TYPE "Release")
endif()

# PkgConfig required for addons
find_package(PkgConfig REQUIRED)

# Constant root directory path for addons
set(OF_ROOT_DIR ${CMAKE_CURRENT_LIST_DIR})

if(UNIX AND NOT APPLE)

    set(LIB_DIR "${OF_ROOT_DIR}/lib/${CMAKE_BUILD_TYPE}/linux")

    set(OPENFRAMEWORKS_DEFINITIONS
        -DOF_USING_GTK
        -DOF_USING_MPG123
        -DOF_SOUNDSTREAM_RTAUDIO
        -DOF_SOUND_PLAYER_OPENAL
        -DOF_VIDEO_CAPTURE_GSTREAMER
        -DOF_VIDEO_PLAYER_GSTREAMER
    )

    # Static C and C++
    set(OPENFRAMEWORKS_LIBRARIES
        -static-libgcc
        -static-libstdc++
    )

    # Search path for .so
    list(APPEND OPENFRAMEWORKS_LIBRARIES
        -Wl,-rpath,'$$ORIGIN'
    )

    # Local dependencies
    list(APPEND OPENFRAMEWORKS_LIBRARIES -L"${LIB_DIR}")
    file(GLOB_RECURSE OPENFRAMEWORKS_DEP   "${LIB_DIR}/*.a")

    list(APPEND OPENFRAMEWORKS_LIBRARIES
        -Wl,-Bstatic
        -Wl,--start-group
        ${OPENFRAMEWORKS_DEP}
        -Wl,--end-group
        -Wl,-Bdynamic
    )

    # External dependencies
    find_package(X11 REQUIRED)
    find_package(ZLIB REQUIRED)
    find_package(UDev REQUIRED)
    find_package(ALSA REQUIRED)
    find_package(GTK2 REQUIRED)
    find_package(Cairo REQUIRED)
    find_package(LibUSB REQUIRED)
    find_package(MPG123 REQUIRED)
    find_package(OpenAL REQUIRED)
    find_package(OpenGL REQUIRED)
    find_package(OpenSSL REQUIRED)
    find_package(Threads REQUIRED)
    find_package(Sndfile REQUIRED)
    find_package(Freetype REQUIRED)
    find_package(GStreamer REQUIRED)

    list(APPEND OPENFRAMEWORKS_DEFINITIONS
        ${GTK2_DEFINITIONS}
    )

    set(OPENFRAMEWORKS_INCLUDE_DIRS
        ${X11_INCLUDE_DIR}
        ${ZLIB_INCLUDE_DIRS}
        ${UDEV_INCLUDE_DIR}
        ${ALSA_INCLUDE_DIRS}
        ${GTK2_INCLUDE_DIRS}
        ${CAIRO_INCLUDE_DIR}
        ${LIBUSB_1_INCLUDE_DIRS}
        ${MPG123_INCLUDE_DIRS}
        ${OPENAL_INCLUDE_DIR}
        ${OPENGL_INCLUDE_DIR}
        ${OPENSSL_INCLUDE_DIR}
        ${SNDFILE_INCLUDE_DIR}
        ${GSTREAMER_INCLUDE_DIRS}
    )

    list(APPEND OPENFRAMEWORKS_LIBRARIES
        ${X11_LIBRARIES}
        ${X11_Xi_LIB}
        ${X11_Xrandr_LIB}
        ${X11_Xcursor_LIB}
        ${X11_Xxf86vm_LIB}
        ${ZLIB_LIBRARIES}
        ${UDEV_LIBRARIES}
        ${ALSA_LIBRARIES}
        ${GTK2_LIBRARIES}
        ${CAIRO_LIBRARIES}
        ${LIBUSB_1_LIBRARIES}
        ${MPG123_LIBRARIES}
        ${OPENAL_LIBRARY}
        ${OPENGL_LIBRARIES}
        ${OPENSSL_LIBRARIES}
        ${SNDFILE_LIBRARIES}
        ${GSTREAMER_LIBRARIES}
        ${GSTREAMER_BASE_LIBRARIES}
        ${GSTREAMER_APP_LIBRARIES}
        ${GSTREAMER_VIDEO_LIBRARIES}
        ${CMAKE_THREAD_LIBS_INIT}
    )

elseif(WIN32)

    set(LIB_DIR "${OF_ROOT_DIR}/lib/Release/windows")

    set(WIN_DLL_DIR "/opt/mxe/usr/x86_64-w64-mingw32.shared/bin")

    # Dynamic libraries
    set(OPENFRAMEWORKS_DLL
        "${OF_ROOT_DIR}/lib/Release/windows/libusb.dll"
        "${WIN_DLL_DIR}/libvorbisenc-2.dll"
        "${WIN_DLL_DIR}/libsndfile-1.dll"
        "${WIN_DLL_DIR}/libvorbis-0.dll"
        "${WIN_DLL_DIR}/libFLAC-8.dll"
        "${WIN_DLL_DIR}/OpenAL32.dll"
        "${WIN_DLL_DIR}/libogg-0.dll"
    )

    # MinGW libraries
    set(WIN_LIBRARIES
        winmm
        gdi32
        ws2_32
        crypt32
        wsock32
        iphlpapi
        strmiids
        setupapi
    )

    if(NOT DLL_MANUAL_COPY)
        file(COPY ${OPENFRAMEWORKS_DLL} DESTINATION
                  ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
    endif()

    set(OPENFRAMEWORKS_DEFINITIONS
        -D__MINGW32_VERSION
        -DOF_SOUNDSTREAM_RTAUDIO
        -DOF_SOUND_PLAYER_OPENAL
        -DOF_VIDEO_CAPTURE_DIRECTSHOW
        -DOF_VIDEO_PLAYER_DIRECTSHOW
    )

    # Static C and C++
    set(OPENFRAMEWORKS_LIBRARIES
        -static-libgcc
        -static-libstdc++
    )

    if(NOT SHOW_CONSOLE)
        list(APPEND OPENFRAMEWORKS_LIBRARIES -mwindows)
    endif()

    # Local dependencies
    list(APPEND OPENFRAMEWORKS_LIBRARIES -L"${LIB_DIR}")
    file(GLOB_RECURSE OPENFRAMEWORKS_DEP   "${LIB_DIR}/*.a")

    # External dependencies
    find_package(Glib REQUIRED)
    find_package(ZLIB REQUIRED)
    find_package(BZip2 REQUIRED)
    find_package(Iconv REQUIRED)
    find_package(Cairo REQUIRED)
    find_package(OpenAL REQUIRED)
    find_package(OpenGL REQUIRED)
    find_package(Pixman REQUIRED)
    find_package(OpenSSL REQUIRED)
    find_package(Sndfile REQUIRED)
    find_package(LibIntl REQUIRED)
    find_package(Threads REQUIRED)
    find_package(Freetype REQUIRED)

    # There was a case when GL folder didn't get added to include path
    list(APPEND OPENGL_INCLUDE_DIR "${CMAKE_FIND_ROOT_PATH}/include/GL")

    set(OPENFRAMEWORKS_INCLUDE_DIRS
        ${GLIB_INCLUDE_DIRS}
        ${ZLIB_INCLUDE_DIRS}
        ${BZIP2_INCLUDE_DIR}
        ${ICONV_INCLUDE_DIR}
        ${CAIRO_INCLUDE_DIR}
        ${OPENAL_INCLUDE_DIR}
        ${OPENGL_INCLUDE_DIR}
        ${PIXMAN_INCLUDE_DIRS}
        ${OPENSSL_INCLUDE_DIR}
        ${SNDFILE_INCLUDE_DIR}
        ${LIBINTL_INCLUDE_DIR}
        ${FREETYPE_INCLUDE_DIRS}
    )

    list(APPEND OPENFRAMEWORKS_LIBRARIES
        -Wl,-Bstatic
        -Wl,--start-group
        ${WIN_LIBRARIES}
        ${GLIB_LIBRARIES}
        ${ZLIB_LIBRARIES}
        ${BZIP2_LIBRARIES}
        ${ICONV_LIBRARIES}
        ${CAIRO_LIBRARIES}
        ${OPENGL_LIBRARIES}
        ${PIXMAN_LIBRARIES}
        ${OPENSSL_LIBRARIES}
        ${LIBINTL_LIBRARIES}
        ${FREETYPE_LIBRARIES}
        ${CMAKE_THREAD_LIBS_INIT}
        ${OPENFRAMEWORKS_DEP}
        -Wl,--end-group
        -Wl,-Bdynamic
        ${OPENFRAMEWORKS_DLL}
    )

endif()

list(APPEND OPENFRAMEWORKS_INCLUDE_DIRS
    "${OF_ROOT_DIR}/src/fontconfig"
    "${OF_ROOT_DIR}/src/fontconfig/src"

    "${OF_ROOT_DIR}/src/freeglut"
    "${OF_ROOT_DIR}/src/freeglut/include"

    "${OF_ROOT_DIR}/src/freeimage"

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
    "${OF_ROOT_DIR}/src/poco/Crypto/include/Poco"
    "${OF_ROOT_DIR}/src/poco/Crypto/include/Poco/Crypto"

    "${OF_ROOT_DIR}/src/poco/Foundation/include"
    "${OF_ROOT_DIR}/src/poco/Foundation/include/Poco"
    "${OF_ROOT_DIR}/src/poco/Foundation/include/Poco/Dynamic"

    "${OF_ROOT_DIR}/src/poco/Net/include"
    "${OF_ROOT_DIR}/src/poco/Net/include/Poco"
    "${OF_ROOT_DIR}/src/poco/Net/include/Poco/Net"

    "${OF_ROOT_DIR}/src/poco/NetSSL_OpenSSL/include"
    "${OF_ROOT_DIR}/src/poco/NetSSL_OpenSSL/include/Poco"
    "${OF_ROOT_DIR}/src/poco/NetSSL_OpenSSL/include/Poco/Net"

    "${OF_ROOT_DIR}/src/poco/Util/include"
    "${OF_ROOT_DIR}/src/poco/Util/include/Poco"
    "${OF_ROOT_DIR}/src/poco/Util/include/Poco/Util"

    "${OF_ROOT_DIR}/src/poco/XML/include"
    "${OF_ROOT_DIR}/src/poco/XML/include/Poco"
    "${OF_ROOT_DIR}/src/poco/XML/include/Poco/DOM"
    "${OF_ROOT_DIR}/src/poco/XML/include/Poco/SAX"
    "${OF_ROOT_DIR}/src/poco/XML/include/Poco/XML"

    "${OF_ROOT_DIR}/src/poco/Zip/include"
    "${OF_ROOT_DIR}/src/poco/Zip/include/Poco"
    "${OF_ROOT_DIR}/src/poco/Zip/include/Poco/Zip"

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

if(WIN32)
list(APPEND OPENFRAMEWORKS_INCLUDE_DIRS
    "${OF_ROOT_DIR}/src/videoinput"

    "${OF_ROOT_DIR}/src/libusb"
    "${OF_ROOT_DIR}/src/libusb/libusb"
)
endif(WIN32)

list(APPEND OPENFRAMEWORKS_DEFINITIONS
    -DPOCO_STATIC
    -DPOCO_NO_AUTOMATIC_LIB_INIT
)

add_definitions(${OPENFRAMEWORKS_DEFINITIONS})
include_directories(${OPENFRAMEWORKS_INCLUDE_DIRS})


string(REPLACE "\n" " " RELEASE_FLAGS ${RELEASE_FLAGS})
string(REPLACE "\n" " "   DEBUG_FLAGS   ${DEBUG_FLAGS})

if(CMAKE_C_COMPILER_ID STREQUAL GNU)
string(REPLACE "\n" " " RELEASE_C_FLAGS_GCC ${RELEASE_C_FLAGS_GCC})
string(REPLACE "\n" " "   DEBUG_C_FLAGS_GCC   ${DEBUG_C_FLAGS_GCC})
endif()
if(CMAKE_CXX_COMPILER_ID STREQUAL GNU)
string(REPLACE "\n" " " RELEASE_CXX_FLAGS_GCC ${RELEASE_CXX_FLAGS_GCC})
string(REPLACE "\n" " "   DEBUG_CXX_FLAGS_GCC   ${DEBUG_CXX_FLAGS_GCC})
endif()
if(CMAKE_C_COMPILER_ID STREQUAL Clang)
string(REPLACE "\n" " " RELEASE_C_FLAGS_CLANG ${RELEASE_C_FLAGS_CLANG})
string(REPLACE "\n" " "   DEBUG_C_FLAGS_CLANG   ${DEBUG_C_FLAGS_CLANG})
endif()
if(CMAKE_CXX_COMPILER_ID STREQUAL Clang)
string(REPLACE "\n" " " RELEASE_CXX_FLAGS_CLANG ${RELEASE_CXX_FLAGS_CLANG})
string(REPLACE "\n" " "   DEBUG_CXX_FLAGS_CLANG   ${DEBUG_CXX_FLAGS_CLANG})
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

set(CMAKE_C_FLAGS_RELEASE   "${C_COLORIZATION} ${CMAKE_C_FLAGS_RELEASE} ${RELEASE_FLAGS} ${RELEASE_C_FLAGS_GCC} ${RELEASE_C_FLAGS_CLANG}")
set(CMAKE_C_FLAGS_DEBUG     "${C_COLORIZATION} ${CMAKE_C_FLAGS_DEBUG}     ${DEBUG_FLAGS}   ${DEBUG_C_FLAGS_GCC}   ${DEBUG_C_FLAGS_CLANG}")

set(CMAKE_CXX_FLAGS_RELEASE "${CXX_COLORIZATION} -std=gnu++11 ${CMAKE_CXX_FLAGS_RELEASE} ${RELEASE_FLAGS} ${RELEASE_CXX_FLAGS_GCC} ${RELEASE_CXX_FLAGS_CLANG}")
set(CMAKE_CXX_FLAGS_DEBUG   "${CXX_COLORIZATION} -std=gnu++11 ${CMAKE_CXX_FLAGS_DEBUG}     ${DEBUG_FLAGS}   ${DEBUG_CXX_FLAGS_GCC}   ${DEBUG_CXX_FLAGS_CLANG}")

if(UNIX AND NOT APPLE)
# Optional path for headers which need to be
# included first before system path scanning
include_directories("${OF_ROOT_DIR}/include")
endif()

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/bin")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/bin")
set(LIBRARY_OUTPUT_PATH ${CMAKE_CURRENT_SOURCE_DIR}/bin)

function(ofxaddon OFXADDON)

    set(OFXADDON_DIR ${OFXADDON})

    #-- Standard addons ---------------------------------------------

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
        list(APPEND OFXADDONS_LIBRARIES -lassimp)
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
        if (CMAKE_BUILD_TYPE STREQUAL Release)
            # Static OpenCV for release only, on Ubuntu 14.04 OpenCV build without -fPIC
            list(APPEND OFXADDONS_LIBRARIES -Wl,-Bstatic ${OPENCV_LDFLAGS} -Wl,-Bdynamic)
            if (UNIX AND NOT APPLE)
                pkg_check_modules(TBB REQUIRED tbb)
                include_directories(${TBB_INCLUDE_DIRS})
                list(APPEND OFXADDONS_LIBRARIES ${TBB_LIBRARIES})
            endif()
        else()
            # Dynamic OpenCV for debugging with Clang's ASAN
            list(APPEND OFXADDONS_LIBRARIES ${OPENCV_LDFLAGS})
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
        if(UNIX AND NOT APPLE)
        list(APPEND OFXSOURCES
            "${OFXADDON_DIR}/libs/oscpack/src/ip/posix/NetworkingUtils.cpp"
            "${OFXADDON_DIR}/libs/oscpack/src/ip/posix/UdpSocket.cpp"
        )
        elseif(WIN32)
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


    elseif(OFXADDON STREQUAL ofxSynth)
        set(OFXADDON_DIR "${OF_ROOT_DIR}/addons/ofxSynth")
        set(OFXSOURCES
            "${OFXADDON_DIR}/src/ofxSoundEffect.cpp"
            "${OFXADDON_DIR}/src/ofxSoundUnit.cpp"
            "${OFXADDON_DIR}/src/ofxSynth.cpp"
            "${OFXADDON_DIR}/src/ofxSynthDelayLine.cpp"
            "${OFXADDON_DIR}/src/ofxSynthEnvelope.cpp"
            "${OFXADDON_DIR}/src/ofxSynthFilter.cpp"
            "${OFXADDON_DIR}/src/ofxSynthSampler.cpp"
            "${OFXADDON_DIR}/src/ofxSynthWaveWriter.cpp"
        )


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

    #-- Custom addons -----------------------------------------------

    else()

        file(GLOB_RECURSE OFXHEADERS "${OFXADDON_DIR}/src/*.h"
                                     "${OFXADDON_DIR}/src/*.hpp"
                                     "${OFXADDON_DIR}/libs/*.h"
                                     "${OFXADDON_DIR}/libs/*.hpp")

        file(GLOB_RECURSE OFXSOURCES "${OFXADDON_DIR}/src/*.c"
                                     "${OFXADDON_DIR}/src/*.cpp")

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

include(cotire)
set(COTIRE_MINIMUM_NUMBER_OF_TARGET_SOURCES 1)
set_directory_properties(PROPERTIES COTIRE_ADD_UNITY_BUILD FALSE)

set(OFXADDONS_BEGIN -Wl,--start-group)
set(OFXADDONS_END -Wl,--end-group)

