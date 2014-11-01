cmake_minimum_required(VERSION 2.8)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/dev/cmake")

project(openFrameworks)

#-- Compiler-neutral flags ----------------

set(RELEASE_FLAGS "
")

set(DEBUG_FLAGS "
    -g
    -fPIC
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
    ")
endif()

if(CMAKE_CXX_COMPILER_ID STREQUAL Clang)
    set(RELEASE_CXX_FLAGS_CLANG "
        -Wno-deprecated-register
    ")

    set(DEBUG_CXX_FLAGS_CLANG "
        -Wno-deprecated-register
    ")
endif()

#------------------------------------------

find_package(PkgConfig REQUIRED)

if(NOT CMAKE_BUILD_TYPE)
   set(CMAKE_BUILD_TYPE "Release")
endif()

if(UNIX AND NOT APPLE)

    set(DEFINITIONS
        -DOF_USING_GTK
        -DOF_USING_MPG123
        -DOF_SOUNDSTREAM_RTAUDIO
        -DOF_SOUND_PLAYER_OPENAL
        -DOF_VIDEO_CAPTURE_GSTREAMER
        -DOF_VIDEO_PLAYER_GSTREAMER
    )

    pkg_check_modules(GTK3 REQUIRED gtk+-3.0)

    find_package(Glib REQUIRED)
    find_package(ALSA REQUIRED)
    find_package(Cairo REQUIRED)
    find_package(MPG123 REQUIRED)
    find_package(OpenAL REQUIRED)
    find_package(OpenGL REQUIRED)
    find_package(Freetype REQUIRED)
    find_package(GStreamer REQUIRED)

    set(INCLUDE_DIRS
        ${GTK3_INCLUDE_DIRS}
        ${GLIB_INCLUDE_DIRS}
        ${ALSA_INCLUDE_DIRS}
        ${CAIRO_INCLUDE_DIR}
        ${MPG123_INCLUDE_DIRS}
        ${OPENAL_INCLUDE_DIR}
        ${OPENGL_INCLUDE_DIR}
        ${FREETYPE_INCLUDE_DIRS}
        ${GSTREAMER_INCLUDE_DIRS}
    )

elseif(WIN32)

    set(DEFINITIONS
        -D__MINGW32_VERSION
        -DOF_USING_MPG123
        -DOF_SOUNDSTREAM_RTAUDIO
        -DOF_SOUND_PLAYER_OPENAL
        -DOF_VIDEO_CAPTURE_DIRECTSHOW
        -DOF_VIDEO_PLAYER_DIRECTSHOW
    )
    
    find_package(Cairo REQUIRED)
    find_package(MPG123 REQUIRED)
    find_package(OpenAL REQUIRED)
    find_package(OpenGL REQUIRED)
    find_package(Freetype REQUIRED)

    list(APPEND OPENGL_INCLUDE_DIR "${CMAKE_FIND_ROOT_PATH}/include/GL")

    set(INCLUDE_DIRS
        ${CAIRO_INCLUDE_DIR}
        ${MPG123_INCLUDE_DIRS}
        ${OPENAL_INCLUDE_DIR}
        ${OPENGL_INCLUDE_DIR}
        ${FREETYPE_INCLUDE_DIRS}
    )

endif()

list(APPEND INCLUDE_DIRS
    "${CMAKE_CURRENT_LIST_DIR}/src/fontconfig"
    "${CMAKE_CURRENT_LIST_DIR}/src/fontconfig/src"

    "${CMAKE_CURRENT_LIST_DIR}/src/freeglut"
    "${CMAKE_CURRENT_LIST_DIR}/src/freeglut/include"

    "${CMAKE_CURRENT_LIST_DIR}/src/freeimage"

    "${CMAKE_CURRENT_LIST_DIR}/src/glew"
    "${CMAKE_CURRENT_LIST_DIR}/src/glew/include"

    "${CMAKE_CURRENT_LIST_DIR}/src/glfw"
    "${CMAKE_CURRENT_LIST_DIR}/src/glfw/include"
    "${CMAKE_CURRENT_LIST_DIR}/src/glfw/include/GLFW"

    "${CMAKE_CURRENT_LIST_DIR}/src/kiss"
    "${CMAKE_CURRENT_LIST_DIR}/src/kiss/include"
    "${CMAKE_CURRENT_LIST_DIR}/src/kiss/src"

    "${CMAKE_CURRENT_LIST_DIR}/src/poco"
    "${CMAKE_CURRENT_LIST_DIR}/src/poco/Crypto/include"
    "${CMAKE_CURRENT_LIST_DIR}/src/poco/Crypto/include/Poco"
    "${CMAKE_CURRENT_LIST_DIR}/src/poco/Crypto/include/Poco/Crypto"

    "${CMAKE_CURRENT_LIST_DIR}/src/poco/Foundation/include"
    "${CMAKE_CURRENT_LIST_DIR}/src/poco/Foundation/include/Poco"
    "${CMAKE_CURRENT_LIST_DIR}/src/poco/Foundation/include/Poco/Dynamic"

    "${CMAKE_CURRENT_LIST_DIR}/src/poco/Net/include"
    "${CMAKE_CURRENT_LIST_DIR}/src/poco/Net/include/Poco"
    "${CMAKE_CURRENT_LIST_DIR}/src/poco/Net/include/Poco/Net"

    "${CMAKE_CURRENT_LIST_DIR}/src/poco/NetSSL_OpenSSL/include"
    "${CMAKE_CURRENT_LIST_DIR}/src/poco/NetSSL_OpenSSL/include/Poco"
    "${CMAKE_CURRENT_LIST_DIR}/src/poco/NetSSL_OpenSSL/include/Poco/Net"

    "${CMAKE_CURRENT_LIST_DIR}/src/poco/Util/include"
    "${CMAKE_CURRENT_LIST_DIR}/src/poco/Util/include/Poco"
    "${CMAKE_CURRENT_LIST_DIR}/src/poco/Util/include/Poco/Util"

    "${CMAKE_CURRENT_LIST_DIR}/src/poco/XML/include"
    "${CMAKE_CURRENT_LIST_DIR}/src/poco/XML/include/Poco"
    "${CMAKE_CURRENT_LIST_DIR}/src/poco/XML/include/Poco/DOM"
    "${CMAKE_CURRENT_LIST_DIR}/src/poco/XML/include/Poco/SAX"
    "${CMAKE_CURRENT_LIST_DIR}/src/poco/XML/include/Poco/XML"

    "${CMAKE_CURRENT_LIST_DIR}/src/poco/Zip/include"
    "${CMAKE_CURRENT_LIST_DIR}/src/poco/Zip/include/Poco"
    "${CMAKE_CURRENT_LIST_DIR}/src/poco/Zip/include/Poco/Zip"

    "${CMAKE_CURRENT_LIST_DIR}/src/rtaudio"
    "${CMAKE_CURRENT_LIST_DIR}/src/rtaudio/include"

    "${CMAKE_CURRENT_LIST_DIR}/src/tess2"
    "${CMAKE_CURRENT_LIST_DIR}/src/tess2/include"
    "${CMAKE_CURRENT_LIST_DIR}/src/tess2/Sources"

    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/3d"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/app"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/communication"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/events"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/gl"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/graphics"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/math"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/sound"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/types"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/utils"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/video"
)

if(WIN32)
list(APPEND INCLUDE_DIRS
    "${CMAKE_CURRENT_LIST_DIR}/src/videoinput"

    "${CMAKE_CURRENT_LIST_DIR}/src/libusb"
    "${CMAKE_CURRENT_LIST_DIR}/src/libusb/libusb"
)
endif()

set(SOURCES
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/3d/of3dPrimitives.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/3d/of3dUtils.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/3d/ofCamera.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/3d/ofEasyCam.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/3d/ofMesh.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/3d/ofNode.cpp"

    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/app/ofAppGLFWWindow.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/app/ofAppGlutWindow.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/app/ofAppNoWindow.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/app/ofAppRunner.cpp"

    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/communication/ofArduino.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/communication/ofSerial.cpp"

    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/events/ofEvents.cpp"

    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/gl/ofBufferObject.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/gl/ofFbo.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/gl/ofGLProgrammableRenderer.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/gl/ofGLRenderer.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/gl/ofGLUtils.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/gl/ofLight.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/gl/ofMaterial.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/gl/ofShader.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/gl/ofTexture.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/gl/ofVbo.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/gl/ofVboMesh.cpp"

    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/graphics/of3dGraphics.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/graphics/ofBitmapFont.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/graphics/ofCairoRenderer.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/graphics/ofGraphics.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/graphics/ofImage.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/graphics/ofPath.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/graphics/ofPixels.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/graphics/ofPolyline.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/graphics/ofRendererCollection.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/graphics/ofTessellator.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/graphics/ofTrueTypeFont.cpp"

    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/math/ofMath.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/math/ofMatrix3x3.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/math/ofMatrix4x4.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/math/ofQuaternion.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/math/ofVec2f.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/math/ofVec4f.cpp"

    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/sound/ofOpenALSoundPlayer.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/sound/ofRtAudioSoundStream.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/sound/ofSoundPlayer.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/sound/ofSoundStream.cpp"

    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/types/ofBaseTypes.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/types/ofColor.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/types/ofParameter.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/types/ofParameterGroup.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/types/ofRectangle.cpp"

    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/utils/ofFileUtils.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/utils/ofFpsCounter.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/utils/ofLog.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/utils/ofMatrixStack.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/utils/ofSystemUtils.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/utils/ofThread.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/utils/ofTimer.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/utils/ofURLFileLoader.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/utils/ofUtils.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/utils/ofXml.cpp"

    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/video/ofVideoGrabber.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/video/ofVideoPlayer.cpp"
)

if(UNIX AND NOT APPLE)
list(APPEND SOURCES
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/video/ofGstUtils.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/video/ofGstVideoGrabber.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/video/ofGstVideoPlayer.cpp"
)
elseif(WIN32)
list(APPEND SOURCES
    "${CMAKE_CURRENT_LIST_DIR}/src/videoinput/videoInput.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/video/ofDirectShowGrabber.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/video/ofDirectShowPlayer.cpp"
)
endif()

list(APPEND DEFINITIONS
    -DFREEIMAGE_LIB
    -DPOCO_STATIC
    -DPOCO_NO_AUTOMATIC_LIB_INIT
)

add_definitions(${DEFINITIONS})
include_directories(${INCLUDE_DIRS})


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
   set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/lib/${CMAKE_BUILD_TYPE}/linux)
   set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/lib/${CMAKE_BUILD_TYPE}/linux)
   set(LIBRARY_OUTPUT_PATH ${CMAKE_CURRENT_LIST_DIR}/lib/${CMAKE_BUILD_TYPE}/linux)
elseif(WIN32)
   set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/lib/${CMAKE_BUILD_TYPE}/windows)
   set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/lib/${CMAKE_BUILD_TYPE}/windows)
   set(LIBRARY_OUTPUT_PATH ${CMAKE_CURRENT_LIST_DIR}/lib/${CMAKE_BUILD_TYPE}/windows)
endif()

add_subdirectory(src/fontconfig)
add_subdirectory(src/freeglut)
add_subdirectory(src/freeimage)
add_subdirectory(src/glew)
add_subdirectory(src/glfw)
add_subdirectory(src/kiss)
add_subdirectory(src/poco)
add_subdirectory(src/rtaudio)
add_subdirectory(src/tess2)
if(WIN32)
add_subdirectory(src/libusb)
endif()
add_subdirectory(src/assimp)

add_library(openFrameworks STATIC ${SOURCES})

