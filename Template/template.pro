
OF_PRI = ../of.pri

TEMPLATE  = app
CONFIG   += console
TARGET    = template

CONFIG -= qt
CONFIG -= warn_on

QMAKE_CFLAGS    = -W
QMAKE_CFLAGS   += -Wno-unused-parameter
QMAKE_CFLAGS   += -Wno-empty-body
QMAKE_CFLAGS   += -Wno-sign-compare
QMAKE_CFLAGS   += -Wno-clobbered

QMAKE_CXXFLAGS  = -W -std=c++11
QMAKE_CXXFLAGS += -Wno-unused-parameter
QMAKE_CXXFLAGS += -Wno-deprecated-register

QMAKE_CFLAGS_DEBUG     = -O0 -g
QMAKE_CFLAGS_RELEASE   = -O3

QMAKE_CXXFLAGS_DEBUG   = -O0 -g
QMAKE_CXXFLAGS_RELEASE = -O3

include($$OF_PRI)

SOURCES *= main.cpp

HEADERS *= main.hpp

unix {
DESTDIR = $$PWD/bin/linux-64
}

win32 {
DESTDIR = $$PWD/bin/mingw-64
}
