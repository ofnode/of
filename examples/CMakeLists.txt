cmake_minimum_required(VERSION 2.8)

project(ofExamples)

set(ofExamples              ON)
set(res15-opengl            ON)
set(ofDemystified           ON)
set(BeyondInteraction       ON)
set(openFrameworksDemos     ON)
set(OF_GenerativeTypography ON)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/..")

include(openFrameworks)

if(MSVC)
    set(NO_WARNINGS /w)
else()
    set(NO_WARNINGS -w)
endif()

function(example APP DIR)

    file(GLOB_RECURSE SRC "${CMAKE_CURRENT_LIST_DIR}/${DIR}/*.cpp")

    add_executable(${APP} ${SRC})
    target_link_libraries(${APP} ofxAddons ${OPENFRAMEWORKS_LIBRARIES})
    set_target_properties(${APP} PROPERTIES COMPILE_FLAGS ${NO_WARNINGS})
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

ofxaddon(addons/ofxBox2d)
ofxaddon(addons/ofxPointInMesh)
ofxaddon(addons/ofxVoronoi)
ofxaddon(addons/ofxVoro)

add_library(ofxAddons STATIC ${OFXADDONS_SOURCES})


#// LIBRARIES FOR OFXADDONS ////////////////////////////////////////////////////


include_directories("${CMAKE_CURRENT_LIST_DIR}/addons/ofxBox2d/libs")
file(GLOB_RECURSE OFXBOX2D_SOURCES "${CMAKE_CURRENT_LIST_DIR}/addons/ofxBox2d/libs/*.cpp")
add_library(ofxBox2d STATIC ${OFXBOX2D_SOURCES})
set_target_properties(ofxBox2d PROPERTIES COMPILE_FLAGS ${NO_WARNINGS})
list(APPEND OPENFRAMEWORKS_LIBRARIES ofxBox2d)

include_directories("${CMAKE_CURRENT_LIST_DIR}/addons/ofxVoronoi/libs/Voro++2D")
file(GLOB_RECURSE OFXVORONOI_SOURCES "${CMAKE_CURRENT_LIST_DIR}/addons/ofxVoronoi/libs/*.cpp")
add_library(ofxVoronoi STATIC ${OFXVORONOI_SOURCES})
set_target_properties(ofxVoronoi PROPERTIES COMPILE_FLAGS ${NO_WARNINGS})
list(APPEND OPENFRAMEWORKS_LIBRARIES ofxVoronoi)

include_directories("${CMAKE_CURRENT_LIST_DIR}/addons/ofxVoro/libs/voro++")
file(GLOB_RECURSE OFXVORO_SOURCES "${CMAKE_CURRENT_LIST_DIR}/addons/ofxVoro/libs/*.cc")
add_library(ofxVoro STATIC ${OFXVORO_SOURCES})
set_target_properties(ofxVoro PROPERTIES COMPILE_FLAGS ${NO_WARNINGS})
list(APPEND OPENFRAMEWORKS_LIBRARIES ofxVoro)


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


#// ofDemystified //////////////////////////////////////////////////////////////


if(ofDemystified)

example( Pendulum                                ofDemystified/01-Basics/01-Pendulum )

example( PulsatingBackground                     ofDemystified/02-2D/01-PulsatingBackground )
example( FlowerSimplest                          ofDemystified/02-2D/02-FlowerSimplest )
example( FlowerControlPoints                     ofDemystified/02-2D/03-FlowerControlPoints )
example( FlowerWithPetals                        ofDemystified/02-2D/04-FlowerWithPetals )
example( Colors                                  ofDemystified/02-2D/05-Colors )
example( Spirals                                 ofDemystified/02-2D/06-Spirals )

example( SingleParticle                          ofDemystified/03-Particles/01-SingleParticle )
example( ParticlesEmitter                        ofDemystified/03-Particles/02-ParticlesEmitter )
example( ParticlesForces                         ofDemystified/03-Particles/03-ParticlesForces )
example( Particles                               ofDemystified/03-Particles/04-Particles )

example( ImageDraw                               ofDemystified/04-Images/01-ImageDraw )
example( ImageSpiral                             ofDemystified/04-Images/02-ImageSpiral )
example( ImageTransp                             ofDemystified/04-Images/03-ImageTransp )
example( ColorWaves                              ofDemystified/04-Images/04-ColorWaves )
example( ImageModify                             ofDemystified/04-Images/05-ImageModify )
example( HorizontalDistortion                    ofDemystified/04-Images/06-HorizontalDistortion )
example( VideoMapping                            ofDemystified/04-Images/07-VideoMapping )

example( VideoPlayback                           ofDemystified/05-Video/01-VideoPlayback )
example( VideoVerticals                          ofDemystified/05-Video/02-VideoVerticals )
example( VideoReplacingColors                    ofDemystified/05-Video/03-VideoReplacingColors )
example( VideoSlitScan                           ofDemystified/05-Video/04-VideoSlitScan )
example( VideoCameraSynth                        ofDemystified/05-Video/05-VideoCameraSynth )
example( VideoImageSequence                      ofDemystified/05-Video/06-VideoImageSequence )

example( BouncingBall                            ofDemystified/06-Sound/01-BouncingBall )
example( SingingVoices                           ofDemystified/06-Sound/02-SingingVoices )
example( PWMSynth                                ofDemystified/06-Sound/03-PWMSynth )
example( ImageToSound                            ofDemystified/06-Sound/04-ImageToSound )
example( LoopSampler                             ofDemystified/06-Sound/05-LoopSampler )
example( DancingCloud                            ofDemystified/06-Sound/06-DancingCloud )

example( TrianglesCloud                          ofDemystified/07-3D/01-TrianglesCloud )
example( PyramidMesh                             ofDemystified/07-3D/02-PyramidMesh )
example( PyramidLighting                         ofDemystified/07-3D/03-PyramidLighting )
example( PyramidSharpEdges                       ofDemystified/07-3D/04-PyramidSharpEdges )
example( PyramidTextured                         ofDemystified/07-3D/05-PyramidTextured )
example( OscillatingPlane                        ofDemystified/07-3D/06-OscillatingPlane )
example( TwistingKnot                            ofDemystified/07-3D/07-TwistingKnot )

example( ShaderInverting                         ofDemystified/08-Shaders/01-ShaderInverting )
example( ShaderHorizDistortion                   ofDemystified/08-Shaders/02-ShaderHorizDistortion )
example( ShaderLiquify                           ofDemystified/08-Shaders/03-ShaderLiquify )
example( ShaderMasking                           ofDemystified/08-Shaders/04-ShaderMasking )
example( ShaderAudioReactive                     ofDemystified/08-Shaders/05-ShaderAudioReactive )
example( VertexDeformation                       ofDemystified/08-Shaders/06-VertexDeformation )
example( GeometryFurryCarpet                     ofDemystified/08-Shaders/07-GeometryFurryCarpet )

example( MotionDetection                         ofDemystified/09-OpenCV/01-MotionDetection )
example( ImageFiltering                          ofDemystified/09-OpenCV/02-ImageFiltering )
example( PerspectiveRemoving                     ofDemystified/09-OpenCV/03-PerspectiveRemoving )
example( SearchingObjects                        ofDemystified/09-OpenCV/04-SearchingObjects )
example( VideoMorphing                           ofDemystified/09-OpenCV/05-VideoMorphing )

example( PerlinGraph                             ofDemystified/13-PerlinNoise/01-PerlinGraph )
example( PerlinPoints                            ofDemystified/13-PerlinNoise/02-PerlinPoints )
example( PerlinTexture                           ofDemystified/13-PerlinNoise/03-PerlinTexture )

endif(ofDemystified)


#// BeyondInteraction //////////////////////////////////////////////////////////


if(BeyondInteraction)

example( app-2-2_A                               BeyondInteraction/2-2_A )
example( app-2-2_B                               BeyondInteraction/2-2_B )
example( app-2-2_C                               BeyondInteraction/2-2_C )
example( app-2-2_D                               BeyondInteraction/2-2_D )
example( app-2-2_E                               BeyondInteraction/2-2_E )
example( app-2-3_A                               BeyondInteraction/2-3_A )
example( app-2-3_B                               BeyondInteraction/2-3_B )
example( app-2-3_C                               BeyondInteraction/2-3_C )
example( app-2-4_A                               BeyondInteraction/2-4_A )
example( app-2-4_B                               BeyondInteraction/2-4_B )
example( app-2-4_C                               BeyondInteraction/2-4_C )
example( app-2-4_D                               BeyondInteraction/2-4_D )
example( app-2-5_A                               BeyondInteraction/2-5_A )
example( app-2-5_B                               BeyondInteraction/2-5_B )
example( app-2-5_C                               BeyondInteraction/2-5_C )
example( app-2-5_D                               BeyondInteraction/2-5_D )
example( app-2-6_A                               BeyondInteraction/2-6_A )
example( app-2-6_B                               BeyondInteraction/2-6_B )
example( app-2-6_C                               BeyondInteraction/2-6_C )
example( app-2-6_C-2                             BeyondInteraction/2-6_C-2 )
example( app-2-6_C-3                             BeyondInteraction/2-6_C-3 )
example( app-2-6_C-4                             BeyondInteraction/2-6_C-4 )
example( app-2-7_A                               BeyondInteraction/2-7_A )
example( app-2-8_A                               BeyondInteraction/2-8_A )
example( app-2-8_B                               BeyondInteraction/2-8_B )
example( app-2-9_A                               BeyondInteraction/2-9_A )
example( app-2-9_B                               BeyondInteraction/2-9_B )
example( app-2-9_C                               BeyondInteraction/2-9_C )
example( app-2-9_D                               BeyondInteraction/2-9_D )
example( app-2-10_A                              BeyondInteraction/2-10_A )
example( app-2-10_B                              BeyondInteraction/2-10_B )
example( app-2-10_C                              BeyondInteraction/2-10_C )
example( app-2-11_A                              BeyondInteraction/2-11_A )
example( app-2-11_B                              BeyondInteraction/2-11_B )
example( app-3-1_A                               BeyondInteraction/3-1_A )
example( app-3-1_B                               BeyondInteraction/3-1_B )
example( app-3-2_A                               BeyondInteraction/3-2_A )
example( app-3-2_B                               BeyondInteraction/3-2_B )
example( app-3-2_C                               BeyondInteraction/3-2_C )
example( app-3-2_D                               BeyondInteraction/3-2_D )
example( app-3-2_E                               BeyondInteraction/3-2_E )
example( app-3-2_F                               BeyondInteraction/3-2_F )
example( app-3-2_G                               BeyondInteraction/3-2_G )
example( app-3-2_H                               BeyondInteraction/3-2_H )
example( app-3-2_I                               BeyondInteraction/3-2_I )
example( app-3-2_J                               BeyondInteraction/3-2_J )
example( app-3-2_K                               BeyondInteraction/3-2_K )
example( app-3-3_A                               BeyondInteraction/3-3_A )
example( app-3-3_B                               BeyondInteraction/3-3_B )
example( app-3-3_C                               BeyondInteraction/3-3_C )
example( app-3-3_D                               BeyondInteraction/3-3_D )
example( app-3-3_E                               BeyondInteraction/3-3_E )
example( app-3-3_F                               BeyondInteraction/3-3_F )
example( app-3-3_G                               BeyondInteraction/3-3_G )
example( app-3-4_A                               BeyondInteraction/3-4_A )
example( app-3-4_B                               BeyondInteraction/3-4_B )
example( app-3-4_C                               BeyondInteraction/3-4_C )
example( app-3-4_D                               BeyondInteraction/3-4_D )
example( app-3-4_E                               BeyondInteraction/3-4_E )
example( app-3-4_F                               BeyondInteraction/3-4_F )
example( app-3-4_G                               BeyondInteraction/3-4_G )
example( app-3-5_A                               BeyondInteraction/3-5_A )
example( Cosmos_full                             BeyondInteraction/4_Cosmos_full )
example( Cosmos_simple                           BeyondInteraction/4_Cosmos_simple )
example( LineSketch                              BeyondInteraction/4_LineSketch )
example( OpticalFlowSketch1                      BeyondInteraction/4_OpticalFlowSketch1 )
example( OpticalFlowSketch2                      BeyondInteraction/4_OpticalFlowSketch2 )

endif(BeyondInteraction)


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

endif(OF_GenerativeTypography)
