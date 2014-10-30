cmake_minimum_required(VERSION 2.8)

project(RtAudio)

SET(CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR})
find_package(Jack)

IF (WIN32)

    ADD_DEFINITIONS(-D__WINDOWS_ASIO__)

    INCLUDE_DIRECTORIES(include)

    SET(RTAudioLib_SRCS
        RtAudio.cpp
        include/iasiothiscallresolver.cpp
        include/asiolist.cpp
        include/asiodrivers.cpp
        include/asio.cpp
    )

    SET(RTAudioLib_HEADERS
        include/soundcard.h
        RtError.h
        RtAudio.h
        include/iasiothiscallresolver.h
        include/iasiodrv.h
        include/ginclude.h
        include/dsound.h
        include/asiosys.h
        include/asiolist.h
        include/asiodrvr.h
        include/asiodrivers.h
        include/asio.h
    )
    
    add_library(rtaudio STATIC ${RTAudioLib_SRCS} ${RTAudioLib_HEADERS})
ENDIF(WIN32)

IF (UNIX)

    INCLUDE_DIRECTORIES(include)

    SET(RTAudioLib_SRCS
        RtAudio.cpp
    )
    
    SET(RTAudioLib_HEADERS
        include/soundcard.h
        RtError.h
        RtAudio.h
        include/ginclude.h
    )
    
    IF (APPLE)

        ADD_DEFINITIONS(-D__MACOSX_CORE__ -DMAC)
        add_library(rtaudio SHARED ${RTAudioLib_SRCS} ${RTAudioLib_HEADERS} )
        target_link_libraries(rtaudio)
        set_target_properties(rtaudio PROPERTIES LINK_FLAGS "-framework CoreFoundation -framework CoreAudio -framework AudioUnit -framework AudioToolbox") 
    
    ELSE(APPLE)
    
        IF (JACK_FOUND)
            ADD_DEFINITIONS(-D__UNIX_JACK__)
            INCLUDE_DIRECTORIES(${JACK_INCLUDE_DIR})
        ENDIF(JACK_FOUND)
    
        #find_package(ALSA REQUIRED)
        ADD_DEFINITIONS(-D__LINUX_ALSA__)
        SET(ALSA_LIBRARY "-lasound -lpthread")
        INCLUDE_DIRECTORIES(${ALSA_INCLUDE_DIR})
        add_library(rtaudio STATIC ${RTAudioLib_SRCS} ${RTAudioLib_HEADERS})
        set_target_properties(rtaudio PROPERTIES COMPILE_FLAGS -fPIC)
        
        IF (JACK_FOUND)
            target_link_libraries(rtaudio ${ALSA_LIBRARY} ${JACK_LIBRARIES})
        ELSE(JACK_FOUND)
            target_link_libraries(rtaudio ${ALSA_LIBRARY})
        ENDIF(JACK_FOUND)
        
        MESSAGE("ALSA lib : ${ALSA_LIBRARY}")

    ENDIF(APPLE)
    
ENDIF(UNIX)
