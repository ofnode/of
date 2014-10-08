cmake_minimum_required(VERSION 2.8)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")

project(openFrameworks)

set(DEBUG_FLAGS "
    -g
    -fPIC
")

if(NOT CMAKE_BUILD_TYPE)
   set(CMAKE_BUILD_TYPE "Release")
endif()

if(UNIX AND NOT APPLE)
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY
      ${CMAKE_CURRENT_SOURCE_DIR}/lib/${CMAKE_BUILD_TYPE}/linux)
      
    set(DEFINITIONS
        -DOF_USING_GTK
    )

    find_package(GTK2 REQUIRED)
    find_package(OpenGL REQUIRED)

    set(INCLUDE_DIRS
        ${GTK2_INCLUDE_DIRS}
        ${OPENGL_INCLUDE_DIR}
    )
endif(UNIX AND NOT APPLE)

if(WIN32)
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY
      ${CMAKE_CURRENT_SOURCE_DIR}/lib/${CMAKE_BUILD_TYPE}/windows)
    
    set(DEFINITIONS
        -D__MINGW32_VERSION
    )
    
    find_package(Cairo REQUIRED)
    find_package(OpenGL REQUIRED)
    find_package(Freetype REQUIRED)

    list(APPEND OPENGL_INCLUDE_DIR
        "${CMAKE_FIND_ROOT_PATH}/include/GL"
    )

    set(INCLUDE_DIRS
        ${CAIRO_INCLUDE_DIR}
        ${OPENGL_INCLUDE_DIR}
        ${FREETYPE_INCLUDE_DIRS}
    )
endif(WIN32)

set(INCLUDE_DIRS
  ${INCLUDE_DIRS}
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/3d"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/app"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/communication"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/events"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/gl"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/graphics"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/math"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/types"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/utils"

    "${CMAKE_CURRENT_SOURCE_DIR}/src/freeimage"

    "${CMAKE_CURRENT_SOURCE_DIR}/src/kiss"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/kiss/include"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/kiss/src"

    "${CMAKE_CURRENT_SOURCE_DIR}/src/tess2"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/tess2/include"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/tess2/Sources"

    "${CMAKE_CURRENT_SOURCE_DIR}/src/glew"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/glew/include"

    "${CMAKE_CURRENT_SOURCE_DIR}/src/glfw"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/glfw/include"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/glfw/include/GLFW"

    "${CMAKE_CURRENT_SOURCE_DIR}/src/poco"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/poco/Crypto/include"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/poco/Crypto/include/Poco"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/poco/Crypto/include/Poco/Crypto"

    "${CMAKE_CURRENT_SOURCE_DIR}/src/poco/Foundation/include"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/poco/Foundation/include/Poco"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/poco/Foundation/include/Poco/Dynamic"

    "${CMAKE_CURRENT_SOURCE_DIR}/src/poco/Net/include"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/poco/Net/include/Poco"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/poco/Net/include/Poco/Net"

    "${CMAKE_CURRENT_SOURCE_DIR}/src/poco/NetSSL_OpenSSL/include"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/poco/NetSSL_OpenSSL/include/Poco"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/poco/NetSSL_OpenSSL/include/Poco/Net"

    "${CMAKE_CURRENT_SOURCE_DIR}/src/poco/Util/include"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/poco/Util/include/Poco"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/poco/Util/include/Poco/Util"

    "${CMAKE_CURRENT_SOURCE_DIR}/src/poco/XML/include"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/poco/XML/include/Poco"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/poco/XML/include/Poco/DOM"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/poco/XML/include/Poco/SAX"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/poco/XML/include/Poco/XML"

    "${CMAKE_CURRENT_SOURCE_DIR}/src/poco/Zip/include"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/poco/Zip/include/Poco"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/poco/Zip/include/Poco/Zip"
)

set(SOURCES
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/3d/of3dPrimitives.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/3d/of3dUtils.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/3d/ofCamera.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/3d/ofEasyCam.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/3d/ofMesh.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/3d/ofNode.cpp"

    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/app/ofAppGLFWWindow.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/app/ofAppGlutWindow.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/app/ofAppNoWindow.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/app/ofAppRunner.cpp"

    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/communication/ofArduino.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/communication/ofSerial.cpp"

    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/events/ofEvents.cpp"

    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/gl/ofFbo.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/gl/ofGLProgrammableRenderer.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/gl/ofGLRenderer.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/gl/ofGLUtils.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/gl/ofLight.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/gl/ofMaterial.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/gl/ofShader.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/gl/ofTexture.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/gl/ofVbo.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/gl/ofVboMesh.cpp"

    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/graphics/of3dGraphics.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/graphics/ofBitmapFont.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/graphics/ofCairoRenderer.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/graphics/ofGraphics.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/graphics/ofImage.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/graphics/ofPath.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/graphics/ofPixels.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/graphics/ofPolyline.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/graphics/ofRendererCollection.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/graphics/ofTessellator.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/graphics/ofTrueTypeFont.cpp"

    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/math/ofMath.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/math/ofMatrix3x3.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/math/ofMatrix4x4.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/math/ofQuaternion.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/math/ofVec2f.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/math/ofVec4f.cpp"

    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/types/ofBaseTypes.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/types/ofColor.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/types/ofParameter.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/types/ofParameterGroup.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/types/ofRectangle.cpp"

    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/utils/ofFileUtils.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/utils/ofLog.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/utils/ofMatrixStack.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/utils/ofSystemUtils.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/utils/ofThread.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/utils/ofURLFileLoader.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/utils/ofUtils.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/openframeworks/utils/ofXml.cpp"
)

set(DEFINITIONS
  ${DEFINITIONS}
    -DTARGET_NO_SOUND
    -DTARGET_NO_VIDEO
    -DFREEIMAGE_LIB
    -DPOCO_STATIC
    -DPOCO_NO_AUTOMATIC_LIB_INIT
)

add_definitions(${DEFINITIONS})
include_directories(${INCLUDE_DIRS})

string(REPLACE "\n" " " DEBUG_FLAGS ${DEBUG_FLAGS})

if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
    set(COLORIZATION "-fcolor-diagnostics")
elseif(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
    if(CMAKE_CXX_COMPILER_VERSION VERSION_GREATER "4.9.0")
    set(COLORIZATION "-fdiagnostics-color")
    endif()
endif()

set(CMAKE_C_FLAGS_RELEASE   "${COLORIZATION} ${CMAKE_C_FLAGS_RELEASE}")
set(CMAKE_C_FLAGS_DEBUG     "${COLORIZATION} ${CMAKE_C_FLAGS_DEBUG} ${DEBUG_FLAGS}")
set(CMAKE_CXX_FLAGS_RELEASE "${COLORIZATION} -std=gnu++11 ${CMAKE_CXX_FLAGS_RELEASE}")
set(CMAKE_CXX_FLAGS_DEBUG   "${COLORIZATION} -std=gnu++11 ${CMAKE_CXX_FLAGS_DEBUG} ${DEBUG_FLAGS}")

add_subdirectory(src/poco)
add_subdirectory(src/glfw)
add_subdirectory(src/glew)
add_subdirectory(src/kiss)
add_subdirectory(src/tess2)
add_subdirectory(src/freeimage)
add_subdirectory(src/fontconfig)

add_library(openFrameworks STATIC ${SOURCES})

