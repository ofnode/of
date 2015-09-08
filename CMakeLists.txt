project(openFrameworks)
cmake_minimum_required(VERSION 2.8)

if(NOT DEFINED CMAKE_MACOSX_RPATH)
  set(CMAKE_MACOSX_RPATH 0)
endif()

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/dev/cmake")

#// Options ////////////////////////////////////////////////////////////////////

set(OF_STATIC OFF CACHE BOOL "Link openFrameworks libraries statically")

if(CMAKE_SYSTEM MATCHES Linux)

  set(OF_AUDIO ON CACHE BOOL "Compile audio features of openFrameworks")
  set(OF_VIDEO ON CACHE BOOL "Compile video features of openFrameworks")

elseif(CMAKE_SYSTEM MATCHES Darwin)

  set(OF_AUDIO ON) # Do not turn off
  set(OF_VIDEO ON) # Do not turn off

elseif(CMAKE_SYSTEM MATCHES Windows)

  set(OF_AUDIO ON) # Do not turn off
  set(OF_VIDEO ON) # Do not turn off

  set(OF_32BIT OFF CACHE BOOL "Compile for 32-bit architectures")

endif()

#// GCC and Clang flags ////////////////////////////////////////////////////////

set(RELEASE_FLAGS "
    -Wno-deprecated-declarations
")

set(DEBUG_FLAGS "
    -fno-omit-frame-pointer
    -fno-optimize-sibling-calls
    -Wno-deprecated-declarations
")

#// Clang specific flags ///////////////////////////////////////////////////////

if(CMAKE_C_COMPILER_ID STREQUAL Clang)

set(RELEASE_C_FLAGS_CLANG "
    -Wno-switch
    -Wno-ignored-attributes
    -Wno-deprecated-register
")

set(DEBUG_C_FLAGS_CLANG "
    -Wno-switch
    -Wno-ignored-attributes
    -Wno-deprecated-register
")

endif()

if(CMAKE_CXX_COMPILER_ID STREQUAL Clang)

set(RELEASE_CXX_FLAGS_CLANG "
    -Wno-switch
    -Wno-ignored-attributes
    -Wno-deprecated-register
")

set(DEBUG_CXX_FLAGS_CLANG "
    -Wno-switch
    -Wno-ignored-attributes
    -Wno-deprecated-register
")

endif()

#// Setup //////////////////////////////////////////////////////////////////////

set(OF_ROOT_DIR ${CMAKE_CURRENT_LIST_DIR})

find_package(PkgConfig REQUIRED)

if(NOT CMAKE_BUILD_TYPE)
   set(CMAKE_BUILD_TYPE Release)
endif()

if(CMAKE_SIZEOF_VOID_P EQUAL 8 AND NOT OF_32BIT)
   set(ARCH_BIT 64)
else()
   set(ARCH_BIT 32)
endif()

#// Include directories ////////////////////////////////////////////////////////

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

    "${OF_ROOT_DIR}/src/kissfft"
    "${OF_ROOT_DIR}/src/kissfft/tools"

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

#// Source files ///////////////////////////////////////////////////////////////

set(OPENFRAMEWORKS_SOURCES
    "${OF_ROOT_DIR}/src/openframeworks/3d/of3dPrimitives.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/3d/of3dUtils.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/3d/ofCamera.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/3d/ofEasyCam.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/3d/ofMesh.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/3d/ofNode.cpp"

    "${OF_ROOT_DIR}/src/openframeworks/app/ofAppGLFWWindow.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/app/ofAppNoWindow.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/app/ofAppRunner.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/app/ofMainLoop.cpp"

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
)

if(OF_AUDIO)
  list(APPEND OPENFRAMEWORKS_SOURCES
    "${OF_ROOT_DIR}/src/openframeworks/sound/ofBaseSoundStream.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/sound/ofOpenALSoundPlayer.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/sound/ofRtAudioSoundStream.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/sound/ofSoundBuffer.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/sound/ofSoundPlayer.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/sound/ofSoundStream.cpp"
  )
endif()

if(OF_VIDEO)
  list(APPEND OPENFRAMEWORKS_SOURCES
    "${OF_ROOT_DIR}/src/openframeworks/video/ofVideoGrabber.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/video/ofVideoPlayer.cpp"
  )
if(CMAKE_SYSTEM MATCHES Linux)
  list(APPEND OPENFRAMEWORKS_SOURCES
    "${OF_ROOT_DIR}/src/openframeworks/video/ofGstUtils.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/video/ofGstVideoGrabber.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/video/ofGstVideoPlayer.cpp"
  )
elseif(CMAKE_SYSTEM MATCHES Darwin)
  list(APPEND OPENFRAMEWORKS_SOURCES
    "${OF_ROOT_DIR}/src/openframeworks/video/ofAVFoundationPlayer.mm"
    "${OF_ROOT_DIR}/src/openframeworks/video/ofAVFoundationVideoPlayer.m"
    "${OF_ROOT_DIR}/src/openframeworks/video/ofQTKitGrabber.mm"
  )
elseif(CMAKE_SYSTEM MATCHES Windows)
  list(APPEND OPENFRAMEWORKS_SOURCES
    "${OF_ROOT_DIR}/src/openframeworks/video/ofDirectShowGrabber.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/video/ofDirectShowPlayer.cpp"
  )
endif()
endif(OF_VIDEO)

#// Platform-specific commands /////////////////////////////////////////////////

if(CMAKE_SYSTEM MATCHES Linux)

    if(OF_STATIC)
      set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE "${OF_ROOT_DIR}/lib-linux/release-${ARCH_BIT}")
      set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG   "${OF_ROOT_DIR}/lib-linux/debug-${ARCH_BIT}")
    else()
      set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE "${OF_ROOT_DIR}/lib-linux/release-${ARCH_BIT}")
      set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG   "${OF_ROOT_DIR}/lib-linux/debug-${ARCH_BIT}")
    endif()

    set(OPENFRAMEWORKS_DEFINITIONS
        -DOF_USING_MPG123
        -DOF_SOUND_PLAYER_OPENAL
        -DOF_SOUNDSTREAM_RTAUDIO
        -DOF_VIDEO_PLAYER_GSTREAMER
        -DOF_VIDEO_CAPTURE_GSTREAMER
    )

    pkg_check_modules(CAIRO REQUIRED cairo)
    pkg_check_modules(FONTCONFIG REQUIRED fontconfig)

    find_package(Boost REQUIRED)
    find_package(OpenGL REQUIRED)
    find_package(Freetype REQUIRED)

    list(APPEND OPENFRAMEWORKS_INCLUDE_DIRS
        ${CAIRO_INCLUDE_DIRS}
        ${Boost_INCLUDE_DIRS}
        ${OPENGL_INCLUDE_DIR}
        ${FREETYPE_INCLUDE_DIRS}
        ${FONTCONFIG_INCLUDE_DIRS}
    )

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
    endif()

    if(NOT OF_VIDEO)
      list(APPEND OPENFRAMEWORKS_DEFINITIONS -DTARGET_NO_VIDEO)
    else()
      list(APPEND OPENFRAMEWORKS_DEFINITIONS -DOF_USING_GTK)

      find_package(Glib REQUIRED)
      find_package(GStreamer REQUIRED)
      pkg_check_modules(GTK3 REQUIRED gtk+-3.0)

      list(APPEND OPENFRAMEWORKS_INCLUDE_DIRS
        ${GLIB_INCLUDE_DIRS}
        ${GTK3_INCLUDE_DIRS}
        ${GSTREAMER_INCLUDE_DIRS}
      )
    endif()

elseif(CMAKE_SYSTEM MATCHES Darwin)

    set_source_files_properties(${OPENFRAMEWORKS_SOURCES} PROPERTIES COMPILE_FLAGS "-x objective-c++")

    if(OF_STATIC)
      set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE "${OF_ROOT_DIR}/lib-osx/release-${ARCH_BIT}")
      set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG   "${OF_ROOT_DIR}/lib-osx/debug-${ARCH_BIT}")
    else()
      set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE "${OF_ROOT_DIR}/lib-osx/release-${ARCH_BIT}")
      set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG   "${OF_ROOT_DIR}/lib-osx/debug-${ARCH_BIT}")
    endif()

    set(OPENFRAMEWORKS_DEFINITIONS
        -D__MACOSX_CORE__
        -DOF_USING_MPG123
        -DOF_SOUND_PLAYER_OPENAL
        -DOF_SOUNDSTREAM_RTAUDIO
    )

    set(ENV{PKG_CONFIG_PATH} "$ENV{PKG_CONFIG_PATH}:/usr/local/lib/pkgconfig")

    pkg_check_modules(CAIRO REQUIRED cairo)
    pkg_check_modules(FONTCONFIG REQUIRED fontconfig)

    find_package(Boost REQUIRED)
    find_package(MPG123 REQUIRED)
    find_package(SndFile REQUIRED)
    find_package(Freetype REQUIRED)

    # Add system include dir, see issue #15
    list(APPEND OPENFRAMEWORKS_INCLUDE_DIRS
        "/usr/include"
    )

    # Hardcode FreeType path, see issue #15
    list(APPEND OPENFRAMEWORKS_INCLUDE_DIRS
        "/usr/local/include/freetype2"
    )

    list(APPEND OPENFRAMEWORKS_INCLUDE_DIRS
        ${CAIRO_INCLUDE_DIRS}
        ${Boost_INCLUDE_DIRS}
        ${MPG123_INCLUDE_DIRS}
        ${SNDFILE_INCLUDE_DIR}
        ${FONTCONFIG_INCLUDE_DIRS}
    )

elseif(CMAKE_SYSTEM MATCHES Windows)

    if(OF_STATIC)
      set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE "${OF_ROOT_DIR}/lib-windows/release-${ARCH_BIT}")
      set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG   "${OF_ROOT_DIR}/lib-windows/debug-${ARCH_BIT}")
    else()
      set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE "${OF_ROOT_DIR}/lib-windows/release-${ARCH_BIT}")
      set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG   "${OF_ROOT_DIR}/lib-windows/debug-${ARCH_BIT}")
    endif()

    set(OPENFRAMEWORKS_DEFINITIONS
        -D_WIN32_WINNT=0x0501
        -DOF_USING_MPG123
        -DOF_SOUNDSTREAM_RTAUDIO
        -DOF_SOUND_PLAYER_OPENAL
        -DOF_VIDEO_CAPTURE_DIRECTSHOW
        -DOF_VIDEO_PLAYER_DIRECTSHOW
    )

    pkg_check_modules(CAIRO REQUIRED cairo)
    pkg_check_modules(FONTCONFIG REQUIRED fontconfig)

    find_package(Boost REQUIRED)
    find_package(OpenAL REQUIRED)
    find_package(OpenGL REQUIRED)
    find_package(MPG123 REQUIRED)
    find_package(Freetype REQUIRED)

    list(APPEND OPENFRAMEWORKS_INCLUDE_DIRS
        ${CAIRO_INCLUDE_DIRS}
        ${Boost_INCLUDE_DIRS}
        ${OPENAL_INCLUDE_DIR}
        ${OPENGL_INCLUDE_DIR}
        ${MPG123_INCLUDE_DIRS}
        ${FREETYPE_INCLUDE_DIRS}
        ${FONTCONFIG_INCLUDE_DIRS}
    )

endif()

#// Compiler flags /////////////////////////////////////////////////////////////

list(APPEND OPENFRAMEWORKS_DEFINITIONS
    -DFREEIMAGE_LIB
    -DPOCO_STATIC
)

if(CMAKE_SYSTEM MATCHES Windows)
list(APPEND OPENFRAMEWORKS_DEFINITIONS
    -D_UNICODE
    -DUNICODE
)
endif()

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

if(ARCH_BIT MATCHES 32)
    set(ARCH_FLAG -m32)
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
endif()
if(CMAKE_CXX_COMPILER_ID STREQUAL Clang)
string(REPLACE "\n" " " RELEASE_CXX_FLAGS_CLANG ${RELEASE_CXX_FLAGS_CLANG})
string(REPLACE "\n" " "   DEBUG_CXX_FLAGS_CLANG   ${DEBUG_CXX_FLAGS_CLANG})
endif()

string(REGEX REPLACE " +" " " CMAKE_C_FLAGS_RELEASE   "${C_COLORIZATION} ${CMAKE_C_FLAGS_RELEASE} ${RELEASE_FLAGS} ${RELEASE_C_FLAGS_CLANG} ${ARCH_FLAG} ${PIC_FLAG}")
string(REGEX REPLACE " +" " " CMAKE_C_FLAGS_DEBUG     "${C_COLORIZATION} ${CMAKE_C_FLAGS_DEBUG}     ${DEBUG_FLAGS}   ${DEBUG_C_FLAGS_CLANG} ${ARCH_FLAG} ${PIC_FLAG} ${O_C_FLAG}")

string(REGEX REPLACE " +" " " CMAKE_CXX_FLAGS_RELEASE "${CXX_COLORIZATION} ${CPP11_FLAG} ${CMAKE_CXX_FLAGS_RELEASE} ${RELEASE_FLAGS} ${RELEASE_CXX_FLAGS_CLANG} ${ARCH_FLAG} ${PIC_FLAG}")
string(REGEX REPLACE " +" " " CMAKE_CXX_FLAGS_DEBUG   "${CXX_COLORIZATION} ${CPP11_FLAG} ${CMAKE_CXX_FLAGS_DEBUG}     ${DEBUG_FLAGS}   ${DEBUG_CXX_FLAGS_CLANG} ${ARCH_FLAG} ${PIC_FLAG} ${O_CXX_FLAG}")

#// Build commands /////////////////////////////////////////////////////////////

if(OF_STATIC)
  set(LIB_MODE STATIC)
else()
  set(LIB_MODE SHARED)
endif()

add_subdirectory(src/freeimage)
add_subdirectory(src/glfw)
add_subdirectory(src/poco)

add_library(
    glew ${LIB_MODE}
    "${OF_ROOT_DIR}/src/glew/src/glew.c"
)

target_compile_definitions(
    glew PRIVATE
    -DGLEW_STATIC
    -DGLEW_NO_GLU
)

add_library(
    kissfft ${LIB_MODE}
    "${OF_ROOT_DIR}/src/kissfft/tools/kiss_fftr.c"
    "${OF_ROOT_DIR}/src/kissfft/kiss_fft.c"
)

add_library(
    tess2 ${LIB_MODE}
    "${OF_ROOT_DIR}/src/libtess2/Source/bucketalloc.c"
    "${OF_ROOT_DIR}/src/libtess2/Source/priorityq.c"
    "${OF_ROOT_DIR}/src/libtess2/Source/sweep.c"
    "${OF_ROOT_DIR}/src/libtess2/Source/dict.c"
    "${OF_ROOT_DIR}/src/libtess2/Source/geom.c"
    "${OF_ROOT_DIR}/src/libtess2/Source/mesh.c"
    "${OF_ROOT_DIR}/src/libtess2/Source/tess.c"
)

add_library(
    rtaudio ${LIB_MODE}
    "${OF_ROOT_DIR}/src/rtaudio/RtAudio.cpp"
)

if(CMAKE_SYSTEM MATCHES Linux)
target_compile_definitions(
    rtaudio PRIVATE
    -D__LINUX_ALSA__
)
elseif(CMAKE_SYSTEM MATCHES Darwin)
target_compile_definitions(
    rtaudio PRIVATE
    -D__MACOSX_CORE__
    -DHAVE_GETTIMEOFDAY
)
elseif(CMAKE_SYSTEM MATCHES Windows)
target_compile_definitions(
    rtaudio PRIVATE
    -D__WINDOWS_DS__
)
endif()

add_library(
    openFrameworks ${LIB_MODE}
    ${OPENFRAMEWORKS_SOURCES}
)

target_compile_definitions(
    openFrameworks PRIVATE
    ${OPENFRAMEWORKS_DEFINITIONS}
)

if(CMAKE_BUILD_TYPE MATCHES Release)
set_target_properties(
    openFrameworks PROPERTIES
    COMPILE_FLAGS -g1
)
endif()

if(CMAKE_SYSTEM MATCHES Windows)
add_library(
  videoinput ${LIB_MODE}
  "${OF_ROOT_DIR}/src/videoinput/videoInput.cpp"
)
endif()

#// Shared library linking /////////////////////////////////////////////////////

if(NOT OF_STATIC)

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
  find_package(Boost COMPONENTS filesystem system REQUIRED)

  if(CMAKE_SYSTEM MATCHES Windows)
  find_library(WINMM_LIB winmm)
  find_library(GDI32_LIB gdi32)
  find_library(DSOUND_LIB dsound)
  find_library(WS2_32_LIB ws2_32)
  find_library(CRYPT32_LIB crypt32)
  find_library(WSOCK32_LIB wsock32)
  find_library(IPHLPAPI_LIB iphlpapi)
  find_library(SETUPAPI_LIB setupapi)
  find_library(STRMIIDS_LIB strmiids)
  endif()

  target_link_libraries(
      glew
      ${OPENGL_LIBRARIES}
  )

  if(CMAKE_SYSTEM MATCHES Linux)
  find_package(ALSA)
  target_link_libraries(
      rtaudio
      ${ALSA_LIBRARY}
      ${CMAKE_THREAD_LIBS_INIT}
  )
  elseif(CMAKE_SYSTEM MATCHES Darwin)
  find_library(COREAUDIO_LIB CoreAudio)
  find_library(COREFOUNDATION_LIB CoreFoundation)
  target_link_libraries(
      rtaudio
      ${COREAUDIO_LIB}
      ${COREFOUNDATION_LIB}
  )
  elseif(CMAKE_SYSTEM MATCHES Windows)
  target_link_libraries(
      rtaudio
      ${WINMM_LIB}
      ${DSOUND_LIB}
  )
  endif()

  if(CMAKE_SYSTEM MATCHES Windows)
  target_link_libraries(
      videoinput
      ${STRMIIDS_LIB}
  )
  endif()

  add_dependencies(
      openFrameworks
      freeimage
      glew
      glfw
      kissfft
      tess2
      PocoCrypto
      PocoFoundation
      PocoJSON
      PocoNet
      PocoNetSSL
      PocoUtil
      PocoXML
      rtaudio
  )

  if(CMAKE_SYSTEM MATCHES Windows)
  add_dependencies(
      openFrameworks
      videoinput
  )
  endif()

  set(OPENFRAMEWORKS_LIBRARIES
      freeimage
      glew
      glfw
      kissfft
      tess2
      PocoCrypto
      PocoFoundation
      PocoJSON
      PocoNet
      PocoNetSSL
      PocoUtil
      PocoXML
      rtaudio
  )

  if(CMAKE_SYSTEM MATCHES Windows)
  list(APPEND OPENFRAMEWORKS_LIBRARIES
      videoinput
  )
  endif()

  if(CMAKE_SYSTEM MATCHES Darwin)
  list(APPEND OPENFRAMEWORKS_LIBRARIES
      -L/usr/local/lib
  )
  endif()

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
      ${Boost_SYSTEM_LIBRARY}
      ${Boost_FILESYSTEM_LIBRARY}
      ${CMAKE_THREAD_LIBS_INIT}
  )

  if(CMAKE_SYSTEM MATCHES Windows)
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
  endif()

  if(CMAKE_SYSTEM MATCHES Darwin)
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
  endif()

  target_link_libraries(
      openFrameworks
      ${OPENFRAMEWORKS_LIBRARIES}
  )

endif()

#// Messages ///////////////////////////////////////////////////////////////////

message(STATUS "OF_STATIC: " ${OF_STATIC})

if(CMAKE_SYSTEM MATCHES Linux)
message(STATUS "OF_AUDIO: " ${OF_AUDIO})
message(STATUS "OF_VIDEO: " ${OF_VIDEO})
endif()

message(STATUS "CMAKE_BUILD_TYPE: "      ${CMAKE_BUILD_TYPE})
message(STATUS "CMAKE_C_COMPILER_ID: "   ${CMAKE_C_COMPILER_ID})
message(STATUS "CMAKE_CXX_COMPILER_ID: " ${CMAKE_CXX_COMPILER_ID})

