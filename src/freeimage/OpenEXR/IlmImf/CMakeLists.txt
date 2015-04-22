# List the header files
set(HEADERS ImfAttribute.h
            ImfB44Compressor.h
            ImfBoxAttribute.h
            ImfChannelList.h
            ImfChannelListAttribute.h
            ImfChromaticities.h
            ImfChromaticitiesAttribute.h
            ImfCompressionAttribute.h
            ImfCompressor.h
            ImfConvert.h
            ImfCRgbaFile.h
            ImfDoubleAttribute.h
            ImfEnvmap.h
            ImfEnvmapAttribute.h
            ImfFloatAttribute.h
            ImfFrameBuffer.h
            ImfFramesPerSecond.h
            ImfHeader.h
            ImfHuf.h
            ImfInputFile.h
            ImfIntAttribute.h
            ImfIO.h
            ImfKeyCode.h
            ImfKeyCodeAttribute.h
            ImfLineOrderAttribute.h
            ImfLut.h
            ImfMatrixAttribute.h
            ImfMisc.h
            ImfOpaqueAttribute.h
            ImfOutputFile.h
            ImfPizCompressor.h
            ImfPreviewImage.h
            ImfPreviewImageAttribute.h
            ImfPxr24Compressor.h
            ImfRational.h
            ImfRationalAttribute.h
            ImfRgbaFile.h
            ImfRgbaYca.h
            ImfRleCompressor.h
            ImfScanLineInputFile.h
            ImfStandardAttributes.h
            ImfStdIO.h
            ImfStringAttribute.h
            ImfStringVectorAttribute.h
            ImfTestFile.h
            ImfThreading.h
            ImfTileDescriptionAttribute.h
            ImfTiledInputFile.h
            ImfTiledMisc.h
            ImfTiledOutputFile.h
            ImfTiledRgbaFile.h
            ImfTileOffsets.h
            ImfTimeCode.h
            ImfTimeCodeAttribute.h
            ImfVecAttribute.h
            ImfVersion.h
            ImfWav.h
            ImfZipCompressor.h
)


# List the source files
set(SRCS ImfAttribute.cpp
         ImfB44Compressor.cpp
         ImfBoxAttribute.cpp
         ImfChannelList.cpp
         ImfChannelListAttribute.cpp
         ImfChromaticities.cpp
         ImfChromaticitiesAttribute.cpp
         ImfCompressionAttribute.cpp
         ImfCompressor.cpp
         ImfConvert.cpp
         ImfCRgbaFile.cpp
         ImfDoubleAttribute.cpp
         ImfEnvmap.cpp
         ImfEnvmapAttribute.cpp
         ImfFloatAttribute.cpp
         ImfFrameBuffer.cpp
         ImfFramesPerSecond.cpp
         ImfHeader.cpp
         ImfHuf.cpp
         ImfInputFile.cpp
         ImfIntAttribute.cpp
         ImfIO.cpp
         ImfKeyCode.cpp
         ImfKeyCodeAttribute.cpp
         ImfLineOrderAttribute.cpp
         ImfLut.cpp
         ImfMatrixAttribute.cpp
         ImfMisc.cpp
         ImfOpaqueAttribute.cpp
         ImfOutputFile.cpp
         ImfPizCompressor.cpp
         ImfPreviewImage.cpp
         ImfPreviewImageAttribute.cpp
         ImfPxr24Compressor.cpp
         ImfRational.cpp
         ImfRationalAttribute.cpp
         ImfRgbaFile.cpp
         ImfRgbaYca.cpp
         ImfRleCompressor.cpp
         ImfScanLineInputFile.cpp
         ImfStandardAttributes.cpp
         ImfStdIO.cpp
         ImfStringAttribute.cpp
         ImfStringVectorAttribute.cpp
         ImfTestFile.cpp
         ImfThreading.cpp
         ImfTileDescriptionAttribute.cpp
         ImfTiledInputFile.cpp
         ImfTiledMisc.cpp
         ImfTiledOutputFile.cpp
         ImfTiledRgbaFile.cpp
         ImfTileOffsets.cpp
         ImfTimeCode.cpp
         ImfTimeCodeAttribute.cpp
         ImfVecAttribute.cpp
         ImfVersion.cpp
         ImfWav.cpp
         ImfZipCompressor.cpp
)


include_directories(${CMAKE_CURRENT_LIST_DIR}
                    ${CMAKE_CURRENT_LIST_DIR}/..
                    ${CMAKE_CURRENT_LIST_DIR}/../Half
                    ${CMAKE_CURRENT_LIST_DIR}/../Iex
                    ${CMAKE_CURRENT_LIST_DIR}/../IlmThread
                    ${CMAKE_CURRENT_LIST_DIR}/../Imath
)

# Declaration of the library
add_library(ilmimf STATIC ${HEADERS} ${SRCS})

if(UNIX)
    add_definitions(-fPIC)
endif()

set_target_properties(ilmimf PROPERTIES COMPILE_FLAGS "-w")

