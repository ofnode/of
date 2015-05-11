cmake_minimum_required(VERSION 2.8)

project(ofExamples)

set(ofExamples              ON)
set(res15-opengl            ON)
set(openFrameworksDemos     ON)
set(OF_GenerativeTypography ON)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/..")

include(openFrameworks)

function(example APP DIR)

    file(GLOB_RECURSE SRC "${CMAKE_CURRENT_LIST_DIR}/${DIR}/*.cpp")

    add_executable(${APP} ${SRC})
    target_link_libraries(${APP} ${OPENFRAMEWORKS_LIBRARIES} ofxAddons)
    set_target_properties(${APP} PROPERTIES LIBRARY_OUTPUT_DIRECTORY_RELEASE "${CMAKE_CURRENT_LIST_DIR}/${DIR}/bin")
    set_target_properties(${APP} PROPERTIES RUNTIME_OUTPUT_DIRECTORY_RELEASE "${CMAKE_CURRENT_LIST_DIR}/${DIR}/bin")
    set_target_properties(${APP} PROPERTIES LIBRARY_OUTPUT_DIRECTORY_DEBUG   "${CMAKE_CURRENT_LIST_DIR}/${DIR}/bin")
    set_target_properties(${APP} PROPERTIES RUNTIME_OUTPUT_DIRECTORY_DEBUG   "${CMAKE_CURRENT_LIST_DIR}/${DIR}/bin")

endfunction(example)


#// OFXADDONS //////////////////////////////////////////////////////////////////


ofxaddon(ofx3DModelLoader)
# TODO: ofxAccelerometer
# TODO: ofxAndroid
ofxaddon(ofxAssimpModelLoader)
# TODO: ofxEmscripten
ofxaddon(ofxGui)
# TODO: ofxiOS
ofxaddon(ofxKinect)
# TODO: ofxMultiTouch
ofxaddon(ofxNetwork)
ofxaddon(ofxOpenCv)
ofxaddon(ofxOsc)
ofxaddon(ofxSvg)
ofxaddon(ofxThreadedImageLoader)
ofxaddon(ofxVectorGraphics)
ofxaddon(ofxXmlSettings)

ofxaddon(addons/ofxPointInMesh)
ofxaddon(addons/ofxVoronoi)
ofxaddon(addons/ofxVoro)

include_directories(
    ${CMAKE_CURRENT_LIST_DIR}/addons/ofxVoronoi/libs/Voro++2D
)
list(APPEND OFXADDONS_SOURCES
    ${CMAKE_CURRENT_LIST_DIR}/addons/ofxVoronoi/libs/Voro++2D/cell_2d.cpp
    ${CMAKE_CURRENT_LIST_DIR}/addons/ofxVoronoi/libs/Voro++2D/cell_nc_2d.cpp
    ${CMAKE_CURRENT_LIST_DIR}/addons/ofxVoronoi/libs/Voro++2D/c_loops_2d.cpp
    ${CMAKE_CURRENT_LIST_DIR}/addons/ofxVoronoi/libs/Voro++2D/common.cpp
    ${CMAKE_CURRENT_LIST_DIR}/addons/ofxVoronoi/libs/Voro++2D/container_2d.cpp
    ${CMAKE_CURRENT_LIST_DIR}/addons/ofxVoronoi/libs/Voro++2D/ctr_boundary_2d.cpp
    ${CMAKE_CURRENT_LIST_DIR}/addons/ofxVoronoi/libs/Voro++2D/v_base_2d.cpp
    ${CMAKE_CURRENT_LIST_DIR}/addons/ofxVoronoi/libs/Voro++2D/v_base_wl_2d.cpp
    ${CMAKE_CURRENT_LIST_DIR}/addons/ofxVoronoi/libs/Voro++2D/v_compute_2d.cpp
    ${CMAKE_CURRENT_LIST_DIR}/addons/ofxVoronoi/libs/Voro++2D/wall_2d.cpp
)

include_directories(
    ${CMAKE_CURRENT_LIST_DIR}/addons/ofxVoro/libs/voro++
)
list(APPEND OFXADDONS_SOURCES
    ${CMAKE_CURRENT_LIST_DIR}/addons/ofxVoro/libs/voro++/cell.cc
    ${CMAKE_CURRENT_LIST_DIR}/addons/ofxVoro/libs/voro++/c_loops.cc
    ${CMAKE_CURRENT_LIST_DIR}/addons/ofxVoro/libs/voro++/common.cc
    ${CMAKE_CURRENT_LIST_DIR}/addons/ofxVoro/libs/voro++/container.cc
    ${CMAKE_CURRENT_LIST_DIR}/addons/ofxVoro/libs/voro++/container_prd.cc
    ${CMAKE_CURRENT_LIST_DIR}/addons/ofxVoro/libs/voro++/pre_container.cc
    ${CMAKE_CURRENT_LIST_DIR}/addons/ofxVoro/libs/voro++/unitcell.cc
    ${CMAKE_CURRENT_LIST_DIR}/addons/ofxVoro/libs/voro++/v_base.cc
    ${CMAKE_CURRENT_LIST_DIR}/addons/ofxVoro/libs/voro++/v_compute.cc
    ${CMAKE_CURRENT_LIST_DIR}/addons/ofxVoro/libs/voro++/wall.cc
)

add_library(ofxAddons STATIC ${OFXADDONS_SOURCES})


#// ofExamples /////////////////////////////////////////////////////////////////


if(ofExamples)

example( 3DPrimitivesExample                     ofExamples/3d/3DPrimitivesExample )
example( advanced3dExample                       ofExamples/3d/advanced3dExample )
example( cameraLensOffsetExample                 ofExamples/3d/cameraLensOffsetExample )
example( cameraParentingExample                  ofExamples/3d/cameraParentingExample )
example( cameraRibbonExample                     ofExamples/3d/cameraRibbonExample )
example( easyCamExample                          ofExamples/3d/easyCamExample )
example( meshFromCamera                          ofExamples/3d/meshFromCamera )
example( modelNoiseExample                       ofExamples/3d/modelNoiseExample )
example( normalsExample                          ofExamples/3d/normalsExample )
example( ofBoxExample                            ofExamples/3d/ofBoxExample )
example( orientationExample                      ofExamples/3d/orientationExample )
example( pointCloudExample                       ofExamples/3d/pointCloudExample )
example( pointPickerExample                      ofExamples/3d/pointPickerExample )
example( quaternionArcballExample                ofExamples/3d/quaternionArcballExample )
example( quaternionLatLongExample                ofExamples/3d/quaternionLatLongExample )

example( 3DModelLoaderExample                    ofExamples/addons/3DModelLoaderExample )
example( allAddonsExample                        ofExamples/addons/allAddonsExample )
example( assimpExample                           ofExamples/addons/assimpExample )
example( kinectExample                           ofExamples/addons/kinectExample )
example( networkTcpClientExample                 ofExamples/addons/networkTcpClientExample )
example( networkTcpServerExample                 ofExamples/addons/networkTcpServerExample )
example( networkUdpReceiverExample               ofExamples/addons/networkUdpReceiverExample )
example( networkUdpSenderExample                 ofExamples/addons/networkUdpSenderExample )
example( opencvExample                           ofExamples/addons/opencvExample )
example( opencvHaarFinderExample                 ofExamples/addons/opencvHaarFinderExample )
example( oscChatSystemExample                    ofExamples/addons/oscChatSystemExample )
example( oscReceiveExample                       ofExamples/addons/oscReceiveExample )
example( oscSenderExample                        ofExamples/addons/oscSenderExample )
example( svgExample                              ofExamples/addons/svgExample )
example( threadedImageLoaderExample              ofExamples/addons/threadedImageLoaderExample )
example( vectorGraphicsExample                   ofExamples/addons/vectorGraphicsExample )
example( xmlSettingsExample                      ofExamples/addons/xmlSettingsExample )

# TODO: android

example( firmataExample                          ofExamples/communication/firmataExample )
example( serialExample                           ofExamples/communication/serialExample )

example( emptyExample                            ofExamples/empty )

example( advancedEventsExample                   ofExamples/events/advancedEventsExample )
example( customEventExample                      ofExamples/events/customEventExample )
example( eventsExample                           ofExamples/events/eventsExample )
example( multiWindowExample                      ofExamples/events/multiWindowExample )
example( multiWindowOneAppExample                ofExamples/events/multiWindowOneAppExample )
example( simpleEventsExample                     ofExamples/events/simpleEventsExample )
example( simpleTimer                             ofExamples/events/simpleTimer )

example( alphaMaskingShaderExample               ofExamples/gl/alphaMaskingShaderExample )
example( areaLightExample                        ofExamples/gl/areaLightExample )
example( billboardExample                        ofExamples/gl/billboardExample )
example( billboardRotationExample                ofExamples/gl/billboardRotationExample )
example( computeShaderParticlesExample           ofExamples/gl/computeShaderParticlesExample )
example( computeShaderTextureExample             ofExamples/gl/computeShaderTextureExample )
example( fboTrailsExample                        ofExamples/gl/fboTrailsExample )
example( geometryShaderExample                   ofExamples/gl/geometryShaderExample )
example( glInfoExample                           ofExamples/gl/glInfoExample )
example( gpuParticleSystemExample                ofExamples/gl/gpuParticleSystemExample )
example( multiLightExample                       ofExamples/gl/multiLightExample )
example( multiTextureShaderExample               ofExamples/gl/multiTextureShaderExample )
example( pixelBufferExample                      ofExamples/gl/pixelBufferExample )
example( pointsAsTextures                        ofExamples/gl/pointsAsTextures )
example( shaderExample                           ofExamples/gl/shaderExample )
example( singleLightExample                      ofExamples/gl/singleLightExample )
example( slowFastRendering                       ofExamples/gl/slowFastRendering )
example( textureBufferInstancedExample           ofExamples/gl/textureBufferInstancedExample )
example( textureExample                          ofExamples/gl/textureExample )
example( textureScreengrabExample                ofExamples/gl/textureScreengrabExample )
example( threadedPixelBufferExample              ofExamples/gl/threadedPixelBufferExample )
example( vboExample                              ofExamples/gl/vboExample )
example( vboMeshDrawInstancedExample             ofExamples/gl/vboMeshDrawInstancedExample )
example( viewportExample                         ofExamples/gl/viewportExample )

# TODO: gles

example( blendingExample                         ofExamples/graphics/blendingExample )
example( color                                   ofExamples/graphics/color )
example( colorsExtended                          ofExamples/graphics/colorsExtended )
example( floatingPointImageExample               ofExamples/graphics/floatingPointImageExample )
example( fontsExample                            ofExamples/graphics/fontsExample )
example( fontShapesExample                       ofExamples/graphics/fontShapesExample )
example( graphicsExample                         ofExamples/graphics/graphicsExample )
example( imageCompressionExample                 ofExamples/graphics/imageCompressionExample )
example( imageLoaderExample                      ofExamples/graphics/imageLoaderExample )
example( imageLoaderWebExample                   ofExamples/graphics/imageLoaderWebExample )
example( imageSaverExample                       ofExamples/graphics/imageSaverExample )
example( imageSequenceExample                    ofExamples/graphics/imageSequenceExample )
example( imageSubsectionExample                  ofExamples/graphics/imageSubsectionExample )
example( lutFilterExample                        ofExamples/graphics/lutFilterExample )
example( pdfExample                              ofExamples/graphics/pdfExample )
example( polygonExample                          ofExamples/graphics/polygonExample )
example( polylineBlobsExample                    ofExamples/graphics/polylineBlobsExample )
example( rectangleAlignmentAndScaling            ofExamples/graphics/rectangleAlignmentAndScaling )
example( simpleColorKey                          ofExamples/graphics/simpleColorKey )

example( guiExample                              ofExamples/gui/guiExample )
example( guiFromParametersExample                ofExamples/gui/guiFromParametersExample )
example( oscParametersReceiver                   ofExamples/gui/oscParametersReceiver )
example( oscParametersSender                     ofExamples/gui/oscParametersSender )
example( parameterEdgeCasesExample               ofExamples/gui/parameterEdgeCasesExample )
example( parameterGroupExample                   ofExamples/gui/parameterGroupExample )

# TODO: ios

example( noise1dExample                          ofExamples/math/noise1dExample )
example( noise1dOctaveExample                    ofExamples/math/noise1dOctaveExample )
example( noiseField2dExample                     ofExamples/math/noiseField2dExample )
example( particlesExample                        ofExamples/math/particlesExample )
example( periodicSignalsExample                  ofExamples/math/periodicSignalsExample )
example( trigonometricMotionExample              ofExamples/math/trigonometricMotionExample )
example( trigonometryExample                     ofExamples/math/trigonometryExample )
example( vectorMathExample                       ofExamples/math/vectorMathExample )

example( audioInputExample                       ofExamples/sound/audioInputExample )
example( audioOutputExample                      ofExamples/sound/audioOutputExample )
example( soundBufferExample                      ofExamples/sound/soundBufferExample )
example( soundPlayerExample                      ofExamples/sound/soundPlayerExample )
example( soundPlayerFFTExample                   ofExamples/sound/soundPlayerFFTExample )

example( clipboardExample                        ofExamples/utils/clipboardExample )
example( conversionExample                       ofExamples/utils/conversionExample )
example( dirListExample                          ofExamples/utils/dirListExample )
example( dragDropExample                         ofExamples/utils/dragDropExample )
example( fileBufferLoadingCSVExample             ofExamples/utils/fileBufferLoadingCSVExample )
example( fileOpenSaveDialogExample               ofExamples/utils/fileOpenSaveDialogExample )
example( loadTextFileExample                     ofExamples/utils/loadTextFileExample )
example( loggingExample                          ofExamples/utils/loggingExample )
example( regularExpressionExample                ofExamples/utils/regularExpressionExample )
example( sortingExample                          ofExamples/utils/sortingExample )
example( systemSpeakExample                      ofExamples/utils/systemSpeakExample )
example( threadChannelExample                    ofExamples/utils/threadChannelExample )
example( threadExample                           ofExamples/utils/threadExample )
example( windowExample                           ofExamples/utils/windowExample )
example( xmlExample                              ofExamples/utils/xmlExample )

example( asciiVideo                              ofExamples/video/asciiVideo )
if(CMAKE_SYSTEM MATCHES Darwin)
example( osxVideoRecorderExample                 ofExamples/video/osxVideoRecorderExample )
endif()
example( videoGrabberExample                     ofExamples/video/videoGrabberExample )
example( videoPlayerExample                      ofExamples/video/videoPlayerExample )

endif(ofExamples)


#// res15-opengl ///////////////////////////////////////////////////////////////


if(res15-opengl)

example( deferredRenderingExample                res15-opengl/deferredRenderingExample )
example( frustumCullingExample_complete          res15-opengl/frustumCullingExample_complete )
example( frustumCullingExample_startingPoint     res15-opengl/frustumCullingExample_startingPoint )
example( fullScreenQuadExample_complete          res15-opengl/fullScreenQuadExample_complete )
example( fullScreenQuadExample_startingPoint     res15-opengl/fullScreenQuadExample_startingPoint )
example( gaussianBlurExample_complete            res15-opengl/gaussianBlurExample_complete )
example( gaussianBlurExample_startingPoint       res15-opengl/gaussianBlurExample_startingPoint )
example( gpu3DLutExample_complete                res15-opengl/gpu3DLutExample_complete )
example( gpu3DLutExample_startingPoint           res15-opengl/gpu3DLutExample_startingPoint )
example( instancedExample_complete               res15-opengl/instancedExample_complete )
example( instancedExample_startingPoint          res15-opengl/instancedExample_startingPoint )
example( lightingBasicsExample_complete          res15-opengl/lightingBasicsExample_complete )
example( lightingBasicsExample_startingPoint     res15-opengl/lightingBasicsExample_startingPoint )
example( multiLightExample_complete              res15-opengl/multiLightExample_complete )
example( multiLightExample_startingPoint         res15-opengl/multiLightExample_startingPoint )
example( postProcessingExample_complete          res15-opengl/postProcessingExample_complete )
example( postProcessingExample_startingPoint     res15-opengl/postProcessingExample_startingPoint )
example( triplanarTexturingExample_complete      res15-opengl/triplanarTexturingExample_complete )
example( triplanarTexturingExample_startingPoint res15-opengl/triplanarTexturingExample_startingPoint )

endif(res15-opengl)

#// openFrameworksDemos ////////////////////////////////////////////////////////

if(openFrameworksDemos)

example( BarnesHut                               openFrameworksDemos/BarnesHut )     
example( BinnedParticleSystem                    openFrameworksDemos/BinnedParticleSystem )
example( BulgeEffect                             openFrameworksDemos/BulgeEffect )
example( BulgeEffectMulti                        openFrameworksDemos/BulgeEffectMulti )
example( CircleRenderer                          openFrameworksDemos/CircleRenderer )
example( ColorCube                               openFrameworksDemos/ColorCube )
example( Fading                                  openFrameworksDemos/Fading )
example( GLSLParticleSystem                      openFrameworksDemos/GLSLParticleSystem )
example( LineDrawing                             openFrameworksDemos/LineDrawing )
example( LutExample                              openFrameworksDemos/LutExample )
example( NoiseFlocking                           openFrameworksDemos/NoiseFlocking )
example( P52OF                                   openFrameworksDemos/P52OF )
example( RemapExample                            openFrameworksDemos/RemapExample )
example( ShaderBuilder                           openFrameworksDemos/ShaderBuilder )
example( SignalPlot                              openFrameworksDemos/SignalPlot )
example( SimpleParticleSystem                    openFrameworksDemos/SimpleParticleSystem )
example( SphericalEnvironmentMapping             openFrameworksDemos/SphericalEnvironmentMapping )
example( StackedPlot                             openFrameworksDemos/StackedPlot )
example( TileMatching                            openFrameworksDemos/TileMatching )
example( Timelapse                               openFrameworksDemos/Timelapse )
example( Verlet                                  openFrameworksDemos/Verlet )
if(CMAKE_SYSTEM MATCHES Windows)
example( videoInputExample                       openFrameworksDemos/videoInputExample )
endif()
if(CMAKE_SYSTEM MATCHES Darwin)
example( VideoRecorder                           openFrameworksDemos/VideoRecorder )
example( VideoShuffler                           openFrameworksDemos/VideoShuffler )
endif()
example( Worm                                    openFrameworksDemos/Worm )

endif(openFrameworksDemos)


#// OF_GenerativeTypography ////////////////////////////////////////////////////


if(OF_GenerativeTypography)

example( AggregateDrawing                        OF_GenerativeTypography/AggregateDrawing )
example( AggregateParticles                      OF_GenerativeTypography/AggregateParticles )
example( Basic3DType                             OF_GenerativeTypography/Basic3DType )
example( Basic3DTypeVBO                          OF_GenerativeTypography/Basic3DTypeVBO )
example( CirclePacking                           OF_GenerativeTypography/CirclePacking )
example( CustomFont                              OF_GenerativeTypography/CustomFont )
example( DisplayText                             OF_GenerativeTypography/DisplayText )
example( FlowField                               OF_GenerativeTypography/FlowField )
example( FlowFieldVariant                        OF_GenerativeTypography/FlowFieldVariant )
example( GradientCutout                          OF_GenerativeTypography/GradientCutout )
example( InsideOutsideText                       OF_GenerativeTypography/InsideOutsideText )
example( LinesCircles                            OF_GenerativeTypography/LinesCircles )
example( MultiSampling                           OF_GenerativeTypography/MultiSampling )
example( Ocean                                   OF_GenerativeTypography/Ocean )
example( ReactionDiffusion                       OF_GenerativeTypography/ReactionDiffusion )
example( SpherePacking                           OF_GenerativeTypography/SpherePacking )
example( StringAsPoints                          OF_GenerativeTypography/StringAsPoints )
example( UsingFbo                                OF_GenerativeTypography/UsingFbo )
example( Voronoi3D                               OF_GenerativeTypography/Voronoi3D )
example( VoronoiType                             OF_GenerativeTypography/VoronoiType )
example( VoronoiVariant                          OF_GenerativeTypography/VoronoiVariant )
example( Waves                                   OF_GenerativeTypography/Waves )
example( WavesPDF                                OF_GenerativeTypography/WavesPDF )

endif()
