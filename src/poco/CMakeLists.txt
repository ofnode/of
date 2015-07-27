# POCO_BUILD_TYPE
# POCO_STATIC
# POCO_UNBUNDLED
# POCO_NO_LOCALE
#
# ENABLE_{COMPONENT}
# ENABLE_TESTS

cmake_minimum_required(VERSION 2.8)

project(Poco)

file(STRINGS "${PROJECT_SOURCE_DIR}/libversion" SHARED_LIBRARY_VERSION)

# Read the version information from the VERSION file
file (STRINGS "${PROJECT_SOURCE_DIR}/VERSION" PACKAGE_VERSION )
message(STATUS "Poco package version: ${PACKAGE_VERSION}")
string(REGEX REPLACE "([0-9]+)\\.[0-9]+\\.[0-9]+.*" "\\1" CPACK_PACKAGE_VERSION_MAJOR ${PACKAGE_VERSION})
string(REGEX REPLACE "[0-9]+\\.([0-9])+\\.[0-9]+.*" "\\1" CPACK_PACKAGE_VERSION_MINOR ${PACKAGE_VERSION})
string(REGEX REPLACE "[0-9]+\\.[0-9]+\\.([0-9]+).*" "\\1" CPACK_PACKAGE_VERSION_PATCH ${PACKAGE_VERSION})

set(COMPLETE_VERSION ${CPACK_PACKAGE_VERSION_MAJOR}.${CPACK_PACKAGE_VERSION_MINOR}.${CPACK_PACKAGE_VERSION_PATCH})
set(RELEASE_NAME "Unstable-trunk")
set(PROJECT_VERSION ${COMPLETE_VERSION})

# Append our module directory to CMake
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

# COMMENT REPLACED BY BIICODE

#################################################################################
# Setup C/C++ compiler options
#################################################################################

if(NOT MSVC_IDE)
  if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE RelWithDebInfo CACHE STRING
      "Choose the type of build, options are: None Debug Release" FORCE)
  endif()
  message(STATUS "Setting Poco build type - ${CMAKE_BUILD_TYPE}")
endif()

if (CMAKE_BUILD_TYPE STREQUAL "")
    set( CMAKE_BUILD_TYPE "RelWithDebInfo" )
endif()

# Include some common macros to simpilfy the Poco CMake files
include(PocoMacros)

# Allow enabling and disabling components
option(ENABLE_XML "Enable the XML" ON)
option(ENABLE_JSON "Enable the JSON" ON)
option(ENABLE_MONGODB "Enable MongoDB" OFF)
option(ENABLE_PDF "Enable PDF" OFF)
option(ENABLE_UTIL "Enable Util" ON)
option(ENABLE_NET "Enable Net" ON)
option(ENABLE_NETSSL "Enable NetSSL" ON)
option(ENABLE_NETSSL_WIN "Enable NetSSL Windows" OFF)
option(ENABLE_CRYPTO "Enable Crypto" ON)
option(ENABLE_DATA "Enable Data" OFF)
option(ENABLE_DATA_SQLITE "Enable Data SQlite" OFF)
option(ENABLE_DATA_MYSQL "Enable Data MySQL" OFF)
option(ENABLE_DATA_ODBC "Enable Data ODBC" OFF)
option(ENABLE_SEVENZIP "Enable SevenZip" OFF)
option(ENABLE_ZIP "Enable Zip" OFF)
option(ENABLE_APACHECONNECTOR "Enable ApacheConnector" OFF)
option(ENABLE_CPPPARSER "Enable C++ parser" OFF)
option(ENABLE_POCODOC "Enable Poco Documentation Generator" OFF)
option(ENABLE_PAGECOMPILER "Enable PageCompiler" OFF)
option(ENABLE_PAGECOMPILER_FILE2PAGE "Enable File2Page" OFF)

option(FORCE_OPENSSL "Force usage of OpenSSL even under windows" ON)

option(ENABLE_TESTS
  "Set to OFF|ON (default is OFF) to control build of POCO tests & samples" OFF)

option(POCO_STATIC
  "Set to OFF|ON (default is OFF) to control build of POCO as STATIC library" OFF)

option(POCO_UNBUNDLED
  "Set to OFF|ON (default is OFF) to control linking dependencies as external" OFF)

if(MSVC)
    option(POCO_MT
      "Set to OFF|ON (default is OFF) to control build of POCO as /MT instead of /MD" OFF)

    option(ENABLE_MSVC_MP
      "Set to OFF|ON (default is OFF) to control parallel build of POCO with MSVC" OFF)
endif()

if (ENABLE_TESTS)
  include(CTest)
  enable_testing()
  message(STATUS "Building with unittests & samples")
else ()
  message(STATUS "Building without tests & samples")
endif ()

if (POCO_UNBUNDLED)
  add_definitions( -DPOCO_UNBUNDLED)
  message(STATUS "Build with using external sqlite, libz, pcre, expat ...")
else ()
  message(STATUS "Build with using internal copy of sqlite, libz, pcre, expat, ...")
endif ()

include(DefinePlatformSpecifc)

# Collect the built libraries and include dirs, the will be used to create the PocoConfig.cmake file
set(Poco_COMPONENTS "")

if (ENABLE_TESTS)
   add_subdirectory(CppUnit)
endif ()

add_subdirectory(Foundation)
if(ENABLE_XML)
add_subdirectory(XML)
list(APPEND Poco_COMPONENTS "XML")
endif()
if(ENABLE_JSON)
add_subdirectory(JSON)
list(APPEND Poco_COMPONENTS "JSON")
endif()
if(ENABLE_MONGODB)
add_subdirectory(MongoDB)
list(APPEND Poco_COMPONENTS "MongoDB")
endif()
if(ENABLE_PDF)
add_subdirectory(PDF)
list(APPEND Poco_COMPONENTS "PDF")
endif()
if(ENABLE_UTIL)
add_subdirectory(Util)
list(APPEND Poco_COMPONENTS "Util")
endif()
if(ENABLE_NET)
add_subdirectory(Net)
list(APPEND Poco_COMPONENTS "Net")
endif()


#NetSSL


if(WIN32 AND ENABLE_NETSSL_WIN)
    add_subdirectory(NetSSL_Win)
    list(APPEND Poco_COMPONENTS "NetSSL_Win")
endif(WIN32 AND ENABLE_NETSSL_WIN)

find_package(OpenSSL)
if(OPENSSL_FOUND)
    include_directories("${OPENSSL_INCLUDE_DIR}")
    if(ENABLE_NETSSL)
    add_subdirectory(NetSSL_OpenSSL)
    list(APPEND Poco_COMPONENTS "NetSSL_OpenSSL")
    endif()
    if(ENABLE_CRYPTO)
    add_subdirectory(Crypto)
    list(APPEND Poco_COMPONENTS "Crypto")
    endif()
endif(OPENSSL_FOUND)

if(ENABLE_DATA)
add_subdirectory(Data)
list(APPEND Poco_COMPONENTS "Data")
endif()
if(ENABLE_SEVENZIP)
add_subdirectory(SevenZip)
list(APPEND Poco_COMPONENTS "SevenZip")
endif()
if(ENABLE_ZIP)
add_subdirectory(Zip)
list(APPEND Poco_COMPONENTS "Zip")
endif()

find_package(APR)
find_package(Apache2)
if(APRUTIL_FOUND AND APACHE_FOUND)
    include_directories( "${APACHE_INCLUDE_DIR}" "${APRUTIL_INCLUDE_DIR}" )
    if(ENABLE_APACHECONNECTOR)
    add_subdirectory(ApacheConnector)
    list(APPEND Poco_COMPONENTS "ApacheConnector")
    endif()
endif(APRUTIL_FOUND AND APACHE_FOUND)

if(ENABLE_CPPPARSER)
add_subdirectory(CppParser)
list(APPEND Poco_COMPONENTS "CppParser")
endif()

if(ENABLE_POCODOC)
add_subdirectory(PocoDoc)
list(APPEND Poco_COMPONENTS "PocoDoc")
endif()

if(ENABLE_PAGECOMPILER)
add_subdirectory(PageCompiler)
list(APPEND Poco_COMPONENTS "PageCompiler")
endif()

if(ENABLE_PAGECOMPILER_FILE2PAGE)
add_subdirectory(PageCompiler/File2Page)
list(APPEND Poco_COMPONENTS "File2Page")
endif()

#############################################################
