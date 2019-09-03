#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "core/Models/GoalsModel.hpp"
#include "core/Storage/Trip.hpp"
#include "QMLUtils.hpp"
#include "core/Controllers/TripController.hpp"
#include "core/Models/BackpackFilterModel.hpp"
#include "core/Storage/TripsStorage.hpp"
#include "core/Controllers/ApplicationController.hpp"
#include "Managers/TripsManager.hpp"
#include "core/Controllers/ActiveTripController.hpp"
#include "core/Models/TripDaysModel.hpp"


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    GoalsModel goalsModel;
    TripsStorage tripsStorage;
    TripsManager tripsManager;
    ApplicationController appController(tripsManager);


    static auto *utils = new QMLUtils;
    qmlRegisterType<Trip>("Trip", 1, 0, "Trip");
    qmlRegisterType<TripDaysModel>("TripDaysModel", 1, 0, "TripDaysModel");
    qmlRegisterType<BackPackModel>("BackPackModel", 1, 0, "BackPackModel");
    qmlRegisterType<BackpackFilterModel>("BackpackFilterModel", 1, 0, "BackpackFilterModel");
    qmlRegisterType<ActiveTripController>("ActiveTripController", 1, 0, "ActiveTripController");

    qmlRegisterSingletonType<QMLUtils>("com.plm.utils", 1, 0, "Utils",
                                       [](QQmlEngine *engine, QJSEngine *) -> QObject* {
        engine->setObjectOwnership(utils, QQmlEngine::CppOwnership);
        return utils;
    });


    engine.rootContext()->setContextProperty("applicationDirPath", QGuiApplication::applicationDirPath());
    engine.rootContext()->setContextProperty("tripsStorage", &tripsStorage);
    engine.rootContext()->setContextProperty("goalsModel", &goalsModel);
    engine.rootContext()->setContextProperty("appController", &appController);
    engine.rootContext()->setContextProperty("tripsManager", &tripsManager);
    engine.rootContext()->setContextProperty("tripsStorage", &tripsStorage);
    
    
    
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    //    engine.load(url);


    return app.exec();
}
