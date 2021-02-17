INCLUDEPATH += \
    $$PWD


win32 {
    CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../core/release
    CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/../core/debug
}

LIBS += \
    -L$$OUT_PWD/../core \
    -lcore

win32-msvc*:CONFIG(release, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../core/release/core.lib
else:win32-msvc*:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../core/debug/core.lib
else:win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../core/release/libcore.a
else:win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../core/debug/libcore.a
else: PRE_TARGETDEPS += $$OUT_PWD/../core/libcore.a
