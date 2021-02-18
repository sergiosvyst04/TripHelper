QT += positioning qml

TARGET = core
TEMPLATE = lib
CONFIG += staticlib c++14

android {
QTFIREBASE_SDK_PATH = /home/sergio/projects/firebase_cpp_sdk_6.16.0
QTFIREBASE_CONFIG += auth database

include($$PWD/../modules/QtFirebase/qtfirebase.pri)
}

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        Models/BackPackModel.cpp \
        Models/GoalsModel.cpp \
    Managers/TripsManager.cpp \
    Controllers/ActiveTripController.cpp \
    Controllers/ApplicationController.cpp \
    Controllers/CompletedTripController.cpp \
    Controllers/CountryInformationGenerator.cpp \
    Controllers/GoalsController.cpp \
    Controllers/LocationController.cpp \
    Controllers/StartTripController.cpp \
    Controllers/TripDayController.cpp \
    Controllers/UserAccountController.cpp \
    Controllers/UserIdController.cpp \
    Controllers/VisitedLocationsController.cpp \
    Controllers/WaitingTripController.cpp \
    Models/BackpackFilterModel.cpp \
    Models/CheckListFilterModel.cpp \
    Models/CheckListModel.cpp \
    Models/CompletedTripsModel.cpp \
    Models/CountriesCitiesModel.cpp \
    Models/PhotosModel.cpp \
    Models/TravelAgentsModel.cpp \
    Models/TripDaysModel.cpp \
    Services/AuthenticationProvider.cpp \
    Services/AuthenticationService.cpp \
    Services/EndTripService.cpp \
    Services/FirebaseAuthentication.cpp \
    Services/GalleryService.cpp \
    Services/PackService.cpp \
    Storage/DataBaseStorage.cpp \
    Storage/PhotosStorage.cpp \
    Storage/Trip.cpp \

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    Controllers/ActiveTripController.hpp \
    Controllers/ApplicationController.hpp \
    Controllers/CompletedTripController.hpp \
    Controllers/CountryInformationGenerator.hpp \
    Controllers/GoalsController.hpp \
    Controllers/LocationController.hpp \
    Controllers/StartTripController.hpp \
    Controllers/TripDayController.hpp \
    Controllers/UserAccountController.hpp \
    Controllers/UserIdController.hpp \
    Controllers/VisitedLocationsController.hpp \
    Controllers/WaitingTripController.hpp \
    Managers/TripsManager.hpp \
    Models/BackPackModel.hpp \
    Models/BackpackFilterModel.hpp \
    Models/CheckListFilterModel.h \
    Models/CheckListModel.h \
    Models/CompletedTripsModel.hpp \
    Models/CountriesCitiesModel.hpp \
    Models/GoalsModel.hpp \
    Models/PhotosModel.hpp \
    Models/TravelAgentsModel.hpp \
    Models/TripDaysModel.hpp \
    Services/AuthenticationProvider.h \
    Services/AuthenticationService.hpp \
    Services/EndTripService.hpp \
    Services/FirebaseAuthentication.h \
    Services/GalleryService.hpp \
    Services/JsonHelperMethods.h \
    Services/PackService.hpp \
    Storage/BackPackItem.hpp \
    Storage/CountryInformation.hpp \
    Storage/DataBaseStorage.hpp \
    Storage/Goal.hpp \
    Storage/Location.hpp \
    Storage/Photo.hpp \
    Storage/PhotosStorage.hpp \
    Storage/TravelAgentInfo.hpp \
    Storage/Trip.hpp \
    Storage/TripData.hpp \
    Storage/TripDay.hpp \
    Storage/UserInfo.hpp

contains(ANDROID_TARGET_ARCH,armeabi-v7a) {
    ANDROID_PACKAGE_SOURCE_DIR = \
        $$PWD/android
}

DISTFILES += \
    libcore.pri

