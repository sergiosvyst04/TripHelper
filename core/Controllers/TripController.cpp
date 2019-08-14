#include "TripController.hpp"
#include <QDebug>

TripController::TripController(QObject *parent) : QObject(parent)
{
//    connect(_currentTrip.get(), &Trip::stateChanged, this, &TripController::currentTripStateChanged);
//    connect(_currentTrip.get(), &Trip::stateChanged, [](){
//        qDebug() << "CHANGED!";
//    } );
}

void TripController::createTrip(const QString &name, QDateTime depatureDate)
{
    _currentTrip.reset(new Trip(name, depatureDate));
    connect(_currentTrip.get(), &Trip::stateChanged, this, &TripController::currentTripStateChanged);
}

bool TripController::hasWaitingTrip()
{
    return _currentTrip ? _currentTrip->getState() == 0 : false;
}

bool TripController::hasActiveTrip()
{
    return _currentTrip ? _currentTrip->getState() == 1 : false;
}

bool TripController::hasUnCompletedTrip()
{
    return _currentTrip ? false : true;
}

Trip *TripController::getCurrentTrip()
{
    return _currentTrip.get();
}
