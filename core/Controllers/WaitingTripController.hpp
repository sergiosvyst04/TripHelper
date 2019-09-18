#ifndef WAITINGTRIPCONTROLLER_HPP
#define WAITINGTRIPCONTROLLER_HPP

#include <QObject>
#include "core/Storage/TripData.hpp"
#include "core/Models/BackPackModel.hpp"
#include "core/Controllers/ApplicationController.hpp"

class Trip;

class WaitingTripController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(Trip* trip READ getTrip)

public:
    explicit WaitingTripController(QObject *parent = nullptr);
    Q_INVOKABLE void intialize(ApplicationController *applicationController);

signals:

public slots:
    Trip* getTrip();
private:
    TripData *_waitingTrip;
};

#endif // WAITINGTRIPCONTROLLER_HPP
