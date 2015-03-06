project(openFrameworks)

cmake_minimum_required(VERSION 2.8)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/dev/cmake")

#// Compiler-neutral flags /////////////////////////////////////////////////////

set(RELEASE_FLAGS "
")

set(DEBUG_FLAGS "
    -O0
    -fPIC
")

#// Clang specific flags ///////////////////////////////////////////////////////

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

#// Setup //////////////////////////////////////////////////////////////////////

set(OF_ROOT_DIR ${CMAKE_CURRENT_LIST_DIR})

find_package(PkgConfig REQUIRED)

if(NOT CMAKE_BUILD_TYPE)
   set(CMAKE_BUILD_TYPE Release)
endif()

if(CMAKE_SYSTEM MATCHES Linux)
    set(LIBRARY_OUTPUT_PATH "${OF_ROOT_DIR}/lib/${CMAKE_BUILD_TYPE}/linux")
elseif(CMAKE_SYSTEM MATCHES Windows)
    set(LIBRARY_OUTPUT_PATH "${OF_ROOT_DIR}/lib/${CMAKE_BUILD_TYPE}/windows")
endif()

#///////////////////////////////////////////////////////////////////////////////

if(CMAKE_SYSTEM MATCHES Linux)

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
    find_package(OpenAL REQUIRED)
    find_package(OpenGL REQUIRED)
    find_package(MPG123 REQUIRED)
    find_package(Freetype REQUIRED)
    find_package(GStreamer REQUIRED)
    find_package(Fontconfig REQUIRED)

    list(APPEND DEFINITIONS
        ${FONTCONFIG_DEFINITIONS}
    )

    set(INCLUDE_DIRS
        ${GTK3_INCLUDE_DIRS}
        ${GLIB_INCLUDE_DIRS}
        ${ALSA_INCLUDE_DIRS}
        ${CAIRO_INCLUDE_DIR}
        ${OPENAL_INCLUDE_DIR}
        ${OPENGL_INCLUDE_DIR}
        ${MPG123_INCLUDE_DIRS}
        ${FREETYPE_INCLUDE_DIRS}
        ${GSTREAMER_INCLUDE_DIRS}
        ${FONTCONFIG_INCLUDE_DIR}
    )

elseif(CMAKE_SYSTEM MATCHES Darwin)

    message(FATAL_ERROR "OS X systems are not supported yet. Feel free to add support by yourself and pull request changes!")

elseif(CMAKE_SYSTEM MATCHES Windows)

    set(DEFINITIONS
        -DOF_USING_MPG123
        -DOF_SOUNDSTREAM_RTAUDIO
        -DOF_SOUND_PLAYER_OPENAL
        -DOF_VIDEO_CAPTURE_DIRECTSHOW
        -DOF_VIDEO_PLAYER_DIRECTSHOW
    )
    
    find_package(Cairo REQUIRED)
    find_package(OpenAL REQUIRED)
    find_package(OpenGL REQUIRED)
    find_package(MPG123 REQUIRED)
    find_package(Freetype REQUIRED)
    find_package(Fontconfig REQUIRED)

    list(APPEND OPENGL_INCLUDE_DIR
        "${CMAKE_FIND_ROOT_PATH}/include/GL"
    )

    list(APPEND DEFINITIONS
        ${FONTCONFIG_DEFINITIONS}
    )

    set(INCLUDE_DIRS
        ${CAIRO_INCLUDE_DIR}
        ${OPENAL_INCLUDE_DIR}
        ${OPENGL_INCLUDE_DIR}
        ${MPG123_INCLUDE_DIRS}
        ${FREETYPE_INCLUDE_DIRS}
        ${FONTCONFIG_INCLUDE_DIR}
    )

endif()

list(APPEND INCLUDE_DIRS
    "${OF_ROOT_DIR}/src/freeglut"
    "${OF_ROOT_DIR}/src/freeglut/include"

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

if(CMAKE_SYSTEM MATCHES Windows)
    list(APPEND INCLUDE_DIRS
    "${OF_ROOT_DIR}/src/videoinput"
    )
endif()

set(SOURCES
    "${OF_ROOT_DIR}/src/openframeworks/3d/of3dPrimitives.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/3d/of3dUtils.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/3d/ofCamera.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/3d/ofEasyCam.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/3d/ofMesh.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/3d/ofNode.cpp"

    "${OF_ROOT_DIR}/src/openframeworks/app/ofAppGLFWWindow.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/app/ofAppGlutWindow.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/app/ofAppNoWindow.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/app/ofAppRunner.cpp"

    "${OF_ROOT_DIR}/src/openframeworks/communication/ofArduino.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/communication/ofSerial.cpp"

    "${OF_ROOT_DIR}/src/openframeworks/events/ofEvents.cpp"

    "${OF_ROOT_DIR}/src/openframeworks/gl/ofBufferObject.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/gl/ofFbo.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/gl/ofGLProgrammableRenderer.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/gl/ofGLRenderer.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/gl/ofGLUtils.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/gl/ofLight.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/gl/ofMaterial.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/gl/ofShader.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/gl/ofTexture.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/gl/ofVbo.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/gl/ofVboMesh.cpp"

    "${OF_ROOT_DIR}/src/openframeworks/graphics/of3dGraphics.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/graphics/ofBitmapFont.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/graphics/ofCairoRenderer.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/graphics/ofGraphics.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/graphics/ofImage.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/graphics/ofPath.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/graphics/ofPixels.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/graphics/ofPolyline.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/graphics/ofRendererCollection.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/graphics/ofTessellator.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/graphics/ofTrueTypeFont.cpp"

    "${OF_ROOT_DIR}/src/openframeworks/math/ofMath.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/math/ofMatrix3x3.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/math/ofMatrix4x4.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/math/ofQuaternion.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/math/ofVec2f.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/math/ofVec4f.cpp"

    "${OF_ROOT_DIR}/src/openframeworks/sound/ofOpenALSoundPlayer.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/sound/ofRtAudioSoundStream.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/sound/ofSoundPlayer.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/sound/ofSoundStream.cpp"

    "${OF_ROOT_DIR}/src/openframeworks/types/ofBaseTypes.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/types/ofColor.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/types/ofParameter.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/types/ofParameterGroup.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/types/ofRectangle.cpp"

    "${OF_ROOT_DIR}/src/openframeworks/utils/ofFileUtils.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/utils/ofFpsCounter.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/utils/ofLog.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/utils/ofMatrixStack.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/utils/ofSystemUtils.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/utils/ofThread.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/utils/ofTimer.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/utils/ofURLFileLoader.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/utils/ofUtils.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/utils/ofXml.cpp"

    "${OF_ROOT_DIR}/src/openframeworks/video/ofVideoGrabber.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/video/ofVideoPlayer.cpp"
)

if(CMAKE_SYSTEM MATCHES Linux)
    list(APPEND SOURCES
    "${OF_ROOT_DIR}/src/openframeworks/video/ofGstUtils.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/video/ofGstVideoGrabber.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/video/ofGstVideoPlayer.cpp"
    )
elseif(CMAKE_SYSTEM MATCHES Windows)
    list(APPEND SOURCES
    "${OF_ROOT_DIR}/src/videoinput/videoInput.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/video/ofDirectShowGrabber.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/video/ofDirectShowPlayer.cpp"
    )
endif()

list(APPEND DEFINITIONS
    -DFREEIMAGE_LIB
    -DPOCO_STATIC
)

add_definitions(${DEFINITIONS})
include_directories(${INCLUDE_DIRS})

#// Compiler flags /////////////////////////////////////////////////////////////

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

string(REGEX REPLACE " +" " " CMAKE_C_FLAGS_RELEASE   "${C_COLORIZATION} ${CMAKE_C_FLAGS_RELEASE} ${RELEASE_FLAGS} ${RELEASE_C_FLAGS_CLANG}")
string(REGEX REPLACE " +" " " CMAKE_C_FLAGS_DEBUG     "${C_COLORIZATION} ${CMAKE_C_FLAGS_DEBUG}     ${DEBUG_FLAGS}   ${DEBUG_C_FLAGS_CLANG}")

string(REGEX REPLACE " +" " " CMAKE_CXX_FLAGS_RELEASE "${CXX_COLORIZATION} -std=gnu++11 ${CMAKE_CXX_FLAGS_RELEASE} ${RELEASE_FLAGS} ${RELEASE_CXX_FLAGS_CLANG}")
string(REGEX REPLACE " +" " " CMAKE_CXX_FLAGS_DEBUG   "${CXX_COLORIZATION} -std=gnu++11 ${CMAKE_CXX_FLAGS_DEBUG}     ${DEBUG_FLAGS}   ${DEBUG_CXX_FLAGS_CLANG}")

#// Messages ///////////////////////////////////////////////////////////////////

message(STATUS "CMAKE_BUILD_TYPE: " ${CMAKE_BUILD_TYPE})

message(STATUS "CMAKE_C_COMPILER_ID: "   ${CMAKE_C_COMPILER_ID})
message(STATUS "CMAKE_CXX_COMPILER_ID: " ${CMAKE_CXX_COMPILER_ID})

if(CMAKE_BUILD_TYPE MATCHES Debug)
    message(STATUS "CMAKE_C_FLAGS_DEBUG: "   ${CMAKE_C_FLAGS_DEBUG})
    message(STATUS "CMAKE_CXX_FLAGS_DEBUG: " ${CMAKE_CXX_FLAGS_DEBUG})
endif()

if(CMAKE_BUILD_TYPE MATCHES Release)
    message(STATUS "CMAKE_C_FLAGS_RELEASE: "   ${CMAKE_C_FLAGS_RELEASE})
    message(STATUS "CMAKE_CXX_FLAGS_RELEASE: " ${CMAKE_CXX_FLAGS_RELEASE})
endif()

#// Build //////////////////////////////////////////////////////////////////////

add_subdirectory(src/freeglut)
add_subdirectory(src/freeimage)
add_subdirectory(src/glew)
add_subdirectory(src/glfw)
add_subdirectory(src/kiss)
add_subdirectory(src/poco)
add_subdirectory(src/rtaudio)
add_subdirectory(src/tess2)
add_subdirectory(src/assimp)

add_library(openFrameworks STATIC ${SOURCES})
