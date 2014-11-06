cmake_minimum_required(VERSION 2.6)

project(freeimage)

find_package(ZLIB REQUIRED)

# Process subdirectories
add_subdirectory(LibJPEG)
add_subdirectory(LibOpenJPEG)
add_subdirectory(LibPNG)
add_subdirectory(LibTIFF4)
add_subdirectory(LibWebP)
add_subdirectory(OpenEXR/Half)
add_subdirectory(OpenEXR/Iex)
add_subdirectory(OpenEXR/IlmImf)
add_subdirectory(OpenEXR/IlmThread)
add_subdirectory(OpenEXR/Imath)

# List the header files
set(HEADERS CacheFile.h
            FreeImage.h
            FreeImageIO.h
            Plugin.h
            Quantizers.h
            ToneMapping.h
            Utilities.h
            FreeImage/PSDParser.h
            FreeImageToolkit/Filters.h
            FreeImageToolkit/Resize.h
            Metadata/FIRational.h
            Metadata/FreeImageTag.h
)

# List the source files
set(SRCS FreeImage/BitmapAccess.cpp
         FreeImage/CacheFile.cpp
         FreeImage/ColorLookup.cpp
         FreeImage/Conversion.cpp
         FreeImage/Conversion16_555.cpp
         FreeImage/Conversion16_565.cpp
         FreeImage/Conversion24.cpp
         FreeImage/Conversion32.cpp
         FreeImage/Conversion4.cpp
         FreeImage/Conversion8.cpp
         FreeImage/ConversionFloat.cpp
         FreeImage/ConversionRGB16.cpp
         FreeImage/ConversionRGBF.cpp
         FreeImage/ConversionType.cpp
         FreeImage/ConversionUINT16.cpp
         FreeImage/FreeImage.cpp
         FreeImage/FreeImageIO.cpp
         FreeImage/GetType.cpp
         FreeImage/Halftoning.cpp
         FreeImage/J2KHelper.cpp
         FreeImage/MemoryIO.cpp
         FreeImage/MNGHelper.cpp
         FreeImage/MultiPage.cpp
         FreeImage/NNQuantizer.cpp
         FreeImage/PSDParser.cpp
         FreeImage/PixelAccess.cpp
         FreeImage/Plugin.cpp
         FreeImage/PluginBMP.cpp
         FreeImage/PluginCUT.cpp
         FreeImage/PluginDDS.cpp
         FreeImage/PluginEXR.cpp
         FreeImage/PluginG3.cpp
         FreeImage/PluginGIF.cpp
         FreeImage/PluginHDR.cpp
         FreeImage/PluginICO.cpp
         FreeImage/PluginIFF.cpp
         FreeImage/PluginJ2K.cpp
         FreeImage/PluginJNG.cpp
         FreeImage/PluginJP2.cpp
         FreeImage/PluginJPEG.cpp
         FreeImage/PluginKOALA.cpp
         FreeImage/PluginMNG.cpp
         FreeImage/PluginPCD.cpp
         FreeImage/PluginPCX.cpp
         FreeImage/PluginPFM.cpp
         FreeImage/PluginPICT.cpp
         FreeImage/PluginPNG.cpp
         FreeImage/PluginPNM.cpp
         FreeImage/PluginPSD.cpp
         FreeImage/PluginRAS.cpp
         FreeImage/PluginSGI.cpp
         FreeImage/PluginTARGA.cpp
         FreeImage/PluginTIFF.cpp
         FreeImage/PluginWBMP.cpp
         FreeImage/PluginWebP.cpp
         FreeImage/PluginXBM.cpp
         FreeImage/PluginXPM.cpp
         FreeImage/TIFFLogLuv.cpp
         FreeImage/ToneMapping.cpp
         FreeImage/WuQuantizer.cpp
         FreeImage/ZLibInterface.cpp
         FreeImage/tmoColorConvert.cpp
         FreeImage/tmoDrago03.cpp
         FreeImage/tmoFattal02.cpp
         FreeImage/tmoReinhard05.cpp
         FreeImageToolkit/BSplineRotate.cpp
         FreeImageToolkit/Background.cpp
         FreeImageToolkit/Channels.cpp
         FreeImageToolkit/ClassicRotate.cpp
         FreeImageToolkit/Colors.cpp
         FreeImageToolkit/CopyPaste.cpp
         FreeImageToolkit/Display.cpp
         FreeImageToolkit/Flip.cpp
         FreeImageToolkit/JPEGTransform.cpp
         FreeImageToolkit/MultigridPoissonSolver.cpp
         FreeImageToolkit/Rescale.cpp
         FreeImageToolkit/Resize.cpp
         Metadata/Exif.cpp
         Metadata/FIRational.cpp
         Metadata/FreeImageTag.cpp
         Metadata/IPTC.cpp
         Metadata/TagConversion.cpp
         Metadata/TagLib.cpp
         Metadata/XTIFF.cpp
)

# List the include paths
include_directories(${CMAKE_SOURCE_DIR}
                    ${CMAKE_SOURCE_DIR}/DeprecationManager
                    ${CMAKE_SOURCE_DIR}/OpenEXR/Half
                    ${CMAKE_SOURCE_DIR}/OpenEXR/Iex
                    ${CMAKE_SOURCE_DIR}/OpenEXR/IlmImf
                    ${CMAKE_SOURCE_DIR}/OpenEXR/IlmThread
                    ${CMAKE_SOURCE_DIR}/OpenEXR/Imath
)

include_directories(${ZLIB_INCLUDE_DIRS})

# Declaration of the library
add_library(freeimage STATIC ${HEADERS} ${SRCS})

add_definitions(-DOPJ_STATIC -DFREEIMAGE_LIB -DNO_LCMS -DDISABLE_PERF_MEASUREMENT)

if(UNIX AND NOT APPLE)
add_definitions(-D__ANSI__)
elseif(WIN32)
add_definitions(-DWINVER=0x0500)
endif()

target_link_libraries(freeimage)

set_target_properties(freeimage PROPERTIES COMPILE_FLAGS "-w -fPIC")

