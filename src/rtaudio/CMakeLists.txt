cmake_minimum_required(VERSION 2.8)

SET(CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR})

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

    find_package(Jack)

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
        add_library(rtaudio SHARED ${SRCS} ${HEADERS} )
        target_link_libraries(rtaudio)
        set_target_properties(rtaudio PROPERTIES LINK_FLAGS "-framework CoreFoundation -framework CoreAudio -framework AudioUnit -framework AudioToolbox") 
    
    else()
    
        if(JACK_FOUND)
            add_definitions(-D__UNIX_JACK__)
            include_directories(${JACK_INCLUDE_DIR})
        endif()
    
        #find_package(ALSA REQUIRED)
        add_definitions(-D__LINUX_ALSA__)
        set(ALSA_LIBRARY "-lasound -lpthread")
        INCLUDE_DIRECTORIES(${ALSA_INCLUDE_DIR})
        add_library(rtaudio STATIC ${SRCS} ${HEADERS})

        if(CMAKE_BUILD_TYPE STREQUAL Debug)
            set_target_properties(rtaudio PROPERTIES COMPILE_FLAGS "-g -fPIC")
        endif()
        
        if(JACK_FOUND)
            target_link_libraries(rtaudio ${ALSA_LIBRARY} ${JACK_LIBRARIES})
        else()
            target_link_libraries(rtaudio ${ALSA_LIBRARY})
        endif()
        
    endif()
    
endif()
