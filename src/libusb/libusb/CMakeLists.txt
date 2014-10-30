add_subdirectory(os)

include(config.cmake)
include(FindThreads)

set (LIBUSB_COMMON
	core.c
	descriptor.c
    hotplug.c
	io.c
    strerror.c
	sync.c
)

include_directories(${CMAKE_CURRENT_SOURCE_DIR})
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/os)

if (CMAKE_THREAD_LIBS_INIT)
	list(APPEND LIBUSB_LIBRARIES ${CMAKE_THREAD_LIBS_INIT})
endif()

# The CLEAN_DIRECT_OUTPUT property setting can be removed once CMake >= 2.8.4
if (WITH_SHARED)
	add_library(usb
		SHARED
		${LIBUSB_COMMON}
		${LIBUSB_PLATFORM}
	)

	if (MSVC)
		set_target_properties(usb PROPERTIES PREFIX "lib")
		set_target_properties(usb PROPERTIES IMPORT_PREFIX "lib")
		set_target_properties(usb PROPERTIES IMPORT_SUFFIX ".dll.lib")
	endif()

	set_target_properties(usb PROPERTIES
		CLEAN_DIRECT_OUTPUT 1
		PUBLIC_HEADER libusb.h
	)

	if (DEFINED LIBUSB_LIBRARIES)
		message("Linking shared library against ${LIBUSB_LIBRARIES}")
		target_link_libraries(usb
			${LIBUSB_LIBRARIES}
		)
	endif()

	list(APPEND LIBUSB_LIBTARGETS usb)
endif()

if (FALSE)
	add_library(usb
		STATIC
		${LIBUSB_COMMON}
		${LIBUSB_PLATFORM}
	)

	set_target_properties(usb PROPERTIES
		PREFIX "lib"
		OUTPUT_NAME "usb"
		CLEAN_DIRECT_OUTPUT 1
		PUBLIC_HEADER libusb.h
	)

	if (DEFINED LIBUSB_LIBRARIES)
		target_link_libraries(usb
			${LIBUSB_LIBRARIES}
		)
	endif()

	list(APPEND LIBUSB_LIBTARGETS usb)
endif()

install(TARGETS ${LIBUSB_LIBTARGETS} EXPORT libusb-1
	PUBLIC_HEADER DESTINATION include/libusb-1.0
	ARCHIVE DESTINATION lib
	LIBRARY DESTINATION lib
	RUNTIME DESTINATION lib
)
install(EXPORT libusb-1 DESTINATION lib/libusb)

foreach(LIB IN LISTS LIBUSB_LIBRARIES)
	if (LIB MATCHES .framework$)
		get_filename_component(LIB "${LIB}" NAME)
		set(LIB "-Wl,-framework,${LIB}")
	elseif (LIB MATCHES .dylib$)
		get_filename_component(LIBDIR "${LIB}" PATH)
		get_filename_component(LIB "${LIB}" NAME)
		string(REGEX REPLACE "lib(.*).dylib$" "\\1" LIB "${LIB}")
		set(LIB "-L${LIBDIR} -l${LIB}")
	endif()
	set(LIBUSB_LIB_DEPENDS "${LIBUSB_LIB_DEPENDS} ${LIB}")
endforeach()

configure_file(libusb-1.0.pc.cmake "${CMAKE_CURRENT_BINARY_DIR}/libusb-1.0.pc" @ONLY)
install(FILES "${CMAKE_CURRENT_BINARY_DIR}/libusb-1.0.pc" DESTINATION lib/pkgconfig)
