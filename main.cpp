#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "core/Models/TripsModel.hpp"
#include "core/Models/GoalsModel.hpp"
#include "core/Storage/Trip.hpp"
#include "QMLUtils.hpp"
#include "core/Controllers/TripController.hpp"


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    GoalsModel goalsModel;
    TripsModel tripsModel;
    TripController tripController;




    static auto *utils = new QMLUtils;
    qmlRegisterType<Trip>("Trip", 1, 0, "Trip");
    qmlRegisterSingletonType<QMLUtils>("com.plm.utils", 1, 0, "Utils",
                                              [](QQmlEngine *engine, QJSEngine *) -> QObject* {
            engine->setObjectOwnership(utils, QQmlEngine::CppOwnership);
            return utils;
        });

    engine.rootContext()->setContextProperty("applicationDirPath", QGuiApplication::applicationDirPath());
    engine.rootContext()->setContextProperty("goalsModel", &goalsModel);
    engine.rootContext()->setContextProperty("tripsModel", &tripsModel);
    engine.rootContext()->setContextProperty("tripController", &tripController);
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
