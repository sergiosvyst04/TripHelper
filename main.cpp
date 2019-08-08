#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "core/Models/TripsModel.hpp"
#include "core/Models/GoalsModel.hpp"
#include "QMLUtils.hpp"


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    GoalsModel goalsModel;
    TripsModel tripsModel;


    static auto *utils = new QMLUtils;

    qmlRegisterSingletonType<QMLUtils>("com.plm.utils", 1, 0, "Utils",
                                              [](QQmlEngine *engine, QJSEngine *) -> QObject* {
            engine->setObjectOwnership(utils, QQmlEngine::CppOwnership);
            return utils;
        });

    engine.rootContext()->setContextProperty("applicationDirPath", QGuiApplication::applicationDirPath());
    engine.rootContext()->setContextProperty("goalsModel", &goalsModel);
    engine.rootContext()->setContextProperty("tripsModel", &tripsModel);
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
