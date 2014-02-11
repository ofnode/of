
OF      = $$PWD/openFrameworks
OF_LIBS = $$PWD/Dependencies/Libs/

TEMPLATE  = lib
CONFIG   += staticlib
TARGET    = openFrameworks

CONFIG -= qt
CONFIG -= warn_on

QMAKE_CXXFLAGS = -std=c++11 -W

QMAKE_CXXFLAGS_DEBUG   = -O0 -g
QMAKE_CXXFLAGS_RELEASE = -O3

DEFINES *= POCO_STATIC
DEFINES *= POCO_NO_AUTOMATIC_LIB_INIT
DEFINES *= FREEIMAGE_LIB
DEFINES *= TARGET_NO_SOUND

unix {
# Clang
QMAKE_CXXFLAGS += -Wno-unused-parameter
QMAKE_CXXFLAGS += -Wno-deprecated-register

DESTDIR = $$PWD/Compiled/linux-64

INCLUDEPATH *= /usr/include/GL
INCLUDEPATH *= /usr/include/gtk-2.0
INCLUDEPATH *= /usr/lib/gtk-2.0/include
INCLUDEPATH *= /usr/include/pango-1.0
INCLUDEPATH *= /usr/include/atk-1.0
INCLUDEPATH *= /usr/include/pixman-1
INCLUDEPATH *= /usr/include/libdrm
INCLUDEPATH *= /usr/include/libpng16
INCLUDEPATH *= /usr/include/gdk-pixbuf-2.0
INCLUDEPATH *= /usr/include/harfbuzz
INCLUDEPATH *= /usr/include/glib-2.0
INCLUDEPATH *= /usr/lib/glib-2.0/include
INCLUDEPATH *= /usr/include/freetype2
INCLUDEPATH *= /usr/include/cairo
}

win32 {
# MinGW-w64
QMAKE_CXXFLAGS += -Wno-unused-parameter
QMAKE_CXXFLAGS += -Wno-unused-variable
QMAKE_CXXFLAGS += -Wno-extra

DEFINES -= UNICODE
DEFINES *= __MINGW32_VERSION

DESTDIR = $$PWD/Compiled/mingw-64

INCLUDEPATH *= /usr/x86_64-w64-mingw32/include
INCLUDEPATH *= /usr/x86_64-w64-mingw32/include/GL
INCLUDEPATH *= /usr/x86_64-w64-mingw32/include/cairo
INCLUDEPATH *= /usr/x86_64-w64-mingw32/include/freetype2
}

# openFrameworks
INCLUDEPATH *= $$OF/3d
INCLUDEPATH *= $$OF
INCLUDEPATH *= $$OF/graphics
INCLUDEPATH *= $$OF/communication
INCLUDEPATH *= $$OF/math
INCLUDEPATH *= $$OF/events
INCLUDEPATH *= $$OF/types
INCLUDEPATH *= $$OF/utils
INCLUDEPATH *= $$OF/app
INCLUDEPATH *= $$OF/gl

SOURCES *= $$OF/math/ofQuaternion.cpp
SOURCES *= $$OF/math/ofVec2f.cpp
SOURCES *= $$OF/math/ofMatrix4x4.cpp
SOURCES *= $$OF/math/ofVec4f.cpp
SOURCES *= $$OF/math/ofMath.cpp
SOURCES *= $$OF/math/ofMatrix3x3.cpp
SOURCES *= $$OF/app/ofAppRunner.cpp
SOURCES *= $$OF/app/ofAppGlutWindow.cpp
SOURCES *= $$OF/app/ofAppNoWindow.cpp
SOURCES *= $$OF/app/ofAppGLFWWindow.cpp
SOURCES *= $$OF/gl/ofGLProgrammableRenderer.cpp
SOURCES *= $$OF/gl/ofFbo.cpp
SOURCES *= $$OF/gl/ofMaterial.cpp
SOURCES *= $$OF/gl/ofVboMesh.cpp
SOURCES *= $$OF/gl/ofGLUtils.cpp
SOURCES *= $$OF/gl/ofShader.cpp
SOURCES *= $$OF/gl/ofTexture.cpp
SOURCES *= $$OF/gl/ofGLRenderer.cpp
SOURCES *= $$OF/gl/ofLight.cpp
SOURCES *= $$OF/gl/ofVbo.cpp
SOURCES *= $$OF/events/ofEvents.cpp
SOURCES *= $$OF/types/ofBaseTypes.cpp
SOURCES *= $$OF/types/ofRectangle.cpp
SOURCES *= $$OF/types/ofParameterGroup.cpp
SOURCES *= $$OF/types/ofColor.cpp
SOURCES *= $$OF/types/ofParameter.cpp
SOURCES *= $$OF/communication/ofSerial.cpp
SOURCES *= $$OF/communication/ofArduino.cpp
SOURCES *= $$OF/3d/of3dPrimitives.cpp
SOURCES *= $$OF/3d/ofMesh.cpp
SOURCES *= $$OF/3d/ofNode.cpp
SOURCES *= $$OF/3d/ofCamera.cpp
SOURCES *= $$OF/3d/of3dUtils.cpp
SOURCES *= $$OF/3d/ofEasyCam.cpp
SOURCES *= $$OF/graphics/ofTessellator.cpp
SOURCES *= $$OF/graphics/ofCairoRenderer.cpp
SOURCES *= $$OF/graphics/ofImage.cpp
SOURCES *= $$OF/graphics/ofRendererCollection.cpp
SOURCES *= $$OF/graphics/ofPixels.cpp
SOURCES *= $$OF/graphics/of3dGraphics.cpp
SOURCES *= $$OF/graphics/ofGraphics.cpp
SOURCES *= $$OF/graphics/ofTrueTypeFont.cpp
SOURCES *= $$OF/graphics/ofPath.cpp
SOURCES *= $$OF/graphics/ofBitmapFont.cpp
SOURCES *= $$OF/graphics/ofPolyline.cpp
SOURCES *= $$OF/utils/ofURLFileLoader.cpp
SOURCES *= $$OF/utils/ofUtils.cpp
SOURCES *= $$OF/utils/ofLog.cpp
SOURCES *= $$OF/utils/ofSystemUtils.cpp
SOURCES *= $$OF/utils/ofFileUtils.cpp
SOURCES *= $$OF/utils/ofXml.cpp
SOURCES *= $$OF/utils/ofMatrixStack.cpp
SOURCES *= $$OF/utils/ofThread.cpp

# tess2
TESS = $$PWD/Dependencies/Libs/tess2

INCLUDEPATH *= $$TESS/Sources
INCLUDEPATH *= $$TESS/include
INCLUDEPATH *= $$TESS

# kiss
KISS = $$PWD/Dependencies/Libs/kiss

INCLUDEPATH *= $$KISS/include
INCLUDEPATH *= $$KISS/src
INCLUDEPATH *= $$KISS

# glfw
GLFW = $$PWD/Dependencies/Libs/glfw

INCLUDEPATH *= $$GLFW/include
INCLUDEPATH *= $$GLFW/include/GLFW
INCLUDEPATH *= $$GLFW

# poco
POCO = $$PWD/Dependencies/Libs/poco

INCLUDEPATH *= $$POCO/Net/include
INCLUDEPATH *= $$POCO/XML/include/Poco/DOM
INCLUDEPATH *= $$POCO/Foundation/include
INCLUDEPATH *= $$POCO/Foundation/include/Poco
INCLUDEPATH *= $$POCO/Zip/include
INCLUDEPATH *= $$POCO/Crypto/include/Poco
INCLUDEPATH *= $$POCO
INCLUDEPATH *= $$POCO/Crypto/include
INCLUDEPATH *= $$POCO/Foundation/include/Poco/Dynamic
INCLUDEPATH *= $$POCO/Net/include/Poco
INCLUDEPATH *= $$POCO/NetSSL_OpenSSL/include
INCLUDEPATH *= $$POCO/NetSSL_OpenSSL/include/Poco/Net
INCLUDEPATH *= $$POCO/Zip/include/Poco
INCLUDEPATH *= $$POCO/XML/include/Poco/XML
INCLUDEPATH *= $$POCO/Zip/include/Poco/Zip
INCLUDEPATH *= $$POCO/Crypto/include/Poco/Crypto
INCLUDEPATH *= $$POCO/XML/include/Poco
INCLUDEPATH *= $$POCO/XML/include/Poco/SAX
INCLUDEPATH *= $$POCO/Net/include/Poco/Net
INCLUDEPATH *= $$POCO/NetSSL_OpenSSL/include/Poco
INCLUDEPATH *= $$POCO/Util/include/Poco/Util
INCLUDEPATH *= $$POCO/Util/include/Poco
INCLUDEPATH *= $$POCO/Util/include
INCLUDEPATH *= $$POCO/XML/include
