if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Release")
endif()

if(UNIX AND NOT APPLE)
    set(CROSSOF_INCLUDE_DIRS
        "/usr/include/cairo"
        "/usr/include/freetype2"

        "/usr/include/atk-1.0"
        "/usr/include/gdk-pixbuf-2.0"
        "/usr/include/pango-1.0"
        "/usr/include/glib-2.0"
        "/usr/include/gtk-2.0"

        "/usr/lib/glib-2.0/include"
        "/usr/lib/gtk-2.0/include"
        
        "/usr/lib64/glib-2.0/include"
        "/usr/lib64/gtk-2.0/include"

        "/usr/lib/x86_64-linux-gnu/glib-2.0/include"
        "/usr/lib/x86_64-linux-gnu/gtk-2.0/include"
    )
    
    set(CROSSOF_LIBRARIES
        -static-libgcc
        -static-libstdc++
        -Wl,-rpath,'$$ORIGIN'
        -L"${CMAKE_CURRENT_LIST_DIR}/Compiled/linux-64"
        -L"${CMAKE_CURRENT_LIST_DIR}/Dependencies/Compiled/linux-64"
        -Wl,-Bstatic
        -Wl,--start-group
        openFrameworks-${CMAKE_BUILD_TYPE}
        PocoNet
        PocoXML
        PocoUtil
        PocoFoundation
        PocoNetSSL
        PocoCrypto
        glfw3
        kiss
        tess2
        -Wl,--end-group
        -Wl,-Bdynamic
        gdk_pixbuf-2.0
        pangocairo-1.0
        pangoft2-1.0
        gobject-2.0
        gtk-x11-2.0
        gdk-x11-2.0
        fontconfig
        freeimage
        pango-1.0
        pixman-1
        freetype
        glib-2.0
        gio-2.0
        atk-1.0
        pthread
        Xxf86vm
        Xcursor
        crypto
        Xrandr
        png12
        cairo
        udev
        GLEW
        GLU
        ssl
        X11
        Xi
        GL
        m
        z
    )
endif()

if(WIN32)
    set(CROSSOF_INCLUDE_DIRS
        "/opt/mxe/usr/x86_64-w64-mingw32.static/include"
        "/opt/mxe/usr/x86_64-w64-mingw32.static/include/GL"
        "/opt/mxe/usr/x86_64-w64-mingw32.static/include/cairo"
        "/opt/mxe/usr/x86_64-w64-mingw32.static/include/freetype2"
    )

    set(CROSSOF_LIBRARIES
        -mwindows
        -static-libgcc
        -static-libstdc++
        -L"/opt/mxe/usr/x86_64-w64-mingw32.static/lib"
        -L"${CMAKE_CURRENT_LIST_DIR}/Compiled/mingw-64"
        -L"${CMAKE_CURRENT_LIST_DIR}/Dependencies/Compiled/mingw-64"
        -Wl,-Bstatic
        -Wl,--start-group
        openFrameworks-${CMAKE_BUILD_TYPE}
        PocoNet
        PocoXML
        PocoUtil
        PocoFoundation
        PocoNetSSL
        PocoCrypto
        glfw3
        kiss
        tess2
        fontconfig
        freeimage
        glib-2.0
        harfbuzz
        freetype
        pixman-1
        iphlpapi
        opengl32
        wsock32
        glew32s
        ws2_32
        crypto
        glu32
        cairo
        iconv
        gdi32
        winmm
        intl
        bz2
        ssl
        m
        z
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

include_directories(${CROSSOF_INCLUDE_DIRS})

add_definitions(
    -DTARGET_NO_SOUND
    -DTARGET_NO_VIDEO
    -DPOCO_STATIC
)

set(DEBUG_FLAGS "
    -g
    -Wall
    -Wextra
    -fsanitize=address
    -fno-omit-frame-pointer
    -Wno-unused-parameter
")

string(REPLACE "\n" " " DEBUG_FLAGS ${DEBUG_FLAGS})

set(CMAKE_CXX_FLAGS "-std=c++11")
set(CMAKE_C_FLAGS   "-std=c11"  )
set(CMAKE_CXX_FLAGS_DEBUG   "${CMAKE_CXX_FLAGS} -O2 ${DEBUG_FLAGS} -fcolor-diagnostics")
set(CMAKE_C_FLAGS_DEBUG     "${CMAKE_C_FLAGS}   -O2 ${DEBUG_FLAGS} -fcolor-diagnostics")
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS} -O3")
set(CMAKE_C_FLAGS_RELEASE   "${CMAKE_C_FLAGS}   -O3")

