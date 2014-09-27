if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Release")
endif()

set(DEBUG_FLAGS "
    -g
    -fPIC
    -fsanitize=address
    -fcolor-diagnostics
")

if(UNIX AND NOT APPLE)

    # Search path for .so
    set(OPENFRAMEWORKS_LIBRARIES
        -Wl,-rpath,'$$ORIGIN'
    )

    # Static C and C++
    set(OPENFRAMEWORKS_LIBRARIES
      ${OPENFRAMEWORKS_LIBRARIES}
        -static-libgcc
        -static-libstdc++
    )

    # Static OF
    set(OPENFRAMEWORKS_LIBRARIES
      ${OPENFRAMEWORKS_LIBRARIES}
        -L"${CMAKE_CURRENT_LIST_DIR}/Compiled/linux-64/${CMAKE_BUILD_TYPE}"
        openFrameworks
    )

    # Static dependencies
    file(GLOB_RECURSE OPENFRAMEWORKS_LOCAL_DEPENDENCIES
         ${CMAKE_CURRENT_LIST_DIR}/Dependencies/Compiled/linux-64/${CMAKE_BUILD_TYPE}/*.a
    )

    set(OPENFRAMEWORKS_LIBRARIES
      ${OPENFRAMEWORKS_LIBRARIES}
        -Wl,-Bstatic
        -Wl,--start-group
        ${OPENFRAMEWORKS_LOCAL_DEPENDENCIES}
        -Wl,--end-group
        -Wl,-Bdynamic
    )

    # Dynamic dependencies
    find_package(X11 REQUIRED)
    find_package(ZLIB REQUIRED)
    find_package(GTK2 REQUIRED)
    find_package(OpenGL REQUIRED)
    find_package(OpenSSL REQUIRED)
    find_package(Threads REQUIRED)

    set(OPENFRAMEWORKS_DEFINITIONS
        ${GTK2_DEFINITIONS}
    )

    set(OPENFRAMEWORKS_INCLUDE_DIRS
        ${X11_INCLUDE_DIR}
        ${ZLIB_INCLUDE_DIRS}
        ${GTK2_INCLUDE_DIRS}
        ${OPENGL_INCLUDE_DIR}
        ${OPENSSL_INCLUDE_DIR}
    )

    set(OPENFRAMEWORKS_LIBRARIES
      ${OPENFRAMEWORKS_LIBRARIES}
        ${X11_LIBRARIES}
        ${X11_Xi_LIB}
        ${X11_Xrandr_LIB}
        ${X11_Xcursor_LIB}
        ${X11_Xxf86vm_LIB}
        ${ZLIB_LIBRARIES}
        ${GTK2_LIBRARIES}
        ${OPENGL_LIBRARIES}
        ${OPENSSL_LIBRARIES}
        ${CMAKE_THREAD_LIBS_INIT}
    )

endif()

if(WIN32)

    # Path to MXE compiler folder
    set(MXE /opt/mxe/usr/x86_64-w64-mingw32.static)

    # Hide console window
    set(OPENFRAMEWORKS_LIBRARIES
        -mwindows
    )

    # Static C and C++
    set(OPENFRAMEWORKS_LIBRARIES
      ${OPENFRAMEWORKS_LIBRARIES}
        -static-libgcc
        -static-libstdc++
    )

    # Static OF
    set(OPENFRAMEWORKS_LIBRARIES
      ${OPENFRAMEWORKS_LIBRARIES}
        -L"${CMAKE_CURRENT_LIST_DIR}/Compiled/mingw-64/${CMAKE_BUILD_TYPE}"
        openFrameworks
    )

    # Static dependencies
    file(GLOB_RECURSE OPENFRAMEWORKS_LOCAL_DEPENDENCIES
         ${CMAKE_CURRENT_LIST_DIR}/Dependencies/Compiled/mingw-64/${CMAKE_BUILD_TYPE}/*.a
    )

    set(OPENFRAMEWORKS_LIBRARIES
      ${OPENFRAMEWORKS_LIBRARIES}
        -Wl,-Bstatic
        -Wl,--start-group
        ${OPENFRAMEWORKS_LOCAL_DEPENDENCIES}
        -L"${MXE}/lib"
        glib-2.0
        harfbuzz
        freetype
        pixman-1
        iphlpapi
        opengl32
        wsock32
        crypt32
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
        -Wl,-Bdynamic
    )

    set(OPENFRAMEWORKS_INCLUDE_DIRS
        "${MXE}/include"
        "${MXE}/include/GL"
        "${MXE}/include/cairo"
        "${MXE}/include/freetype2"
    )

endif()

set(OPENFRAMEWORKS_INCLUDE_DIRS
  ${OPENFRAMEWORKS_INCLUDE_DIRS}
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

    "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Libs/kiss"
    "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Libs/kiss/include"
    "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Libs/kiss/src"

    "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Libs/tess2"
    "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Libs/tess2/include"
    "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Libs/tess2/Sources"

    "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Libs/glew"
    "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Libs/glew/include"

    "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Libs/glfw"
    "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Libs/glfw/include"
    "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Libs/glfw/include/GLFW"

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

    "${CMAKE_CURRENT_LIST_DIR}/Dependencies/Libs/freeimage"
)

set(OPENFRAMEWORKS_DEFINITIONS
  ${OPENFRAMEWORKS_DEFINITIONS}
    -DTARGET_NO_SOUND
    -DTARGET_NO_VIDEO
    -DPOCO_STATIC
)

add_definitions(${OPENFRAMEWORKS_DEFINITIONS})
include_directories(${OPENFRAMEWORKS_INCLUDE_DIRS})

string(REPLACE "\n" " " DEBUG_FLAGS ${DEBUG_FLAGS})

set(CMAKE_CXX_FLAGS_DEBUG   "-std=c++11 ${DEBUG_FLAGS}")
set(CMAKE_C_FLAGS_DEBUG     "-std=c++11 ${DEBUG_FLAGS}")
set(CMAKE_CXX_FLAGS_RELEASE "-std=c++11")
set(CMAKE_C_FLAGS_RELEASE   "-std=c++11")

