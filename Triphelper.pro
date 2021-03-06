QT += quick
QT += positioning
CONFIG += c++14

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
    Managers/TripsManager.cpp \
        QMLUtils.cpp \
    core/Controllers/ActiveTripController.cpp \
    core/Controllers/ApplicationController.cpp \
    core/Controllers/CompletedTripController.cpp \
    core/Controllers/CountryInformationGenerator.cpp \
    core/Controllers/GoalsController.cpp \
    core/Controllers/LocationController.cpp \
    core/Controllers/StartTripController.cpp \
    core/Controllers/TripDayController.cpp \
    core/Controllers/UserAccountController.cpp \
    core/Controllers/UserIdController.cpp \
    core/Controllers/VisitedLocationsController.cpp \
    core/Controllers/WaitingTripController.cpp \
        core/Models/BackPackModel.cpp \
    core/Models/BackpackFilterModel.cpp \
    core/Models/CheckListFilterModel.cpp \
    core/Models/CheckListModel.cpp \
    core/Models/CompletedTripsModel.cpp \
    core/Models/CountriesCitiesModel.cpp \
        core/Models/GoalsModel.cpp \
    core/Models/PhotosModel.cpp \
    core/Models/TravelAgentsModel.cpp \
    core/Models/TripDaysModel.cpp \
    core/Services/AuthenticationService.cpp \
    core/Services/EndTripService.cpp \
    core/Services/GalleryService.cpp \
    core/Services/PackService.cpp \
    core/Storage/DataBaseStorage.cpp \
    core/Storage/PhotosStorage.cpp \
    core/Storage/Trip.cpp \
        main.cpp \


RESOURCES += qml.qrc \
    assets.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    Data/UsersInfo.json
    modules/SortFilterProxyModel/SortFilterProxyModel.pri

HEADERS += \
    Managers/TripsManager.hpp \
    QMLUtils.hpp \
    core/Controllers/ActiveTripController.hpp \
    core/Controllers/ApplicationController.hpp \
    core/Controllers/CompletedTripController.hpp \
    core/Controllers/CountryInformationGenerator.hpp \
    core/Controllers/GoalsController.hpp \
    core/Controllers/LocationController.hpp \
    core/Controllers/StartTripController.hpp \
    core/Controllers/TripDayController.hpp \
    core/Controllers/UserAccountController.hpp \
    core/Controllers/UserIdController.hpp \
    core/Controllers/VisitedLocationsController.hpp \
    core/Controllers/WaitingTripController.hpp \
    core/Models/BackPackModel.hpp \
    core/Models/BackpackFilterModel.hpp \
    core/Models/CheckListFilterModel.h \
    core/Models/CheckListModel.h \
    core/Models/CompletedTripsModel.hpp \
    core/Models/CountriesCitiesModel.hpp \
    core/Models/GoalsModel.hpp \
    core/Models/PhotosModel.hpp \
    core/Models/TravelAgentsModel.hpp \
    core/Models/TripDaysModel.hpp \
    core/Services/AuthenticationService.hpp \
    core/Services/EndTripService.hpp \
    core/Services/GalleryService.hpp \
    core/Services/JsonHelperMethods.h \
    core/Services/PackService.hpp \
    core/Storage/BackPackItem.hpp \
    core/Storage/CountryInformation.hpp \
    core/Storage/DataBaseStorage.hpp \
    core/Storage/Goal.hpp \
    core/Storage/Location.hpp \
    core/Storage/Photo.hpp \
    core/Storage/PhotosStorage.hpp \
    core/Storage/TravelAgentInfo.hpp \
    core/Storage/Trip.hpp \
    core/Storage/TripData.hpp \
    core/Storage/TripDay.hpp \
    core/Storage/UserInfo.hpp \
    modules/SortFilterProxyModel/filters/alloffilter.h \
    modules/SortFilterProxyModel/filters/anyoffilter.h \
    modules/SortFilterProxyModel/filters/expressionfilter.h \
    modules/SortFilterProxyModel/filters/filter.h \
    modules/SortFilterProxyModel/filters/filtercontainer.h \
    modules/SortFilterProxyModel/filters/filtercontainerfilter.h \
    modules/SortFilterProxyModel/filters/indexfilter.h \
    modules/SortFilterProxyModel/filters/rangefilter.h \
    modules/SortFilterProxyModel/filters/regexpfilter.h \
    modules/SortFilterProxyModel/filters/rolefilter.h \
    modules/SortFilterProxyModel/filters/valuefilter.h \
    modules/SortFilterProxyModel/proxyroles/expressionrole.h \
    modules/SortFilterProxyModel/proxyroles/filterrole.h \
    modules/SortFilterProxyModel/proxyroles/joinrole.h \
    modules/SortFilterProxyModel/proxyroles/proxyrole.h \
    modules/SortFilterProxyModel/proxyroles/proxyrolecontainer.h \
    modules/SortFilterProxyModel/proxyroles/regexprole.h \
    modules/SortFilterProxyModel/proxyroles/singlerole.h \
    modules/SortFilterProxyModel/proxyroles/switchrole.h \
    modules/SortFilterProxyModel/qqmlsortfilterproxymodel.h \
    modules/SortFilterProxyModel/sorters/expressionsorter.h \
    modules/SortFilterProxyModel/sorters/filtersorter.h \
    modules/SortFilterProxyModel/sorters/rolesorter.h \
    modules/SortFilterProxyModel/sorters/sorter.h \
    modules/SortFilterProxyModel/sorters/sortercontainer.h \
    modules/SortFilterProxyModel/sorters/stringsorter.h
