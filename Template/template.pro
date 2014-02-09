
OF = ..

include($$OF/of.pri)

TEMPLATE  = app
CONFIG   += console
TARGET    = template

CONFIG -= qt
CONFIG -= warn_on

QMAKE_CXXFLAGS  = -W -std=c++11
QMAKE_CXXFLAGS += -Wno-unused-parameter
QMAKE_CXXFLAGS += -Wno-deprecated-register

QMAKE_CXXFLAGS_DEBUG   = -O0 -g
QMAKE_CXXFLAGS_RELEASE = -O3

unix {
DESTDIR = $$PWD/bin/linux-64
}

win32 {
DESTDIR = $$PWD/bin/mingw-64
}

HEADERS *= main.hpp

SOURCES *= main.cpp
