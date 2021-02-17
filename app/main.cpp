#include <Controllers/ActiveTripController.hpp>
#include <Controllers/ApplicationController.hpp>
#include <Controllers/CompletedTripController.hpp>
#include <Controllers/CountryInformationGenerator.hpp>
#include <Controllers/GoalsController.hpp>
#include <Controllers/LocationController.hpp>
#include <Controllers/StartTripController.hpp>
#include <Controllers/TripController.hpp>
#include <Controllers/TripDayController.hpp>
#include <Controllers/UserAccountController.hpp>
#include <Controllers/VisitedLocationsController.hpp>
#include <Controllers/WaitingTripController.hpp>
#include <Managers/TripsManager.hpp>
#include <Models/BackpackFilterModel.hpp>
#include <Models/CheckListFilterModel.h>
#include <Models/CheckListModel.h>
#include <Models/CompletedTripsModel.hpp>
#include <Models/CountriesCitiesModel.hpp>
#include <Models/GoalsModel.hpp>
#include <Models/PhotosModel.hpp>
#include <Models/TravelAgentsModel.hpp>
#include <Models/TripDaysModel.hpp>
#include <Services/AuthenticationService.hpp>
#include <Services/EndTripService.hpp>
#include <Services/GalleryService.hpp>
#include <Services/PackService.hpp>
#include <Storage/DataBaseStorage.hpp>
#include <Storage/PhotosStorage.hpp>
#include <Storage/Trip.hpp>
#include <src/QMLUtils.hpp>

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QSettings>

int main(int argc, char* argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    DataBaseStorage dataBaseStorage;
    AuthenticationService authService(dataBaseStorage);
    LocationController locationController;

    TripsManager tripsManager(dataBaseStorage, authService);
    ApplicationController appController(dataBaseStorage, tripsManager);
    UserAccountController userAccountController(dataBaseStorage);
    GoalsController goalsController(dataBaseStorage);
    VisitedLocationsController visitedLocationsController(dataBaseStorage, authService);
    PhotosStorage photosStorage(dataBaseStorage, authService);

    static auto* utils = new QMLUtils;
    qmlRegisterType<CheckListFilterModel>("CheckListFilterModel", 1, 0, "CheckListFilterModel");
    qmlRegisterType<StartTripController>("StartTripController", 1, 0, "StartTripController");
    qmlRegisterType<TravelAgentsModel>("TravelAgentsModel", 1, 0, "TravelAgentsModel");
    qmlRegisterType<CountryInformationGenerator>("CountryInfoGenerator", 1, 0, "CountryInfoGenerator");
    qmlRegisterType<PackService>("PackService", 1, 0, "PackService");
    qmlRegisterType<WaitingTripController>("WaitingTripController", 1, 0, "WaitingTripController");
    qmlRegisterType<CompletedTripController>("CompletedTripController", 1, 0, "CompletedTripController");
    qmlRegisterType<CompletedTripsModel>("CompletedTripsModel", 1, 0, "CompletedTripsModel");
    qmlRegisterType<GalleryService>("GalleryService", 1, 0, "GalleryService");
    qmlRegisterType<Trip>("Trip", 1, 0, "Trip");
    qmlRegisterType<TripDaysModel>("TripDaysModel", 1, 0, "TripDaysModel");
    qmlRegisterType<BackPackModel>("BackPackModel", 1, 0, "BackPackModel");
    qmlRegisterType<BackpackFilterModel>("BackpackFilterModel", 1, 0, "BackpackFilterModel");
    qmlRegisterType<ActiveTripController>("ActiveTripController", 1, 0, "ActiveTripController");
    qmlRegisterType<PhotosModel>("PhotosModel", 1, 0, "PhotosModel");
    qmlRegisterType<TripDayController>("TripDayController", 1, 0, "TripDayController");
    qmlRegisterType<EndTripService>("EndTripService", 1, 0, "EndTripService");
    qmlRegisterType<CountriesCitiesModel>("CountriesCitiesModel", 1, 0, "CountriesCitiesModel");
    qmlRegisterType<GoalsModel>("GoalsModel", 1, 0, "GoalsModel");
    qmlRegisterType<CheckListModel>("CheckListModel", 1, 0, "CheckListModel");

    qmlRegisterSingletonType<QMLUtils>("com.plm.utils", 1, 0, "Utils",
        [](QQmlEngine* engine, QJSEngine*) -> QObject* {
            engine->setObjectOwnership(utils, QQmlEngine::CppOwnership);
            return utils;
        });

    engine.rootContext()->setContextProperty("goalsController", &goalsController);
    engine.rootContext()->setContextProperty("applicationDirPath", QGuiApplication::applicationDirPath());
    engine.rootContext()->setContextProperty("appController", &appController);
    engine.rootContext()->setContextProperty("tripsManager", &tripsManager);
    engine.rootContext()->setContextProperty("locationController", &locationController);
    engine.rootContext()->setContextProperty("tripsManager", &tripsManager);
    engine.rootContext()->setContextProperty("authService", &authService);
    engine.rootContext()->setContextProperty("userAccountController", &userAccountController);
    engine.rootContext()->setContextProperty("visitedLocationsController", &visitedLocationsController);
    engine.rootContext()->setContextProperty("photosStorage", &photosStorage);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject* obj, const QUrl& objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
