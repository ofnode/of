project(openFrameworks)
cmake_minimum_required(VERSION 2.8)

include(ofnode_common.cmake)

#// GCC and Clang flags ////////////////////////////////////////////////////////

list(APPEND DEBUG_FLAGS
  -Wno-deprecated-declarations
)

#// Source files ///////////////////////////////////////////////////////////////

set(OPENFRAMEWORKS_SOURCES
    "${OF_ROOT_DIR}/src/openframeworks/3d/of3dPrimitives.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/3d/of3dUtils.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/3d/ofCamera.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/3d/ofEasyCam.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/3d/ofNode.cpp"

    "${OF_ROOT_DIR}/src/openframeworks/app/ofAppNoWindow.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/app/ofAppRunner.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/app/ofBaseApp.cpp"
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
    "${OF_ROOT_DIR}/src/openframeworks/graphics/ofGraphicsBaseTypes.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/graphics/ofImage.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/graphics/ofPath.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/graphics/ofPixels.cpp"
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

if(TARGET_ARCH MATCHES arm*)
  list(APPEND OPENFRAMEWORKS_SOURCES
    "${OF_ROOT_DIR}/src/openframeworks/app/ofAppEGLWindow.cpp"
  )
else()
  list(APPEND OPENFRAMEWORKS_SOURCES
    "${OF_ROOT_DIR}/src/openframeworks/app/ofAppGLFWWindow.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/app/ofAppGlutWindow.cpp"
  )
endif()

if(OF_AUDIO)
  list(APPEND OPENFRAMEWORKS_SOURCES
    "${OF_ROOT_DIR}/src/openframeworks/sound/ofSoundBaseTypes.cpp"
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
    "${OF_ROOT_DIR}/src/openframeworks/video/ofAVFoundationGrabber.mm"
    "${OF_ROOT_DIR}/src/openframeworks/video/ofQTKitGrabber.mm"
    "${OF_ROOT_DIR}/src/openframeworks/video/ofQTKitMovieRenderer.m"
    "${OF_ROOT_DIR}/src/openframeworks/video/ofQTKitPlayer.mm"
  )
  elseif(CMAKE_SYSTEM MATCHES Windows)
  list(APPEND OPENFRAMEWORKS_SOURCES
    "${OF_ROOT_DIR}/src/openframeworks/video/ofDirectShowGrabber.cpp"
    "${OF_ROOT_DIR}/src/openframeworks/video/ofDirectShowPlayer.cpp"
  )
  endif()
endif(OF_VIDEO)

if(APPLE)
set(FREEIMAGE_SOURCES
    "${OF_ROOT_DIR}/src/FreeImage/Source/LibJXR/image/decode/segdec.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJXR/image/decode/strdec_x86.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJXR/image/decode/strPredQuantDec.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJXR/image/decode/strdec.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJXR/image/decode/strInvTransform.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJXR/image/decode/postprocess.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJXR/image/decode/decode.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJXR/image/decode/JXRTranscode.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJXR/image/sys/strTransform.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJXR/image/sys/adapthuff.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJXR/image/sys/strcodec.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJXR/image/sys/image.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJXR/image/sys/perfTimerANSI.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJXR/image/sys/strPredQuant.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJXR/image/encode/segenc.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJXR/image/encode/encode.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJXR/image/encode/strPredQuantEnc.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJXR/image/encode/strFwdTransform.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJXR/image/encode/strenc.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJXR/image/encode/strenc_x86.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJXR/jxrgluelib/JXRMeta.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJXR/jxrgluelib/JXRGlueJxr.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJXR/jxrgluelib/JXRGluePFC.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJXR/jxrgluelib/JXRGlue.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibRawLite/dcraw/dcraw.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibRawLite/internal/dcb_demosaicing.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibPNG/pngtrans.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibPNG/pngerror.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibPNG/example.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibPNG/pngrio.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibPNG/pngmem.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibPNG/pngrutil.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibPNG/pngrtran.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibPNG/pngwrite.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibPNG/pngtest.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibPNG/pngread.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibPNG/pngwio.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibPNG/png.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibPNG/pngpread.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibPNG/pngwutil.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibPNG/pngset.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibPNG/pngget.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibPNG/pngwtran.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/ZLib/deflate.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/ZLib/zutil.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/ZLib/inftrees.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/ZLib/gzclose.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/ZLib/gzlib.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/ZLib/adler32.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/ZLib/gzwrite.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/ZLib/compress.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/ZLib/uncompr.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/ZLib/infback.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/ZLib/crc32.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/ZLib/trees.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/ZLib/gzread.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/ZLib/inffast.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/ZLib/inflate.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/FreeImageC.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibOpenJPEG/jp2.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibOpenJPEG/raw.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibOpenJPEG/dwt.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibOpenJPEG/function_list.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibOpenJPEG/t1.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibOpenJPEG/phix_manager.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibOpenJPEG/t1_generate_luts.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibOpenJPEG/bio.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibOpenJPEG/event.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibOpenJPEG/invert.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibOpenJPEG/mct.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibOpenJPEG/j2k.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibOpenJPEG/cio.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibOpenJPEG/tpix_manager.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibOpenJPEG/tcd.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibOpenJPEG/image.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibOpenJPEG/mqc.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibOpenJPEG/cidx_manager.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibOpenJPEG/openjpeg.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibOpenJPEG/t2.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibOpenJPEG/ppix_manager.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibOpenJPEG/pi.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibOpenJPEG/tgt.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibOpenJPEG/thix_manager.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibOpenJPEG/opj_clock.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/ansi2knr.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jmemnobs.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jutils.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/rdswitch.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jmemmac.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jerror.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/example.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/wrtarga.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/transupp.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jdapimin.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jfdctint.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jidctflt.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/wrjpgcom.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jdmaster.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jcprepct.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/wrppm.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jdapistd.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jddctmgr.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jdhuff.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/djpeg.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jfdctfst.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jdmainct.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/wrbmp.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jcapimin.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/cjpeg.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jctrans.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jmemname.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/rdjpgcom.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jdsample.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jchuff.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jcapistd.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jdarith.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jdtrans.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jdpostct.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jmemansi.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/cdjpeg.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jccolor.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jcmaster.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jidctint.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jcsample.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/rdppm.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jcarith.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jdatasrc.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jfdctflt.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jdmerge.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/ckconfig.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/wrrle.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jdcoefct.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jcdctmgr.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jpegtran.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/rdbmp.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jdinput.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jmemmgr.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jdatadst.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jccoefct.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/wrgif.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jcomapi.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jcmarker.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jquant1.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/rdgif.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/rdtarga.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jcinit.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jdcolor.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jcparam.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/rdcolmap.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jmemdos.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/rdrle.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jidctfst.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jdmarker.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jaricom.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jquant2.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibJPEG/jcmainct.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibTIFF4/tif_packbits.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibTIFF4/tif_close.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibTIFF4/tif_warning.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibTIFF4/tif_dirwrite.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibTIFF4/tif_vms.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibTIFF4/tif_unix.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibTIFF4/tif_dirread.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibTIFF4/tif_swab.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibTIFF4/tif_pixarlog.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibTIFF4/tif_fax3.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibTIFF4/tif_read.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibTIFF4/mkg3states.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibTIFF4/tif_wince.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibTIFF4/tif_aux.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibTIFF4/tif_lzma.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibTIFF4/tif_jpeg.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibTIFF4/tif_getimage.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibTIFF4/tif_version.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibTIFF4/tif_luv.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibTIFF4/tif_open.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibTIFF4/tif_win32.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibTIFF4/tif_error.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibTIFF4/tif_color.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibTIFF4/tif_thunder.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibTIFF4/tif_next.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibTIFF4/tif_predict.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibTIFF4/tif_jbig.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibTIFF4/tif_dumpmode.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibTIFF4/tif_print.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibTIFF4/tif_extension.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibTIFF4/tif_zip.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibTIFF4/tif_lzw.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibTIFF4/tif_flush.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibTIFF4/tif_dir.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibTIFF4/tif_dirinfo.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibTIFF4/tif_write.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibTIFF4/tif_compress.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibTIFF4/mkspans.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibTIFF4/tif_tile.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibTIFF4/tif_jpeg_12.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibTIFF4/tif_codec.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibTIFF4/tif_fax3sm.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibTIFF4/tif_ojpeg.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibTIFF4/tif_strip.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/utils/utils.quant_levels.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/utils/utils.random.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/utils/utils.rescaler.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/utils/utils.quant_levels_dec.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/utils/utils.thread.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/utils/utils.color_cache.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/utils/utils.bit_writer.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/utils/utils.bit_reader.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/utils/utils.huffman_encode.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/utils/utils.filters.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/utils/utils.huffman.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/utils/utils.utils.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/enc/enc.cost.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/enc/enc.picture_rescale.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/enc/enc.frame.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/enc/enc.filter.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/enc/enc.histogram.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/enc/enc.picture_tools.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/enc/enc.syntax.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/enc/enc.quant.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/enc/enc.token.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/enc/enc.near_lossless.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/enc/enc.webpenc.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/enc/enc.analysis.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/enc/enc.tree.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/enc/enc.picture.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/enc/enc.picture_psnr.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/enc/enc.vp8l.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/enc/enc.config.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/enc/enc.picture_csp.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/enc/enc.iterator.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/enc/enc.alpha.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/enc/enc.backward_references.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dec/dec.idec.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dec/dec.vp8l.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dec/dec.frame.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dec/dec.quant.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dec/dec.tree.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dec/dec.vp8.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dec/dec.buffer.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dec/dec.webp.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dec/dec.alpha.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dec/dec.io.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/mux/mux.muxinternal.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/mux/mux.muxedit.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/mux/mux.anim_encode.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/mux/mux.muxread.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dsp/dsp.cost_sse2.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dsp/dsp.dec_neon.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dsp/dsp.rescaler_mips_dsp_r2.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dsp/dsp.filters_sse2.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dsp/dsp.enc_neon.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dsp/dsp.alpha_processing_mips_dsp_r2.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dsp/dsp.lossless_sse2.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dsp/dsp.enc.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dsp/dsp.rescaler.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dsp/dsp.dec_clip_tables.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dsp/dsp.lossless.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dsp/dsp.filters.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dsp/dsp.cost_mips32.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dsp/dsp.upsampling_sse2.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dsp/dsp.alpha_processing.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dsp/dsp.argb_sse2.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dsp/dsp.cost_mips_dsp_r2.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dsp/dsp.enc_mips_dsp_r2.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dsp/dsp.cpu.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dsp/dsp.cost.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dsp/dsp.dec_mips_dsp_r2.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dsp/dsp.lossless_mips32.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dsp/dsp.yuv_mips32.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dsp/dsp.enc_sse2.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dsp/dsp.rescaler_mips32.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dsp/dsp.dec_mips32.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dsp/dsp.argb.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dsp/dsp.upsampling.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dsp/dsp.enc_mips32.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dsp/dsp.argb_mips_dsp_r2.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dsp/dsp.upsampling_mips_dsp_r2.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dsp/dsp.upsampling_neon.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dsp/dsp.yuv_sse2.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dsp/dsp.lossless_mips_dsp_r2.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dsp/dsp.filters_mips_dsp_r2.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dsp/dsp.dec.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dsp/dsp.dec_sse2.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dsp/dsp.lossless_neon.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dsp/dsp.enc_avx2.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dsp/dsp.alpha_processing_sse2.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dsp/dsp.yuv_mips_dsp_r2.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/dsp/dsp.yuv.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibWebP/src/demux/demux.demux.c"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibRawLite/src/libraw_datastream.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibRawLite/src/libraw_c_api.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibRawLite/src/libraw_cxx.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibRawLite/internal/demosaic_packs.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibRawLite/internal/dcraw_fileio.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibRawLite/internal/libraw_x3f.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibRawLite/internal/dcraw_common.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibRawLite/internal/wf_filtering.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibRawLite/internal/dht_demosaic.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/LibRawLite/internal/aahd_demosaic.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfFrameBuffer.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfConvert.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfIO.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfInputPartData.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfAcesFile.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfInputFile.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfTimeCode.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfTiledMisc.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfScanLineInputFile.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfDeepFrameBuffer.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfStringVectorAttribute.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfWav.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfInputPart.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfEnvmap.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfTiledOutputPart.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfHuf.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfTileDescriptionAttribute.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfZipCompressor.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfRgbaYca.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfTiledRgbaFile.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfDeepTiledOutputFile.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfDeepImageStateAttribute.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfCompressor.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfTestFile.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfTileOffsets.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfBoxAttribute.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfRleCompressor.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfCompositeDeepScanLine.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfPreviewImageAttribute.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfDeepScanLineInputFile.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfPreviewImage.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfFramesPerSecond.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfMisc.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfMultiPartInputFile.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfVersion.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfChromaticities.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfChannelListAttribute.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfPizCompressor.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfCompressionAttribute.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfStringAttribute.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfFastHuf.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfTiledOutputFile.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfTimeCodeAttribute.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfEnvmapAttribute.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfTiledInputPart.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfB44Compressor.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfOutputPart.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfChromaticitiesAttribute.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfIntAttribute.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfStandardAttributes.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfTiledInputFile.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfHeader.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfDeepScanLineInputPart.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfLineOrderAttribute.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfDeepTiledInputFile.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfRgbaFile.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfStdIO.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfOpaqueAttribute.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfGenericInputFile.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfPartType.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfKeyCodeAttribute.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/dwaLookups.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfDeepTiledInputPart.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfDoubleAttribute.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfOutputFile.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfSystemSpecific.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfOutputPartData.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfPxr24Compressor.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/b44ExpLogTable.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfChannelList.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfFloatAttribute.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfLut.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfRationalAttribute.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfVecAttribute.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfAttribute.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfGenericOutputFile.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfZip.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfMatrixAttribute.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfMultiPartOutputFile.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfRle.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfDeepScanLineOutputPart.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfThreading.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfDeepCompositing.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfCRgbaFile.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfDwaCompressor.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfMultiView.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfDeepTiledOutputPart.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfRational.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfFloatVectorAttribute.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfDeepScanLineOutputFile.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmImf/ImfKeyCode.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/Iex/IexBaseExc.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/Iex/IexThrowErrnoExc.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/Half/eLut.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/Half/toFloat.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/Half/half.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmThread/IlmThreadSemaphore.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmThread/IlmThreadMutexWin32.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmThread/IlmThreadWin32.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmThread/IlmThread.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmThread/IlmThreadMutexPosix.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmThread/IlmThreadPosix.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmThread/IlmThreadSemaphorePosixCompat.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmThread/IlmThreadPool.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmThread/IlmThreadSemaphoreWin32.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmThread/IlmThreadSemaphorePosix.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IlmThread/IlmThreadMutex.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/Imath/ImathBox.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/Imath/ImathMatrixAlgo.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/Imath/ImathColorAlgo.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/Imath/ImathFun.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/Imath/ImathRandom.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/Imath/ImathShear.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/Imath/ImathVec.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IexMath/IexMathFpu.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/OpenEXR/IexMath/IexMathFloatExc.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/Metadata/FIRational.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/Metadata/XTIFF.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/Metadata/TagLib.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/Metadata/TagConversion.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/Metadata/FreeImageTag.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/Metadata/IPTC.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/Metadata/Exif.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/PluginJNG.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/TIFFLogLuv.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/PluginXPM.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/FreeImage.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/GetType.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/PixelAccess.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/Conversion32.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/Plugin.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/PluginG3.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/PluginPNG.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/PluginJ2K.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/PluginPCD.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/ConversionFloat.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/PluginEXR.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/PluginMNG.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/PluginXBM.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/Halftoning.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/ColorLookup.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/ConversionType.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/PluginPNM.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/PluginICO.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/PluginKOALA.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/WuQuantizer.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/Conversion24.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/ConversionRGBAF.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/PluginTARGA.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/ToneMapping.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/PSDParser.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/PluginGIF.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/PluginPICT.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/PluginJXR.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/PluginCUT.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/ConversionRGB16.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/PluginTIFF.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/tmoColorConvert.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/PluginJP2.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/Conversion16_565.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/Conversion8.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/PluginPFM.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/Conversion.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/MemoryIO.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/tmoDrago03.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/PluginPSD.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/PluginPCX.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/ZLibInterface.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/PluginWBMP.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/MNGHelper.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/PluginDDS.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/PluginHDR.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/PluginSGI.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/ConversionRGBF.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/FreeImageIO.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/PluginJPEG.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/PluginRAS.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/PluginRAW.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/PluginWebP.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/BitmapAccess.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/MultiPage.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/J2KHelper.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/Conversion16_555.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/tmoFattal02.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/ConversionUINT16.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/NNQuantizer.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/LFPQuantizer.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/tmoReinhard05.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/PluginBMP.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/Conversion4.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/PluginIFF.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/CacheFile.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImage/ConversionRGBA16.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImageToolkit/Channels.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImageToolkit/CopyPaste.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImageToolkit/MultigridPoissonSolver.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImageToolkit/Flip.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImageToolkit/BSplineRotate.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImageToolkit/Colors.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImageToolkit/ClassicRotate.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImageToolkit/Rescale.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImageToolkit/Background.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImageToolkit/Resize.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImageToolkit/Display.cpp"
"${OF_ROOT_DIR}/src/FreeImage/Source/FreeImageToolkit/JPEGTransform.cpp"

)

include_directories(
    "${OF_ROOT_DIR}/src/FreeImage/Source/LibJXR/image/sys/"
    "${OF_ROOT_DIR}/src/FreeImage/Source/LibJXR/common/include"
    "${OF_ROOT_DIR}/src/FreeImage/Source/LibJXR/jxrgluelib"
    )

set_source_files_properties(${FREEIMAGE_SOURCES} PROPERTIES COMPILE_FLAGS "-w -fvisibility=hidden")
endif()

# add_subdirectory("${OF_ROOT_DIR}/src/libjasper")

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

list(APPEND OPENFRAMEWORKS_INCLUDE_DIRS
    "${OF_ROOT_DIR}/src/utf8cpp/include"
)

if(CMAKE_SYSTEM MATCHES Windows)
set(VIDEOINPUT_SOURCES
  "${OF_ROOT_DIR}/src/videoinput/videoInput.cpp"
)
endif()

add_subdirectory("${OF_ROOT_DIR}/src/glm")

if(OF_AUDIO)
 set(RTAUDIO_SOURCES
     "${OF_ROOT_DIR}/src/rtaudio/RtAudio.cpp"
 )
endif()

#// Platform-specific commands /////////////////////////////////////////////////

if(CMAKE_SYSTEM MATCHES Linux)

    include_directories("${CMAKE_CURRENT_LIST_DIR}/src/glfw/include")


    if(OF_STATIC)
      set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE "${OF_ROOT_DIR}/lib-linux/release-${TARGET_ARCH}-${ARCH_BIT}")
      set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG   "${OF_ROOT_DIR}/lib-linux/debug-${TARGET_ARCH}-${ARCH_BIT}")
    else()
      set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE "${OF_ROOT_DIR}/lib-linux/release-${TARGET_ARCH}-${ARCH_BIT}")
      set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG   "${OF_ROOT_DIR}/lib-linux/debug-${TARGET_ARCH}-${ARCH_BIT}")
    endif()
 
    pkg_check_modules(CAIRO REQUIRED cairo)
    pkg_check_modules(FONTCONFIG REQUIRED fontconfig)
    pkg_check_modules(URIPARSER REQUIRED liburiparser)

    find_package(PugiXML REQUIRED)
    find_package(GLUT REQUIRED)

    if(TARGET_ARCH MATCHES arm*)
    # TODO change that to point to /opt/vc/include directory
      find_package(OpenGLES REQUIRED)
      message(STATUS "OpenGLES include dir : ${OPENGLES2_INCLUDE_DIR}")
    else()
      find_package(OpenGL REQUIRED)
    endif()

    find_package(Freetype REQUIRED)

    list(APPEND OPENFRAMEWORKS_INCLUDE_DIRS
        ${CAIRO_INCLUDE_DIRS}
        ${OPENGL_INCLUDE_DIR}
        ${FREETYPE_INCLUDE_DIRS}
        ${FONTCONFIG_INCLUDE_DIRS}
        ${URIPARSER_INCLUDE_DIRS}
        ${OPENGLES2_INCLUDE_DIR}
        ${FREEIMAGE_INCLUDE_PATH}
        ${PUGIXML_INCLUDE_DIRS}
    )

    message(STATUS "CAIRO_INCLUDE_DIRS: ${CAIRO_INCLUDE_DIRS}")
    message(STATUS "EGL_INCLUDE_DIR:  ${EGL_INCLUDE_DIR}")
    message(STATUS "OPENGLES2_INCLUDE_DIR: ${OPENGLES2_INCLUDE_DIR}")
    message(STATUS "FREETYPE_INCLUDE_DIRS: ${FREETYPE_INCLUDE_DIRS}")

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

      if (NOT TARGET_ARCH MATCHES arm*)
        list(APPEND OPENFRAMEWORKS_SOURCES
          "${OF_ROOT_DIR}/src/openframeworks/sound/ofSoundBaseTypes.cpp"
        )
        set(FMODEX_LIBRARIES ${CMAKE_CURRENT_LIST_DIR}/src/fmodex/lib/linux64/libfmodex.so)
      endif()
    endif()

    if(NOT OF_VIDEO)
      list(APPEND OPENFRAMEWORKS_DEFINITIONS -DTARGET_NO_VIDEO)
    else()

      find_package(UDev REQUIRED)
      find_package(Glib REQUIRED)
      message(STATUS "GLIB include dir:      ${GLIB_INCLUDE_DIRS}")

      pkg_check_modules(GSTREAMER gstreamer-1.0)
      pkg_check_modules(GSTREAMER_BASE gstreamer-base-1.0)
      pkg_check_modules(GSTREAMER_VIDEO gstreamer-video-1.0)
      pkg_check_modules(GSTREAMER_APP gstreamer-app-1.0)

      message(STATUS "Gstreamer include dir: " ${GSTREAMER_INCLUDE_DIRS})

      message(STATUS "Gstreamer lib:        ${GSTREAMER_LIBRARIES}")
      message(STATUS "Gstreamer-app lib:    ${GSTREAMER_APP_LIBRARIES}")
      message(STATUS "Gstreamer-base lib:   ${GSTREAMER_BASE_LIBRARIES}")
      message(STATUS "Gstreamer-video lib:  ${GSTREAMER_VIDEO_LIBRARIES}")

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

        message(STATUS "Gtk+-3 include dir:       ${GTK3_INCLUDE_DIRS}")
        message(STATUS "Gtk+-3 libraries:         ${GTK3_LIBRARIES}")

      endif()

      if ( OF_GTK2 )
        list(APPEND OPENFRAMEWORKS_DEFINITIONS -DOF_USING_GTK)
        pkg_check_modules(GTK2 REQUIRED gtk+-2.0)
        list(APPEND OPENFRAMEWORKS_INCLUDE_DIRS ${GTK2_INCLUDE_DIRS} )
        list(APPEND OPENFRAMEWORKS_LIBRARIES ${GTK2_LIBRARIES} )

        message(STATUS "Gtk+-2 include dir: "      ${GTK2_INCLUDE_DIRS})
        message(STATUS "Gtk+-2 libraries: "      ${GTK2_LIBRARIES})

      endif()

    endif()

elseif(CMAKE_SYSTEM MATCHES Darwin)

    set_source_files_properties(${OPENFRAMEWORKS_SOURCES} PROPERTIES COMPILE_FLAGS "-x objective-c++")

    if(OF_STATIC)
      set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE "${OF_ROOT_DIR}/lib-osx/release-${TARGET_ARCH}-${ARCH_BIT}")
      set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG   "${OF_ROOT_DIR}/lib-osx/debug-${TARGET_ARCH}-${ARCH_BIT}")
    else()
      set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE "${OF_ROOT_DIR}/lib-osx/release-${TARGET_ARCH}-${ARCH_BIT}")
      set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG   "${OF_ROOT_DIR}/lib-osx/debug-${TARGET_ARCH}-${ARCH_BIT}")
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

    # Hardcode FreeType path, see issue #15
    list(APPEND OPENFRAMEWORKS_INCLUDE_DIRS
        "/usr/local/include/freetype2"
    )

    list(APPEND OPENFRAMEWORKS_INCLUDE_DIRS
        ${CAIRO_INCLUDE_DIRS}
        ${OPENGL_INCLUDE_DIR}
        ${OPENSSL_INCLUDE_DIR}
        ${MPG123_INCLUDE_DIRS}
        ${SNDFILE_INCLUDE_DIR}
        ${FONTCONFIG_INCLUDE_DIRS}
    )

elseif(CMAKE_SYSTEM MATCHES Windows)

    if(OF_STATIC)
      set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE "${OF_ROOT_DIR}/lib-windows/release-${TARGET_ARCH}-${ARCH_BIT}")
      set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG   "${OF_ROOT_DIR}/lib-windows/debug-${TARGET_ARCH}-${ARCH_BIT}")
    else()
      set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE "${OF_ROOT_DIR}/lib-windows/release-${TARGET_ARCH}-${ARCH_BIT}")
      set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG   "${OF_ROOT_DIR}/lib-windows/debug-${TARGET_ARCH}-${ARCH_BIT}")
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

    list(APPEND OPENFRAMEWORKS_INCLUDE_DIRS
        ${CAIRO_INCLUDE_DIRS}
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
   # -DPOCO_STATIC
)

if(ARCH_BIT MATCHES 64)
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

if(TARGET_ARCH MATCHES armv7)
    set(ARCH_FLAG "-march=armv7-a -mfpu=vfp -mfloat-abi=hard")
elseif(TARGET_ARCH MATCHES armv6)
    set(ARCH_FLAG "-march=armv6 -mfpu=vfp -mfloat-abi=hard")
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

# add_subdirectory(src/poco)

add_library(
    openFrameworks ${LIB_MODE}
    ${OPENFRAMEWORKS_SOURCES}
    ${VIDEOINPUT_SOURCES}
    ${FREEIMAGE_SOURCES}
    ${LIBTESS2_SOURCES}
    ${KISSFFT_SOURCES}
    ${RTAUDIO_SOURCES}
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

  # add_dependencies(
  #     openFrameworks
  #     PocoCrypto
  #     PocoFoundation
  #     PocoJSON
  #     PocoNet
  #     PocoNetSSL
  #     PocoUtil
  #     PocoXML
  # )

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

  # set(OPENFRAMEWORKS_LIBRARIES
  #     PocoCrypto
  #     PocoFoundation
  #     PocoJSON
  #     PocoNet
  #     PocoNetSSL
  #     PocoUtil
  #     PocoXML
  # )

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
      ${CMAKE_THREAD_LIBS_INIT}
      ${GSTREAMER_LIBRARIES}
      ${GSTREAMER_APP_LIBRARIES}
      ${GSTREAMER_BASE_LIBRARIES}
      ${GSTREAMER_VIDEO_LIBRARIES}
      ${FMODEX_LIBRARIES}
      ${PUGIXML_LIBRARIES}
      ${URIPARSER_LIBRARIES}
      ${GLUT_LIBRARIES}
  )

  if(ARCH_BIT MATCHES 64)
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

message(STATUS "TARGET_ARCH: ${TARGET_ARCH} ${ARCH_BIT}bit")
message(STATUS "OF_STATIC: " ${OF_STATIC})

if(CMAKE_SYSTEM MATCHES Linux)
message(STATUS "OF_AUDIO: " ${OF_AUDIO})
message(STATUS "OF_VIDEO: " ${OF_VIDEO})
message(STATUS "OF_GTK: " ${OF_GTK})
message(STATUS "OF_GTK2: " ${OF_GTK2})

endif()

message(STATUS "CMAKE_BUILD_TYPE: "      ${CMAKE_BUILD_TYPE})
message(STATUS "CMAKE_C_COMPILER_ID: "   ${CMAKE_C_COMPILER_ID})
message(STATUS "CMAKE_CXX_COMPILER_ID: " ${CMAKE_CXX_COMPILER_ID})
