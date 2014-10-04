if(NOT CMAKE_BUILD_TYPE)
   set(CMAKE_BUILD_TYPE "Release")
endif()

set(RELEASE_FLAGS "
    -w
    -O3
")

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

    # Local dependencies
    file(GLOB_RECURSE OPENFRAMEWORKS_LOCAL_DEPENDENCIES
         "${CMAKE_CURRENT_LIST_DIR}/lib/${CMAKE_BUILD_TYPE}/linux/*.a"
    )

    set(OPENFRAMEWORKS_LIBRARIES
      ${OPENFRAMEWORKS_LIBRARIES}
        -Wl,-Bstatic
        -Wl,--start-group
        ${OPENFRAMEWORKS_LOCAL_DEPENDENCIES}
        -Wl,--end-group
        -Wl,-Bdynamic
    )

    # External dependencies
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
endif(UNIX AND NOT APPLE)

if(WIN32)
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

    # Local dependencies
    file(GLOB_RECURSE OPENFRAMEWORKS_LOCAL_DEPENDENCIES
         "${CMAKE_CURRENT_LIST_DIR}/lib/${CMAKE_BUILD_TYPE}/windows/*.a"
    )

    # External dependencies
    find_package(ZLIB REQUIRED)
    find_package(OpenGL REQUIRED)
    find_package(OpenSSL REQUIRED)
    find_package(Threads REQUIRED)
    find_package(Freetype REQUIRED)

    set(OPENFRAMEWORKS_INCLUDE_DIRS
        ${ZLIB_INCLUDE_DIRS}
        ${OPENGL_INCLUDE_DIR}
        ${OPENSSL_INCLUDE_DIR}
        ${FREETYPE_INCLUDE_DIRS}
        "${CMAKE_FIND_ROOT_PATH}/include/GL"
        "${CMAKE_FIND_ROOT_PATH}/include/cairo"
    )

    set(OPENFRAMEWORKS_LIBRARIES
      ${OPENFRAMEWORKS_LIBRARIES}
        -Wl,-Bstatic
        -Wl,--start-group
        ${ZLIB_LIBRARIES}
        ${OPENGL_LIBRARIES}
        ${OPENSSL_LIBRARIES}
        ${FREETYPE_LIBRARIES}
        ${CMAKE_THREAD_LIBS_INIT}
        ${OPENFRAMEWORKS_LOCAL_DEPENDENCIES}
        glib-2.0
        harfbuzz
        pixman-1
        iphlpapi
        wsock32
        crypt32
        ws2_32
        cairo
        iconv
        gdi32
        winmm
        intl
        bz2
        -Wl,--end-group
        -Wl,-Bdynamic
    )
endif(WIN32)

set(OPENFRAMEWORKS_INCLUDE_DIRS
  ${OPENFRAMEWORKS_INCLUDE_DIRS}
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/3d"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/app"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/communication"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/events"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/gl"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/graphics"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/math"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/types"
    "${CMAKE_CURRENT_LIST_DIR}/src/openframeworks/utils"

    "${CMAKE_CURRENT_LIST_DIR}/src/freeimage"

    "${CMAKE_CURRENT_LIST_DIR}/src/kiss"
    "${CMAKE_CURRENT_LIST_DIR}/src/kiss/include"
    "${CMAKE_CURRENT_LIST_DIR}/src/kiss/src"

    "${CMAKE_CURRENT_LIST_DIR}/src/tess2"
    "${CMAKE_CURRENT_LIST_DIR}/src/tess2/include"
    "${CMAKE_CURRENT_LIST_DIR}/src/tess2/Sources"

    "${CMAKE_CURRENT_LIST_DIR}/src/glew"
    "${CMAKE_CURRENT_LIST_DIR}/src/glew/include"

    "${CMAKE_CURRENT_LIST_DIR}/src/glfw"
    "${CMAKE_CURRENT_LIST_DIR}/src/glfw/include"
    "${CMAKE_CURRENT_LIST_DIR}/src/glfw/include/GLFW"

    "${CMAKE_CURRENT_LIST_DIR}/src/poco"
    "${CMAKE_CURRENT_LIST_DIR}/src/poco/Crypto/include"
    "${CMAKE_CURRENT_LIST_DIR}/src/poco/Crypto/include/Poco"
    "${CMAKE_CURRENT_LIST_DIR}/src/poco/Crypto/include/Poco/Crypto"

    "${CMAKE_CURRENT_LIST_DIR}/src/poco/Foundation/include"
    "${CMAKE_CURRENT_LIST_DIR}/src/poco/Foundation/include/Poco"
    "${CMAKE_CURRENT_LIST_DIR}/src/poco/Foundation/include/Poco/Dynamic"

    "${CMAKE_CURRENT_LIST_DIR}/src/poco/Net/include"
    "${CMAKE_CURRENT_LIST_DIR}/src/poco/Net/include/Poco"
    "${CMAKE_CURRENT_LIST_DIR}/src/poco/Net/include/Poco/Net"

    "${CMAKE_CURRENT_LIST_DIR}/src/poco/NetSSL_OpenSSL/include"
    "${CMAKE_CURRENT_LIST_DIR}/src/poco/NetSSL_OpenSSL/include/Poco"
    "${CMAKE_CURRENT_LIST_DIR}/src/poco/NetSSL_OpenSSL/include/Poco/Net"

    "${CMAKE_CURRENT_LIST_DIR}/src/poco/Util/include"
    "${CMAKE_CURRENT_LIST_DIR}/src/poco/Util/include/Poco"
    "${CMAKE_CURRENT_LIST_DIR}/src/poco/Util/include/Poco/Util"

    "${CMAKE_CURRENT_LIST_DIR}/src/poco/XML/include"
    "${CMAKE_CURRENT_LIST_DIR}/src/poco/XML/include/Poco"
    "${CMAKE_CURRENT_LIST_DIR}/src/poco/XML/include/Poco/DOM"
    "${CMAKE_CURRENT_LIST_DIR}/src/poco/XML/include/Poco/SAX"
    "${CMAKE_CURRENT_LIST_DIR}/src/poco/XML/include/Poco/XML"

    "${CMAKE_CURRENT_LIST_DIR}/src/poco/Zip/include"
    "${CMAKE_CURRENT_LIST_DIR}/src/poco/Zip/include/Poco"
    "${CMAKE_CURRENT_LIST_DIR}/src/poco/Zip/include/Poco/Zip"
)

set(OPENFRAMEWORKS_DEFINITIONS
  ${OPENFRAMEWORKS_DEFINITIONS}
    -DTARGET_NO_SOUND
    -DTARGET_NO_VIDEO
    -DPOCO_STATIC
)

add_definitions(${OPENFRAMEWORKS_DEFINITIONS})
include_directories(${OPENFRAMEWORKS_INCLUDE_DIRS})

string(REPLACE "\n" " " RELEASE_FLAGS ${RELEASE_FLAGS})
string(REPLACE "\n" " " DEBUG_FLAGS   ${DEBUG_FLAGS})

set(CMAKE_CXX_FLAGS_RELEASE "-std=gnu++11 ${RELEASE_FLAGS}")
set(CMAKE_CXX_FLAGS_DEBUG   "-std=gnu++11 ${DEBUG_FLAGS}")
set(CMAKE_C_FLAGS_DEBUG     "${DEBUG_FLAGS}")

