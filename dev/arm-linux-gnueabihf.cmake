#
# CMake defines to cross-compile to ARM/Linux on BCM2708 using glibc.
# It's used on the well known Raspberry Pi platform.
#

SET(CMAKE_SYSTEM_NAME Linux)
SET(CMAKE_C_COMPILER ${CROSS_COMPILER_PATH}arm-linux-gnueabihf-gcc)
SET(CMAKE_CXX_COMPILER ${CROSS_COMPILER_PATH}arm-linux-gnueabihf-g++)
SET(CMAKE_ASM_COMPILER ${CROSS_COMPILER_PATH}arm-linux-gnueabihf-gcc)
SET(CMAKE_SYSTEM_PROCESSOR arm)

SET(CPACK_DEBIAN_PACKAGE_ARCHITECTURE armhf)

SET(CMAKE_FIND_ROOT_PATH ${RPI_ROOT_PATH}/opt/vc ${RPI_ROOT_PATH} ${RPI_ROOT_PATH}/usr )

# search for programs in the build host directories
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)

# for libraries and headers in the target directories
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

SET(CMAKE_LIBRARY_PATH "${RPI_ROOT_PATH}/usr/lib/arm-linux-gnueabihf/;${RPI_ROOT_PATH}/lib/arm-linux-gnueabihf/")

IF (CMAKE_CROSSCOMPILING)
  INCLUDE_DIRECTORIES(BEFORE ${CMAKE_FIND_ROOT_PATH}/include)
  SET(ENV{PKG_CONFIG_LIBDIR} ${CMAKE_FIND_ROOT_PATH}/lib/pkgconfig/)
ENDIF()

# rdynamic means the backtrace should work
IF (CMAKE_BUILD_TYPE MATCHES "Debug")
   add_definitions(-rdynamic)
ENDIF()

# avoids annoying and pointless warnings from gcc
#SET(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -U_FORTIFY_SOURCE")
#SET(CMAKE_ASM_FLAGS "${CMAKE_ASM_FLAGS} -c")
