
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
        "${CMAKE_CURRENT_LIST_DIR}/Compiled/linux-64/libopenFrameworks.a"
        "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Compiled/linux-64/libPocoNet.a"
        "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Compiled/linux-64/libPocoXML.a"
        "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Compiled/linux-64/libPocoUtil.a"
        "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Compiled/linux-64/libPocoFoundation.a"
        "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Compiled/linux-64/libPocoNetSSL.a"
        "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Compiled/linux-64/libPocoCrypto.a"
        "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Compiled/linux-64/libglfw3.a"
        "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Compiled/linux-64/libkiss.a"
        "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Compiled/linux-64/libtess2.a"
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
        "${CMAKE_CURRENT_LIST_DIR}/Compiled/mingw-64/libopenFrameworks.a"
        "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Compiled/mingw-64/libPocoNet.a"
        "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Compiled/mingw-64/libPocoXML.a"
        "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Compiled/mingw-64/libPocoUtil.a"
        "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Compiled/mingw-64/libPocoFoundation.a"
        "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Compiled/mingw-64/libPocoNetSSL.a"
        "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Compiled/mingw-64/libPocoCrypto.a"
        "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Compiled/mingw-64/libglfw3.a"
        "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Compiled/mingw-64/libkiss.a"
        "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Compiled/mingw-64/libtess2.a"
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
    "${CMAKE_CURRENT_LIST_DIR}/openFrameworks"
    "${CMAKE_CURRENT_LIST_DIR}/openFrameworks/3d"
    "${CMAKE_CURRENT_LIST_DIR}/openFrameworks/app"
    "${CMAKE_CURRENT_LIST_DIR}/openFrameworks/communication"
    "${CMAKE_CURRENT_LIST_DIR}/openFrameworks/events"
    "${CMAKE_CURRENT_LIST_DIR}/openFrameworks/gl"
    "${CMAKE_CURRENT_LIST_DIR}/openFrameworks/graphics"
    "${CMAKE_CURRENT_LIST_DIR}/openFrameworks/math"
    "${CMAKE_CURRENT_LIST_DIR}/openFrameworks/types"
    "${CMAKE_CURRENT_LIST_DIR}/openFrameworks/utils"
    
    "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Libs/glfw"
    "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Libs/glfw/include"
    "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Libs/glfw/include/GLFW"
    
    "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Libs/kiss"
    "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Libs/kiss/include"
    "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Libs/kiss/src"
    
    "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Libs/poco"
    "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Libs/poco/Crypto/include"
    "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Libs/poco/Crypto/include/Poco"
    "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Libs/poco/Crypto/include/Poco/Crypto"

    "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Libs/poco/Foundation/include"
    "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Libs/poco/Foundation/include/Poco"
    "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Libs/poco/Foundation/include/Poco/Dynamic"

    "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Libs/poco/Net/include"
    "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Libs/poco/Net/include/Poco"
    "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Libs/poco/Net/include/Poco/Net"

    "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Libs/poco/NetSSL_OpenSSL/include"
    "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Libs/poco/NetSSL_OpenSSL/include/Poco"
    "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Libs/poco/NetSSL_OpenSSL/include/Poco/Net"

    "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Libs/poco/Util/include"
    "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Libs/poco/Util/include/Poco"
    "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Libs/poco/Util/include/Poco/Util"
    
    "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Libs/poco/XML/include"
    "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Libs/poco/XML/include/Poco"
    "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Libs/poco/XML/include/Poco/DOM"
    "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Libs/poco/XML/include/Poco/SAX"
    "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Libs/poco/XML/include/Poco/XML"
    
    "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Libs/poco/Zip/include"
    "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Libs/poco/Zip/include/Poco"
    "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Libs/poco/Zip/include/Poco/Zip"
    
    "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Libs/tess2"
    "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Libs/tess2/include"
    "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Libs/tess2/Sources"
)

set(CROSSOF_DEFINITIONS
    -DPOCO_STATIC
)

add_definitions    (${CROSSOF_DEFINITIONS} )
include_directories(${CROSSOF_INCLUDE_DIRS})

