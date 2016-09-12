project(openFrameworks)
cmake_minimum_required(VERSION 2.8)

if(NOT DEFINED CMAKE_MACOSX_RPATH)
  set(CMAKE_MACOSX_RPATH 0)
endif()

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/dev/cmake")

#// Options ////////////////////////////////////////////////////////////////////

set(OF_STATIC OFF CACHE BOOL "Link openFrameworks libraries statically")

set(OF_PLATFORM x86 CACHE STRING "Platform architecture. No need to be modified by default.")

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
  -Wno-narrowing
  -Wno-deprecated-declarations
")

set(DEBUG_FLAGS "
  -Wno-narrowing
  -fno-omit-frame-pointer
  -fno-optimize-sibling-calls
  -Wno-deprecated-declarations
")

#// GCC specific flags /////////////////////////////////////////////////////////

if(CMAKE_C_COMPILER_ID STREQUAL GNU)

  set(RELEASE_C_FLAGS_GCC "
    -Wno-psabi
  ")

  set(DEBUG_C_FLAGS_GCC "
    -Wno-psabi
  ")

endif()

if(CMAKE_CXX_COMPILER_ID STREQUAL GNU)

  set(RELEASE_CXX_FLAGS_GCC "
    -Wno-psabi
  ")

  set(DEBUG_CXX_FLAGS_GCC "
    -Wno-psabi
  ")

endif()

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

    "${OF_ROOT_DIR}/src/freeimage/Source"
    "${OF_ROOT_DIR}/src/freeimage/Source/DeprecationManager"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibOpenJPEG"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibPNG"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibRawLite"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibTIFF4"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/Half"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/Iex"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IexMath"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmThread"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/Imath"

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

if(OF_PLATFORM MATCHES armv7)
  list(APPEND OPENFRAMEWORKS_SOURCES
    "${OF_ROOT_DIR}/src/openframeworks/app/ofAppEGLWindow.cpp"
  )
else()
  list(APPEND OPENFRAMEWORKS_SOURCES
    "${OF_ROOT_DIR}/src/openframeworks/app/ofAppGLFWWindow.cpp"
  )
endif()

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

set(FREEIMAGE_SOURCES
    "${OF_ROOT_DIR}/src/freeimage/Source/DeprecationManager/Deprecated.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/DeprecationManager/DeprecationMgr.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/BitmapAccess.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/ColorLookup.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/FreeImage.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/FreeImageIO.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/GetType.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/MemoryIO.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/PixelAccess.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/J2KHelper.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/MNGHelper.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/Plugin.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/PluginBMP.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/PluginCUT.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/PluginDDS.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/PluginEXR.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/PluginG3.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/PluginGIF.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/PluginHDR.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/PluginICO.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/PluginIFF.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/PluginJ2K.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/PluginJNG.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/PluginJP2.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/PluginJPEG.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/PluginKOALA.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/PluginMNG.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/PluginPCD.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/PluginPCX.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/PluginPFM.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/PluginPICT.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/PluginPNG.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/PluginPNM.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/PluginPSD.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/PluginRAS.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/PluginRAW.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/PluginSGI.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/PluginTARGA.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/PluginTIFF.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/PluginWBMP.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/PluginWebP.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/PluginXBM.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/PluginXPM.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/PSDParser.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/TIFFLogLuv.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/Conversion.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/Conversion16_555.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/Conversion16_565.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/Conversion24.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/Conversion32.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/Conversion4.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/Conversion8.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/ConversionFloat.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/ConversionRGB16.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/ConversionRGBA16.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/ConversionRGBAF.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/ConversionRGBF.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/ConversionType.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/ConversionUINT16.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/Halftoning.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/tmoColorConvert.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/tmoDrago03.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/tmoFattal02.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/tmoReinhard05.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/ToneMapping.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/LFPQuantizer.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/NNQuantizer.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/WuQuantizer.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/CacheFile.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/MultiPage.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImage/ZLibInterface.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImageToolkit/Background.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImageToolkit/BSplineRotate.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImageToolkit/Channels.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImageToolkit/ClassicRotate.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImageToolkit/Colors.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImageToolkit/CopyPaste.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImageToolkit/Display.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImageToolkit/Flip.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImageToolkit/JPEGTransform.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImageToolkit/MultigridPoissonSolver.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImageToolkit/Rescale.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/FreeImageToolkit/Resize.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/Metadata/Exif.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/Metadata/FIRational.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/Metadata/FreeImageTag.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/Metadata/IPTC.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/Metadata/TagConversion.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/Metadata/TagLib.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/Metadata/XTIFF.cpp"

    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG/jaricom.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG/jcapimin.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG/jcapistd.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG/jcarith.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG/jccoefct.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG/jccolor.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG/jcdctmgr.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG/jchuff.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG/jcinit.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG/jcmainct.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG/jcmarker.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG/jcmaster.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG/jcomapi.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG/jcparam.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG/jcprepct.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG/jcsample.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG/jctrans.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG/jdapimin.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG/jdapistd.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG/jdarith.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG/jdatadst.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG/jdatasrc.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG/jdcoefct.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG/jdcolor.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG/jddctmgr.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG/jdhuff.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG/jdinput.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG/jdmainct.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG/jdmarker.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG/jdmaster.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG/jdmerge.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG/jdpostct.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG/jdsample.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG/jdtrans.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG/jerror.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG/jfdctflt.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG/jfdctfst.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG/jfdctint.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG/jidctflt.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG/jidctfst.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG/jidctint.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG/jmemmgr.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG/jmemnobs.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG/jquant1.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG/jquant2.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG/jutils.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibJPEG/transupp.c"

    "${OF_ROOT_DIR}/src/freeimage/Source/LibOpenJPEG/bio.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibOpenJPEG/cio.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibOpenJPEG/dwt.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibOpenJPEG/event.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibOpenJPEG/function_list.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibOpenJPEG/image.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibOpenJPEG/invert.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibOpenJPEG/j2k.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibOpenJPEG/jp2.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibOpenJPEG/mct.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibOpenJPEG/mqc.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibOpenJPEG/openjpeg.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibOpenJPEG/opj_clock.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibOpenJPEG/pi.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibOpenJPEG/raw.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibOpenJPEG/t1.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibOpenJPEG/t2.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibOpenJPEG/tcd.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibOpenJPEG/tgt.c"

    "${OF_ROOT_DIR}/src/freeimage/Source/LibPNG/png.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibPNG/pngerror.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibPNG/pngget.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibPNG/pngmem.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibPNG/pngpread.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibPNG/pngread.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibPNG/pngrio.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibPNG/pngrtran.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibPNG/pngrutil.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibPNG/pngset.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibPNG/pngtrans.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibPNG/pngwio.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibPNG/pngwrite.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibPNG/pngwtran.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibPNG/pngwutil.c"

    "${OF_ROOT_DIR}/src/freeimage/Source/LibRawLite/internal/dcraw_common.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibRawLite/internal/dcraw_fileio.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibRawLite/internal/demosaic_packs.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibRawLite/src/libraw_c_api.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibRawLite/src/libraw_cxx.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibRawLite/src/libraw_datastream.cpp"

    "${OF_ROOT_DIR}/src/freeimage/Source/LibTIFF4/tif_aux.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibTIFF4/tif_close.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibTIFF4/tif_codec.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibTIFF4/tif_color.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibTIFF4/tif_compress.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibTIFF4/tif_dir.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibTIFF4/tif_dirinfo.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibTIFF4/tif_dirread.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibTIFF4/tif_dirwrite.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibTIFF4/tif_dumpmode.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibTIFF4/tif_error.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibTIFF4/tif_extension.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibTIFF4/tif_fax3.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibTIFF4/tif_fax3sm.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibTIFF4/tif_flush.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibTIFF4/tif_getimage.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibTIFF4/tif_jpeg.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibTIFF4/tif_luv.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibTIFF4/tif_lzma.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibTIFF4/tif_lzw.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibTIFF4/tif_next.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibTIFF4/tif_ojpeg.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibTIFF4/tif_open.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibTIFF4/tif_packbits.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibTIFF4/tif_pixarlog.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibTIFF4/tif_predict.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibTIFF4/tif_print.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibTIFF4/tif_read.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibTIFF4/tif_strip.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibTIFF4/tif_swab.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibTIFF4/tif_thunder.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibTIFF4/tif_tile.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibTIFF4/tif_version.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibTIFF4/tif_warning.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibTIFF4/tif_write.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibTIFF4/tif_zip.c"

    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/dec/dec.alpha.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/dec/dec.buffer.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/dec/dec.frame.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/dec/dec.idec.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/dec/dec.io.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/dec/dec.quant.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/dec/dec.tree.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/dec/dec.vp8.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/dec/dec.vp8l.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/dec/dec.webp.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/dsp/dsp.alpha_processing.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/dsp/dsp.alpha_processing_sse2.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/dsp/dsp.argb.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/dsp/dsp.argb_sse2.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/dsp/dsp.cost.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/dsp/dsp.cost_sse2.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/dsp/dsp.cpu.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/dsp/dsp.dec.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/dsp/dsp.dec_clip_tables.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/dsp/dsp.dec_neon.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/dsp/dsp.dec_sse2.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/dsp/dsp.enc.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/dsp/dsp.enc_avx2.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/dsp/dsp.enc_neon.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/dsp/dsp.enc_sse2.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/dsp/dsp.filters.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/dsp/dsp.filters_sse2.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/dsp/dsp.lossless.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/dsp/dsp.lossless_neon.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/dsp/dsp.lossless_sse2.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/dsp/dsp.rescaler.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/dsp/dsp.upsampling.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/dsp/dsp.upsampling_neon.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/dsp/dsp.upsampling_sse2.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/dsp/dsp.yuv.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/dsp/dsp.yuv_sse2.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/enc/enc.alpha.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/enc/enc.analysis.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/enc/enc.backward_references.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/enc/enc.config.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/enc/enc.cost.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/enc/enc.filter.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/enc/enc.frame.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/enc/enc.histogram.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/enc/enc.iterator.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/enc/enc.near_lossless.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/enc/enc.picture.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/enc/enc.picture_csp.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/enc/enc.picture_psnr.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/enc/enc.picture_rescale.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/enc/enc.picture_tools.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/enc/enc.quant.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/enc/enc.syntax.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/enc/enc.token.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/enc/enc.tree.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/enc/enc.vp8l.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/enc/enc.webpenc.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/utils/utils.bit_reader.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/utils/utils.bit_writer.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/utils/utils.color_cache.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/utils/utils.filters.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/utils/utils.huffman.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/utils/utils.huffman_encode.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/utils/utils.quant_levels.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/utils/utils.quant_levels_dec.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/utils/utils.random.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/utils/utils.rescaler.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/utils/utils.thread.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/utils/utils.utils.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/mux/mux.anim_encode.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/mux/mux.muxedit.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/mux/mux.muxinternal.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/mux/mux.muxread.c"
    "${OF_ROOT_DIR}/src/freeimage/Source/LibWebP/src/demux/demux.demux.c"

    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/b44ExpLogTable.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfAcesFile.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfAttribute.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfB44Compressor.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfBoxAttribute.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfChannelList.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfChannelListAttribute.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfChromaticities.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfChromaticitiesAttribute.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfCompositeDeepScanLine.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfCompressionAttribute.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfCompressor.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfConvert.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfCRgbaFile.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfDeepCompositing.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfDeepFrameBuffer.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfDeepImageStateAttribute.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfDeepScanLineInputFile.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfDeepScanLineInputPart.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfDeepScanLineOutputFile.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfDeepScanLineOutputPart.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfDeepTiledInputFile.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfDeepTiledInputPart.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfDeepTiledOutputFile.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfDeepTiledOutputPart.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfDoubleAttribute.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfDwaCompressor.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfEnvmap.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfEnvmapAttribute.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfFastHuf.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfFloatAttribute.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfFloatVectorAttribute.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfFrameBuffer.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfFramesPerSecond.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfGenericInputFile.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfGenericOutputFile.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfHeader.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfHuf.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfInputFile.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfInputPart.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfInputPartData.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfIntAttribute.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfIO.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfKeyCode.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfKeyCodeAttribute.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfLineOrderAttribute.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfLut.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfMatrixAttribute.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfMisc.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfMultiPartInputFile.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfMultiPartOutputFile.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfMultiView.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfOpaqueAttribute.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfOutputFile.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfOutputPart.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfOutputPartData.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfPartType.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfPizCompressor.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfPreviewImage.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfPreviewImageAttribute.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfPxr24Compressor.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfRational.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfRationalAttribute.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfRgbaFile.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfRgbaYca.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfRle.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfRleCompressor.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfScanLineInputFile.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfStandardAttributes.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfStdIO.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfStringAttribute.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfStringVectorAttribute.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfSystemSpecific.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfTestFile.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfThreading.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfTileDescriptionAttribute.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfTiledInputFile.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfTiledInputPart.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfTiledMisc.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfTiledOutputFile.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfTiledOutputPart.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfTiledRgbaFile.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfTileOffsets.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfTimeCode.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfTimeCodeAttribute.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfVecAttribute.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfVersion.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfWav.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfZip.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmImf/ImfZipCompressor.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/Imath/ImathBox.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/Imath/ImathColorAlgo.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/Imath/ImathFun.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/Imath/ImathMatrixAlgo.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/Imath/ImathRandom.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/Imath/ImathShear.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/Imath/ImathVec.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/Iex/IexBaseExc.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/Iex/IexThrowErrnoExc.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/Half/half.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmThread/IlmThread.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmThread/IlmThreadMutex.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmThread/IlmThreadPool.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IlmThread/IlmThreadSemaphore.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IexMath/IexMathFloatExc.cpp"
    "${OF_ROOT_DIR}/src/freeimage/Source/OpenEXR/IexMath/IexMathFpu.cpp"
)

set_source_files_properties(${FREEIMAGE_SOURCES} PROPERTIES COMPILE_FLAGS -w)

set(KISSFFT_SOURCES
    "${OF_ROOT_DIR}/src/kissfft/tools/kiss_fftr.c"
    "${OF_ROOT_DIR}/src/kissfft/kiss_fft.c"
)

set(LIBTESS2_SOURCES
    "${OF_ROOT_DIR}/src/libtess2/Source/bucketalloc.c"
    "${OF_ROOT_DIR}/src/libtess2/Source/priorityq.c"
    "${OF_ROOT_DIR}/src/libtess2/Source/sweep.c"
    "${OF_ROOT_DIR}/src/libtess2/Source/dict.c"
    "${OF_ROOT_DIR}/src/libtess2/Source/geom.c"
    "${OF_ROOT_DIR}/src/libtess2/Source/mesh.c"
    "${OF_ROOT_DIR}/src/libtess2/Source/tess.c"
)

if(CMAKE_SYSTEM MATCHES Windows)
set(VIDEOINPUT_SOURCES
  "${OF_ROOT_DIR}/src/videoinput/videoInput.cpp"
)
endif()

if(OF_AUDIO)
set(RTAUDIO_SOURCES
    "${OF_ROOT_DIR}/src/rtaudio/RtAudio.cpp"
)
endif()

if(OF_PLATFORM MATCHES x86)
set(GLEW_SOURCES
    "${OF_ROOT_DIR}/src/glew/src/glew.c"
)
endif()

#// Platform-specific commands /////////////////////////////////////////////////

if(CMAKE_SYSTEM MATCHES Linux)

    if(OF_STATIC)
      set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE "${OF_ROOT_DIR}/lib-linux/release-${OF_PLATFORM}-${ARCH_BIT}")
      set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG   "${OF_ROOT_DIR}/lib-linux/debug-${OF_PLATFORM}-${ARCH_BIT}")
    else()
      set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE "${OF_ROOT_DIR}/lib-linux/release-${OF_PLATFORM}-${ARCH_BIT}")
      set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG   "${OF_ROOT_DIR}/lib-linux/debug-${OF_PLATFORM}-${ARCH_BIT}")
    endif()

    set(OPENFRAMEWORKS_DEFINITIONS
        -DOF_USING_MPG123
        -DOF_SOUND_PLAYER_OPENAL
        -DOF_SOUNDSTREAM_RTAUDIO
        -DOF_VIDEO_PLAYER_GSTREAMER
        -DOF_VIDEO_CAPTURE_GSTREAMER
    )

    if(OF_PLATFORM MATCHES armv7)
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

    pkg_check_modules(CAIRO REQUIRED cairo)
    pkg_check_modules(FONTCONFIG REQUIRED fontconfig)

    if(OF_PLATFORM MATCHES armv7)
    find_package(OpenGLES REQUIRED)
    else()
    find_package(OpenGL REQUIRED)
    endif()

    find_package(Freetype REQUIRED)
    find_package(Boost COMPONENTS filesystem system REQUIRED)

    list(APPEND OPENFRAMEWORKS_INCLUDE_DIRS
        ${CAIRO_INCLUDE_DIRS}
        ${Boost_INCLUDE_DIRS}
        ${OPENGL_INCLUDE_DIR}
        ${FREETYPE_INCLUDE_DIRS}
        ${FONTCONFIG_INCLUDE_DIRS}
    )

    if(OF_PLATFORM MATCHES armv7)
      list(APPEND OPENFRAMEWORKS_INCLUDE_DIRS
        ${EGL_INCLUDE_DIR}
        ${OPENGLES2_INCLUDE_DIR}
      )
      # Assuming Raspberry Pi 2 and Raspbian
      list(APPEND OPENFRAMEWORKS_INCLUDE_DIRS
        /opt/vc/include
        /opt/vc/include/IL
        /opt/vc/include/interface/vcos/pthreads
        /opt/vc/include/interface/vmcs_host/linux
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
    endif()

    if(NOT OF_VIDEO)
      list(APPEND OPENFRAMEWORKS_DEFINITIONS -DTARGET_NO_VIDEO)
    else()

      find_package(UDev REQUIRED)
      find_package(Glib REQUIRED)
      find_package(GStreamer REQUIRED)

      list(APPEND OPENFRAMEWORKS_INCLUDE_DIRS
        ${UDEV_INCLUDE_DIR}
        ${GLIB_INCLUDE_DIRS}
        ${GSTREAMER_INCLUDE_DIRS}
      )

      if ( OF_GTK )
        list(APPEND OPENFRAMEWORKS_DEFINITIONS -DOF_USING_GTK)
        pkg_check_modules(GTK3 REQUIRED gtk+-3.0)
        list(APPEND OPENFRAMEWORKS_INCLUDE_DIRS ${GTK3_INCLUDE_DIRS} )
        list(APPEND OPENFRAMEWORKS_LIBRARIES ${GTK3_LIBRARIES} )
      endif()
    endif()

elseif(CMAKE_SYSTEM MATCHES Darwin)

    set_source_files_properties(${OPENFRAMEWORKS_SOURCES} PROPERTIES COMPILE_FLAGS "-x objective-c++")

    if(OF_STATIC)
      set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE "${OF_ROOT_DIR}/lib-osx/release-${OF_PLATFORM}-${ARCH_BIT}")
      set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG   "${OF_ROOT_DIR}/lib-osx/debug-${OF_PLATFORM}-${ARCH_BIT}")
    else()
      set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE "${OF_ROOT_DIR}/lib-osx/release-${OF_PLATFORM}-${ARCH_BIT}")
      set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG   "${OF_ROOT_DIR}/lib-osx/debug-${OF_PLATFORM}-${ARCH_BIT}")
    endif()

    set(OPENFRAMEWORKS_DEFINITIONS
        -DOF_USING_MPG123
        -DOF_SOUND_PLAYER_OPENAL
        -DOF_SOUNDSTREAM_RTAUDIO
    )

    set(ENV{PKG_CONFIG_PATH} "$ENV{PKG_CONFIG_PATH}:/usr/local/lib/pkgconfig")

    pkg_check_modules(CAIRO REQUIRED cairo)
    pkg_check_modules(FONTCONFIG REQUIRED fontconfig)

    set(ENV{OPENSSL_ROOT_DIR} "/usr/local/opt/openssl")
    find_package(OpenGL REQUIRED)
    find_package(MPG123 REQUIRED)
    find_package(OpenSSL REQUIRED)
    find_package(SndFile REQUIRED)
    find_package(Freetype REQUIRED)
    find_package(Boost COMPONENTS filesystem system REQUIRED)

    # Hardcode FreeType path, see issue #15
    list(APPEND OPENFRAMEWORKS_INCLUDE_DIRS
        "/usr/local/include/freetype2"
    )

    list(APPEND OPENFRAMEWORKS_INCLUDE_DIRS
        ${CAIRO_INCLUDE_DIRS}
        ${Boost_INCLUDE_DIRS}
        ${OPENGL_INCLUDE_DIR}
        ${OPENSSL_INCLUDE_DIR}
        ${MPG123_INCLUDE_DIRS}
        ${SNDFILE_INCLUDE_DIR}
        ${FONTCONFIG_INCLUDE_DIRS}
    )

elseif(CMAKE_SYSTEM MATCHES Windows)

    if(OF_STATIC)
      set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE "${OF_ROOT_DIR}/lib-windows/release-${OF_PLATFORM}-${ARCH_BIT}")
      set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG   "${OF_ROOT_DIR}/lib-windows/debug-${OF_PLATFORM}-${ARCH_BIT}")
    else()
      set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE "${OF_ROOT_DIR}/lib-windows/release-${OF_PLATFORM}-${ARCH_BIT}")
      set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG   "${OF_ROOT_DIR}/lib-windows/debug-${OF_PLATFORM}-${ARCH_BIT}")
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

    find_package(OpenAL REQUIRED)
    find_package(OpenGL REQUIRED)
    find_package(MPG123 REQUIRED)
    find_package(Freetype REQUIRED)
    find_package(Boost COMPONENTS filesystem system REQUIRED)

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

if(OF_PLATFORM MATCHES x86)
list(APPEND OPENFRAMEWORKS_DEFINITIONS
    -DGLEW_STATIC
    -DGLEW_NO_GLU
)
endif()

if(CMAKE_SYSTEM MATCHES Linux)
list(APPEND OPENFRAMEWORKS_DEFINITIONS
    -D__ANSI__
    -D__LINUX_ALSA__
)
elseif(CMAKE_SYSTEM MATCHES Darwin)
list(APPEND OPENFRAMEWORKS_DEFINITIONS
    -D__MACOSX_CORE__
    -DHAVE_GETTIMEOFDAY
)
elseif(CMAKE_SYSTEM MATCHES Windows)
list(APPEND OPENFRAMEWORKS_DEFINITIONS
    -DWIN32
    -DWINVER=0x0500
    -D_WIN32_WINNT=0x0501
    -D_UNICODE
    -DUNICODE
    -D__WINDOWS_DS__
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

if(OF_PLATFORM MATCHES armv7)
    set(ARCH_FLAG "-march=armv7-a -mfpu=vfp -mfloat-abi=hard")
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

string(REGEX REPLACE " +" " " CMAKE_C_FLAGS_RELEASE "${C_COLORIZATION} ${CMAKE_C_FLAGS_RELEASE} ${RELEASE_FLAGS} ${RELEASE_C_FLAGS_CLANG} ${RELEASE_C_FLAGS_GCC} ${ARCH_FLAG} ${PIC_FLAG}" )
string(REGEX REPLACE " +" " " CMAKE_C_FLAGS_DEBUG   "${C_COLORIZATION} ${CMAKE_C_FLAGS_DEBUG}     ${DEBUG_FLAGS}   ${DEBUG_C_FLAGS_CLANG}   ${DEBUG_C_FLAGS_GCC} ${ARCH_FLAG} ${PIC_FLAG} ${O_C_FLAG}")

string(REGEX REPLACE " +" " " CMAKE_CXX_FLAGS_RELEASE "${CXX_COLORIZATION} ${CPP11_FLAG} ${CMAKE_CXX_FLAGS_RELEASE} ${RELEASE_FLAGS} ${RELEASE_CXX_FLAGS_CLANG} ${RELEASE_CXX_FLAGS_GCC} ${ARCH_FLAG} ${PIC_FLAG}")
string(REGEX REPLACE " +" " " CMAKE_CXX_FLAGS_DEBUG   "${CXX_COLORIZATION} ${CPP11_FLAG} ${CMAKE_CXX_FLAGS_DEBUG}     ${DEBUG_FLAGS}   ${DEBUG_CXX_FLAGS_CLANG}   ${DEBUG_CXX_FLAGS_GCC} ${ARCH_FLAG} ${PIC_FLAG} ${O_CXX_FLAG}")

#// Build commands /////////////////////////////////////////////////////////////

if(OF_STATIC)
  set(LIB_MODE STATIC)
else()
  set(LIB_MODE SHARED)
endif()

add_subdirectory(src/poco)

if(OF_PLATFORM MATCHES x86)
add_subdirectory(src/glfw)
endif()

add_library(
    openFrameworks ${LIB_MODE}
    ${OPENFRAMEWORKS_SOURCES}
    ${VIDEOINPUT_SOURCES}
    ${FREEIMAGE_SOURCES}
    ${LIBTESS2_SOURCES}
    ${KISSFFT_SOURCES}
    ${RTAUDIO_SOURCES}
    ${GLEW_SOURCES}
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

#// Shared library linking /////////////////////////////////////////////////////

if(NOT OF_STATIC)

  add_dependencies(
      openFrameworks
      PocoCrypto
      PocoFoundation
      PocoJSON
      PocoNet
      PocoNetSSL
      PocoUtil
      PocoXML
  )

  if(OF_PLATFORM MATCHES x86)
    add_dependencies(
      openFrameworks
      glfw
    )
  endif()

  if(CMAKE_SYSTEM MATCHES Windows)
    add_dependencies(
      openFrameworks
      videoinput
    )
  endif()

  if(CMAKE_SYSTEM MATCHES Windows)
    target_link_libraries(
      videoinput
      ${STRMIIDS_LIB}
    )
  endif()

  set(OPENFRAMEWORKS_LIBRARIES
      PocoCrypto
      PocoFoundation
      PocoJSON
      PocoNet
      PocoNetSSL
      PocoUtil
      PocoXML
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

  find_package(ZLIB REQUIRED)

  list(APPEND OPENFRAMEWORKS_LIBRARIES
      ${ALSA_LIBRARY}
      ${UDEV_LIBRARIES}
      ${GLIB_LIBRARIES}
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
      ${GSTREAMER_LIBRARIES}
      ${GSTREAMER_APP_LIBRARIES}
      ${GSTREAMER_BASE_LIBRARIES}
      ${GSTREAMER_VIDEO_LIBRARIES}
  )

  if(OF_PLATFORM MATCHES x86)
  list(APPEND OPENFRAMEWORKS_LIBRARIES
      glfw
  )
  endif()

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
  endif()

  target_link_libraries(
      openFrameworks
      ${OPENFRAMEWORKS_LIBRARIES}
  )

endif(NOT OF_STATIC)

#// Messages ///////////////////////////////////////////////////////////////////

message(STATUS "OF_PLATFORM: " ${OF_PLATFORM})
message(STATUS "OF_STATIC: " ${OF_STATIC})

if(CMAKE_SYSTEM MATCHES Linux)
message(STATUS "OF_AUDIO: " ${OF_AUDIO})
message(STATUS "OF_VIDEO: " ${OF_VIDEO})
message(STATUS "OF_GTK: " ${OF_GTK})
endif()

message(STATUS "CMAKE_BUILD_TYPE: "      ${CMAKE_BUILD_TYPE})
message(STATUS "CMAKE_C_COMPILER_ID: "   ${CMAKE_C_COMPILER_ID})
message(STATUS "CMAKE_CXX_COMPILER_ID: " ${CMAKE_CXX_COMPILER_ID})
