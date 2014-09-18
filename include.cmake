set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/Modules)

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Release")
endif()

if(UNIX AND NOT APPLE)

    # Search path for .so
    set(CROSSOF_LIBRARIES
        -Wl,-rpath,'$$ORIGIN'
    )

    # Static C and C++
    set(CROSSOF_LIBRARIES
      ${CROSSOF_LIBRARIES}
        -static-libgcc
        -static-libstdc++
    )

    # Static OF
    set(CROSSOF_LIBRARIES
      ${CROSSOF_LIBRARIES}
        -L"${CMAKE_CURRENT_LIST_DIR}/Compiled/linux-64/${CMAKE_BUILD_TYPE}"
        openFrameworks
    )

    # Static dependencies
    file(GLOB_RECURSE STATIC_LIBRARIES
         ${CMAKE_CURRENT_LIST_DIR}/Dependencies/Compiled/linux-64/${CMAKE_BUILD_TYPE}/*.a
    )

    set(CROSSOF_LIBRARIES
      ${CROSSOF_LIBRARIES}
        -Wl,-Bstatic
        -Wl,--start-group
        ${STATIC_LIBRARIES}
        -Wl,--end-group
        -Wl,-Bdynamic
    )

    # Dynamic dependencies
    find_package(X11 REQUIRED)
    find_package(GTK2 REQUIRED)
    find_package(OpenGL REQUIRED)
    find_package(Threads REQUIRED)

    set(CROSSOF_DEFINITIONS
        ${GTK2_DEFINITIONS}
    )

    set(CROSSOF_INCLUDE_DIRS
        ${X11_INCLUDE_DIR}
        ${GTK2_INCLUDE_DIRS}
        ${OPENGL_INCLUDE_DIR}
    )

    set(CROSSOF_LIBRARIES
      ${CROSSOF_LIBRARIES}
        ${X11_LIBRARIES}
        ${X11_Xi_LIB}
        ${X11_Xrandr_LIB}
        ${X11_Xcursor_LIB}
        ${X11_Xxf86vm_LIB}
        ${GTK2_LIBRARIES}
        ${OPENGL_LIBRARIES}
        ${CMAKE_THREAD_LIBS_INIT}
    )

endif()

if(WIN32)

    # Path to MXE compiler folder
    set(MXE /opt/mxe/usr/x86_64-w64-mingw32.static)

    # Hide console window
    set(CROSSOF_LIBRARIES
        -mwindows
    )

    # Static C and C++
    set(CROSSOF_LIBRARIES
      ${CROSSOF_LIBRARIES}
        -static-libgcc
        -static-libstdc++
    )

    # Static OF
    set(CROSSOF_LIBRARIES
      ${CROSSOF_LIBRARIES}
        -L"${CMAKE_CURRENT_LIST_DIR}/Compiled/mingw-64/${CMAKE_BUILD_TYPE}"
        openFrameworks
    )

    # Static dependencies
    file(GLOB_RECURSE STATIC_LIBRARIES
         ${CMAKE_CURRENT_LIST_DIR}/Dependencies/Compiled/mingw-64/${CMAKE_BUILD_TYPE}/*.a
    )

    set(CROSSOF_LIBRARIES
      ${CROSSOF_LIBRARIES}
        -Wl,-Bstatic
        -Wl,--start-group
        ${STATIC_LIBRARIES}
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
        glu32
        cairo
        iconv
        gdi32
        winmm
        intl
        bz2
        m
        -Wl,--end-group
        -Wl,-Bdynamic
    )

    set(CROSSOF_INCLUDE_DIRS
        "${MXE}/include"
        "${MXE}/include/GL"
        "${MXE}/include/cairo"
        "${MXE}/include/freetype2"
    )

endif()

set(CROSSOF_INCLUDE_DIRS
  ${CROSSOF_INCLUDE_DIRS}
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

set(CROSSOF_DEFINITIONS
  ${CROSSOF_DEFINITIONS}
    -DTARGET_NO_SOUND
    -DTARGET_NO_VIDEO
    -DPOCO_STATIC
)

include_directories(${CROSSOF_INCLUDE_DIRS})
add_definitions(${CROSSOF_DEFINITIONS})

set(DEBUG_FLAGS "
    -g
    -fPIC
    -fsanitize=address
    -fcolor-diagnostics
")

string(REPLACE "\n" " " DEBUG_FLAGS ${DEBUG_FLAGS})

set(CMAKE_CXX_FLAGS_DEBUG "${DEBUG_FLAGS}")
set(CMAKE_C_FLAGS_DEBUG   "${DEBUG_FLAGS}")

