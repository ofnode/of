
if(${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
    set(CROSSOF_INCLUDE_DIRS
        "/usr/include/atk-1.0"
        "/usr/include/cairo"
        "/usr/include/freetype2"
        "/usr/include/GL"
        "/usr/include/gdk-pixbuf-2.0"
        "/usr/include/glib-2.0"
        "/usr/include/gtk-2.0"
        "/usr/include/harfbuzz"
        "/usr/include/libdrm"
        "/usr/include/libpng16"
        "/usr/include/pango-1.0"
        "/usr/include/pixman-1"
        
        "/usr/lib/glib-2.0/include"
        "/usr/lib/gtk-2.0/include"
    )
    
    set(CROSSOF_LIBRARIES
        -Wl,--start-group
        "${CROSSOF}/Compiled/linux-64/libopenFrameworks.a"
        "${CROSSOF}/Dependencies/Compiled/linux-64/libPocoNet.a"
        "${CROSSOF}/Dependencies/Compiled/linux-64/libPocoXML.a"
        "${CROSSOF}/Dependencies/Compiled/linux-64/libPocoUtil.a"
        "${CROSSOF}/Dependencies/Compiled/linux-64/libPocoFoundation.a"
        "${CROSSOF}/Dependencies/Compiled/linux-64/libPocoNetSSL.a"
        "${CROSSOF}/Dependencies/Compiled/linux-64/libPocoCrypto.a"
        "${CROSSOF}/Dependencies/Compiled/linux-64/libglfw3.a"
        "${CROSSOF}/Dependencies/Compiled/linux-64/libkiss.a"
        "${CROSSOF}/Dependencies/Compiled/linux-64/libtess2.a"
        z
        udev
        m
        pthread
        ssl
        crypto
        GLEW
        GLU
        GL
        gtk-x11-2.0
        gdk-x11-2.0
        pangocairo-1.0
        atk-1.0
        cairo
        gdk_pixbuf-2.0
        gio-2.0
        pangoft2-1.0
        pango-1.0
        gobject-2.0
        glib-2.0
        fontconfig
        freetype
        glut
        X11
        Xrandr
        Xcursor
        Xxf86vm
        Xi
        freeimage
        -Wl,--end-group
    )
endif()

if(WIN32)
    set(CROSSOF_INCLUDE_DIRS
        "/usr/x86_64-w64-mingw32/include"
        "/usr/x86_64-w64-mingw32/include/GL"
        "/usr/x86_64-w64-mingw32/include/cairo"
        "/usr/x86_64-w64-mingw32/include/freetype2"
    )

    set(CROSSOF_LIBRARIES
        -static-libgcc
        -static-libstdc++
        -Wl,--start-group
        "${CROSSOF}/Compiled/mingw-64/libopenFrameworks.a"
        "${CROSSOF}/Dependencies/Compiled/mingw-64/libPocoNet.a"
        "${CROSSOF}/Dependencies/Compiled/mingw-64/libPocoXML.a"
        "${CROSSOF}/Dependencies/Compiled/mingw-64/libPocoUtil.a"
        "${CROSSOF}/Dependencies/Compiled/mingw-64/libPocoFoundation.a"
        "${CROSSOF}/Dependencies/Compiled/mingw-64/libPocoNetSSL.a"
        "${CROSSOF}/Dependencies/Compiled/mingw-64/libPocoCrypto.a"
        "${CROSSOF}/Dependencies/Compiled/mingw-64/libglfw3.a"
        "${CROSSOF}/Dependencies/Compiled/mingw-64/libkiss.a"
        "${CROSSOF}/Dependencies/Compiled/mingw-64/libtess2.a"
        "/usr/x86_64-w64-mingw32/lib/libwinpthread.a"
        "/usr/x86_64-w64-mingw32/lib/libwinmm.a"
        "/usr/x86_64-w64-mingw32/lib/libws2_32.a"
        "/usr/x86_64-w64-mingw32/lib/libwsock32.a"
        "/usr/x86_64-w64-mingw32/lib/libiphlpapi.a"
        "/usr/x86_64-w64-mingw32/lib/libgdi32.a"
        "/usr/x86_64-w64-mingw32/lib/libopengl32.a"
        "/usr/x86_64-w64-mingw32/lib/libz.a"
        "/usr/x86_64-w64-mingw32/lib/libm.a"
        "/usr/x86_64-w64-mingw32/lib/libpthread.a"
        "/usr/x86_64-w64-mingw32/lib/libssl.a"
        "/usr/x86_64-w64-mingw32/lib/libcrypto.a"
        "/usr/x86_64-w64-mingw32/lib/libglew32.a"
        "/usr/x86_64-w64-mingw32/lib/libglu32.a"
        "/usr/x86_64-w64-mingw32/lib/libcairo.a"
        "/usr/x86_64-w64-mingw32/lib/libpixman-1.a"
        "/usr/x86_64-w64-mingw32/lib/libfontconfig.a"
        "/usr/x86_64-w64-mingw32/lib/libfreetype.a"
        "/usr/x86_64-w64-mingw32/lib/libFreeImage.a"
        -Wl,--end-group
    )
endif()

set(CROSSOF_INCLUDE_DIRS ${CROSSOF_INCLUDE_DIRS}
    "${CROSSOF}/openFrameworks"
    "${CROSSOF}/openFrameworks/3d"
    "${CROSSOF}/openFrameworks/app"
    "${CROSSOF}/openFrameworks/communication"
    "${CROSSOF}/openFrameworks/events"
    "${CROSSOF}/openFrameworks/gl"
    "${CROSSOF}/openFrameworks/graphics"
    "${CROSSOF}/openFrameworks/math"
    "${CROSSOF}/openFrameworks/types"
    "${CROSSOF}/openFrameworks/utils"
    
    "${CROSSOF}/Dependencies/Libs/glfw"
    "${CROSSOF}/Dependencies/Libs/glfw/include"
    "${CROSSOF}/Dependencies/Libs/glfw/include/GLFW"
    
    "${CROSSOF}/Dependencies/Libs/kiss"
    "${CROSSOF}/Dependencies/Libs/kiss/include"
    "${CROSSOF}/Dependencies/Libs/kiss/src"
    
    "${CROSSOF}/Dependencies/Libs/poco"
    "${CROSSOF}/Dependencies/Libs/poco/Crypto/include"
    "${CROSSOF}/Dependencies/Libs/poco/Crypto/include/Poco"
    "${CROSSOF}/Dependencies/Libs/poco/Crypto/include/Poco/Crypto"

    "${CROSSOF}/Dependencies/Libs/poco/Foundation/include"
    "${CROSSOF}/Dependencies/Libs/poco/Foundation/include/Poco"
    "${CROSSOF}/Dependencies/Libs/poco/Foundation/include/Poco/Dynamic"

    "${CROSSOF}/Dependencies/Libs/poco/Net/include"
    "${CROSSOF}/Dependencies/Libs/poco/Net/include/Poco"
    "${CROSSOF}/Dependencies/Libs/poco/Net/include/Poco/Net"

    "${CROSSOF}/Dependencies/Libs/poco/NetSSL_OpenSSL/include"
    "${CROSSOF}/Dependencies/Libs/poco/NetSSL_OpenSSL/include/Poco"
    "${CROSSOF}/Dependencies/Libs/poco/NetSSL_OpenSSL/include/Poco/Net"

    "${CROSSOF}/Dependencies/Libs/poco/Util/include"
    "${CROSSOF}/Dependencies/Libs/poco/Util/include/Poco"
    "${CROSSOF}/Dependencies/Libs/poco/Util/include/Poco/Util"
    
    "${CROSSOF}/Dependencies/Libs/poco/XML/include"
    "${CROSSOF}/Dependencies/Libs/poco/XML/include/Poco"
    "${CROSSOF}/Dependencies/Libs/poco/XML/include/Poco/DOM"
    "${CROSSOF}/Dependencies/Libs/poco/XML/include/Poco/SAX"
    "${CROSSOF}/Dependencies/Libs/poco/XML/include/Poco/XML"
    
    "${CROSSOF}/Dependencies/Libs/poco/Zip/include"
    "${CROSSOF}/Dependencies/Libs/poco/Zip/include/Poco"
    "${CROSSOF}/Dependencies/Libs/poco/Zip/include/Poco/Zip"
    
    "${CROSSOF}/Dependencies/Libs/tess2"
    "${CROSSOF}/Dependencies/Libs/tess2/include"
    "${CROSSOF}/Dependencies/Libs/tess2/Sources"
)

set(CROSSOF_DEFINITIONS
    -DPOCO_STATIC
)

