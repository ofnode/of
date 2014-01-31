
CROSS_OF = $$PWD

OF      = $$CROSS_OF/openFrameworks
OF_LIBS = $$CROSS_OF/Dependencies/Libs/

DEFINES *= POCO_STATIC

unix {
LIBS += $$CROSS_OF/Compiled/linux-64/libopenFrameworks.a

LIBS += -Wl,--start-group
LIBS += $$PWD/Dependencies/Compiled/linux-64/libPocoNet.a
LIBS += $$PWD/Dependencies/Compiled/linux-64/libPocoXML.a
LIBS += $$PWD/Dependencies/Compiled/linux-64/libPocoUtil.a
LIBS += $$PWD/Dependencies/Compiled/linux-64/libPocoFoundation.a
LIBS += $$PWD/Dependencies/Compiled/linux-64/libPocoNetSSL.a
LIBS += $$PWD/Dependencies/Compiled/linux-64/libPocoCrypto.a
LIBS += -Wl,--end-group
LIBS += $$PWD/Dependencies/Compiled/linux-64/libglfw3.a

LIBS += -lz
LIBS += -ludev
LIBS += -lm
LIBS += -lpthread
LIBS += -lssl
LIBS += -lcrypto
LIBS += -lGLEW
LIBS += -lGLU
LIBS += -lGL
LIBS += -lgtk-x11-2.0
LIBS += -lgdk-x11-2.0
LIBS += -lpangocairo-1.0
LIBS += -latk-1.0
LIBS += -lcairo
LIBS += -lgdk_pixbuf-2.0
LIBS += -lgio-2.0
LIBS += -lpangoft2-1.0
LIBS += -lpango-1.0
LIBS += -lgobject-2.0
LIBS += -lglib-2.0
LIBS += -lfontconfig
LIBS += -lfreetype
LIBS += -lglut
LIBS += -lX11
LIBS += -lXrandr
LIBS += -lXxf86vm
LIBS += -lXi
LIBS += -lfreeimage

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
INCLUDEPATH *= /usr/include/libpng15
}

win32 {
QMAKE_LFLAGS += -static-libgcc
QMAKE_LFLAGS += -static-libstdc++

LIBS += $$CROSS_OF/Compiled/mingw-64/libopenFrameworks.a

LIBS += -Wl,--start-group

LIBS += $$PWD/Dependencies/Compiled/mingw-64/libPocoNet.a
LIBS += $$PWD/Dependencies/Compiled/mingw-64/libPocoXML.a
LIBS += $$PWD/Dependencies/Compiled/mingw-64/libPocoUtil.a
LIBS += $$PWD/Dependencies/Compiled/mingw-64/libPocoFoundation.a
LIBS += $$PWD/Dependencies/Compiled/mingw-64/libPocoNetSSL.a
LIBS += $$PWD/Dependencies/Compiled/mingw-64/libPocoCrypto.a
LIBS += $$PWD/Dependencies/Compiled/mingw-64/libglfw3.a

LIBS += /usr/x86_64-w64-mingw32/lib/libwinpthread.a
LIBS += /usr/x86_64-w64-mingw32/lib/libwinmm.a
LIBS += /usr/x86_64-w64-mingw32/lib/libws2_32.a
LIBS += /usr/x86_64-w64-mingw32/lib/libwsock32.a
LIBS += /usr/x86_64-w64-mingw32/lib/libiphlpapi.a
LIBS += /usr/x86_64-w64-mingw32/lib/libgdi32.a
LIBS += /usr/x86_64-w64-mingw32/lib/libopengl32.a
LIBS += /usr/x86_64-w64-mingw32/lib/libz.a
LIBS += /usr/x86_64-w64-mingw32/lib/libm.a
LIBS += /usr/x86_64-w64-mingw32/lib/libpthread.a
LIBS += /usr/x86_64-w64-mingw32/lib/libssl.a
LIBS += /usr/x86_64-w64-mingw32/lib/libcrypto.a
LIBS += /usr/x86_64-w64-mingw32/lib/libglew32.a
LIBS += /usr/x86_64-w64-mingw32/lib/libglu32.a
LIBS += /usr/x86_64-w64-mingw32/lib/libcairo.a
LIBS += /usr/x86_64-w64-mingw32/lib/libpixman-1.a
LIBS += /usr/x86_64-w64-mingw32/lib/libfontconfig.a
LIBS += /usr/x86_64-w64-mingw32/lib/libfreetype.a
LIBS += /usr/x86_64-w64-mingw32/lib/libFreeImage.a

LIBS += -Wl,--end-group

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

# tess2
TESS = $$PWD/Dependencies/Libs/tess2

INCLUDEPATH *= $$TESS/Sources
INCLUDEPATH *= $$TESS/include
INCLUDEPATH *= $$TESS

HEADERS *= $$TESS/include/tesselator.h
HEADERS *= $$TESS/Sources/geom.h
HEADERS *= $$TESS/Sources/bucketalloc.h
HEADERS *= $$TESS/Sources/tess.h
HEADERS *= $$TESS/Sources/priorityq.h
HEADERS *= $$TESS/Sources/sweep.h
HEADERS *= $$TESS/Sources/dict.h
HEADERS *= $$TESS/Sources/mesh.h

SOURCES *= $$TESS/Sources/geom.c
SOURCES *= $$TESS/Sources/dict.c
SOURCES *= $$TESS/Sources/tess.c
SOURCES *= $$TESS/Sources/sweep.c
SOURCES *= $$TESS/Sources/priorityq.c
SOURCES *= $$TESS/Sources/bucketalloc.c
SOURCES *= $$TESS/Sources/mesh.c

# kiss
KISS = $$PWD/Dependencies/Libs/kiss

INCLUDEPATH *= $$KISS/include
INCLUDEPATH *= $$KISS/src
INCLUDEPATH *= $$KISS

HEADERS *= $$KISS/src/_kiss_fft_guts.h
HEADERS *= $$KISS/include/kiss_fft.h
HEADERS *= $$KISS/include/kiss_fftr.h

SOURCES *= $$KISS/src/kiss_fftr.c
SOURCES *= $$KISS/src/kiss_fft.c

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

