cmake_minimum_required(VERSION 2.8)

project(RtAudio)

if(WIN32)

    add_definitions(-D__WINDOWS_DS__)

    include_directories(include)

    set(SRCS
        RtAudio.cpp
    )

    set(HEADERS
        include/soundcard.h
        RtError.h
        RtAudio.h
        include/ginclude.h
        include/dsound.h
    )

    add_library(rtaudio STATIC ${SRCS} ${HEADERS})

elseif(UNIX)

    include_directories(include)

    SET(SRCS
        RtAudio.cpp
    )

    SET(HEADERS
        include/soundcard.h
        RtError.h
        RtAudio.h
        include/ginclude.h
    )

    if(APPLE)

        add_definitions(-D__MACOSX_CORE__ -DMAC)
        add_library(rtaudio STATIC ${SRCS} ${HEADERS})
        set_target_properties(rtaudio PROPERTIES LINK_FLAGS "-framework CoreFoundation -framework CoreAudio -framework AudioUnit -framework AudioToolbox")

    else()

        add_definitions(-D__LINUX_ALSA__ -fPIC)
        set(ALSA_LIBRARY "-lasound -lpthread")
        include_directories(${ALSA_INCLUDE_DIR})
        add_library(rtaudio STATIC ${SRCS} ${HEADERS})
        target_link_libraries(rtaudio ${ALSA_LIBRARY})

    endif()

endif()
