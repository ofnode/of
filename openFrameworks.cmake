list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")

set(DEBUG_FLAGS "
    -g
    -fPIC
    -fsanitize=address
")

if(NOT CMAKE_BUILD_TYPE)
   set(CMAKE_BUILD_TYPE "Release")
endif()

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

    # MinGW libraries
    set(WIN_LIBRARIES
        winmm
        gdi32
        ws2_32
        crypt32
        wsock32
        iphlpapi
    )

    # Local dependencies
    file(GLOB_RECURSE OPENFRAMEWORKS_LOCAL_DEPENDENCIES
         "${CMAKE_CURRENT_LIST_DIR}/lib/${CMAKE_BUILD_TYPE}/windows/*.a"
    )

    # External dependencies
    find_package(Glib REQUIRED)
    find_package(ZLIB REQUIRED)
    find_package(BZip2 REQUIRED)
    find_package(Iconv REQUIRED)
    find_package(Cairo REQUIRED)
    find_package(OpenGL REQUIRED)
    find_package(Pixman REQUIRED)
    find_package(OpenSSL REQUIRED)
    find_package(Threads REQUIRED)
    find_package(Libintl REQUIRED)
    find_package(HarfBuzz REQUIRED)
    find_package(Freetype REQUIRED)

    list(APPEND OPENGL_INCLUDE_DIR
        "${CMAKE_FIND_ROOT_PATH}/include/GL"
    )

    set(OPENFRAMEWORKS_INCLUDE_DIRS
        ${GLIB_INCLUDE_DIRS}
        ${ZLIB_INCLUDE_DIRS}
        ${BZIP2_INCLUDE_DIR}
        ${ICONV_INCLUDE_DIR}
        ${CAIRO_INCLUDE_DIR}
        ${OPENGL_INCLUDE_DIR}
        ${PIXMAN_INCLUDE_DIRS}
        ${OPENSSL_INCLUDE_DIR}
        ${LIBINTL_INCLUDE_DIR}
        ${HARFBUZZ_INCLUDE_DIRS}
        ${FREETYPE_INCLUDE_DIRS}
    )

    set(OPENFRAMEWORKS_LIBRARIES
      ${OPENFRAMEWORKS_LIBRARIES}
        -Wl,-Bstatic
        -Wl,--start-group
        ${WIN_LIBRARIES}
        ${GLIB_LIBRARIES}
        ${ZLIB_LIBRARIES}
        ${BZIP2_LIBRARIES}
        ${ICONV_LIBRARIES}
        ${CAIRO_LIBRARIES}
        ${OPENGL_LIBRARIES}
        ${PIXMAN_LIBRARIES}
        ${OPENSSL_LIBRARIES}
        ${LIBINTL_LIBRARIES}
        ${HARFBUZZ_LIBRARIES}
        ${FREETYPE_LIBRARIES}
        ${CMAKE_THREAD_LIBS_INIT}
        ${OPENFRAMEWORKS_LOCAL_DEPENDENCIES}
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

string(REPLACE "\n" " " DEBUG_FLAGS ${DEBUG_FLAGS})

if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
    set(COLORIZATION "-fcolor-diagnostics")
elseif(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
    if(CMAKE_CXX_COMPILER_VERSION VERSION_GREATER "4.9.0")
    set(COLORIZATION "-fdiagnostics-color")
    endif()
endif()

set(CMAKE_C_FLAGS_RELEASE   "${COLORIZATION} ${CMAKE_C_FLAGS_RELEASE}")
set(CMAKE_C_FLAGS_DEBUG     "${COLORIZATION} ${CMAKE_C_FLAGS_DEBUG} ${DEBUG_FLAGS}")
set(CMAKE_CXX_FLAGS_RELEASE "${COLORIZATION} -std=gnu++11 ${CMAKE_CXX_FLAGS_RELEASE}")
set(CMAKE_CXX_FLAGS_DEBUG   "${COLORIZATION} -std=gnu++11 ${CMAKE_CXX_FLAGS_DEBUG} ${DEBUG_FLAGS}")

