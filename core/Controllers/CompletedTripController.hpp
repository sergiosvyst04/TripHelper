#ifndef COMPLETEDTRIPCONTROLLER_HPP
#define COMPLETEDTRIPCONTROLLER_HPP

#include <QObject>
#include "Controllers/ApplicationController.hpp"

class Trip;

class CompletedTripController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(Trip* trip READ getTrip)
public:
    explicit CompletedTripController(QObject *parent = nullptr);
    Q_INVOKABLE void intialize(int index, ApplicationController *applicationController);
signals:

public slots:
     Trip* getTrip();

private:
    TripData *_completedTrip;

};

#endif // COMPLETEDTRIPCONTROLLER_HPP
