#ifndef STARTTRIPCONTROLLER_HPP
#define STARTTRIPCONTROLLER_HPP

#include <QObject>
#include <Storage/DataBaseStorage.hpp>
#include <Controllers/ApplicationController.hpp>

class StartTripController : public QObject
{
    Q_OBJECT
public:
    explicit StartTripController(QObject *parent = nullptr);
    Q_INVOKABLE void intialize(ApplicationController *applicationController);

signals:
    void tripStarted();

public slots:
    void startTrip(const QString &name, QDateTime depatureDate);

private:
  DataBaseStorage *_dbStorage;
};

#endif // STARTTRIPCONTROLLER_HPP
