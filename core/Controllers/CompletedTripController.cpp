#include "CompletedTripController.hpp"
#include "QDebug"

CompletedTripController::CompletedTripController(QObject *parent) : QObject(parent)
{

}

//==============================================================================

void CompletedTripController::intialize(int index, ApplicationController *applicationController)
{
     TripData fetchedTrip = applicationController->getTripsManager().completedTrips()->fetchCompletedTrip(index);
    _completedTrip = new TripData(fetchedTrip);
}

//==============================================================================

Trip* CompletedTripController::getTrip()
{

    Trip *trip = new Trip(_completedTrip);
    return trip;
}
