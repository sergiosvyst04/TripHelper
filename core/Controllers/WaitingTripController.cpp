#include "WaitingTripController.hpp"
#include "QDebug"

#include "Storage/Trip.hpp"

WaitingTripController::WaitingTripController(QObject *parent) : QObject(parent)
{

}

//==============================================================================

void WaitingTripController::intialize(ApplicationController *applicationController)
{
    _waitingTrip = applicationController->getTripsManager().getUnCompletedTrip();
}

//==============================================================================

Trip* WaitingTripController::getTrip()
{
    Trip *trip = new Trip(_waitingTrip);
    return trip;
}

//==============================================================================

