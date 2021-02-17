#include "CompletedTripController.hpp"
#include "QDebug"
#include "Storage/Trip.hpp"

CompletedTripController::CompletedTripController(QObject *parent) : QObject(parent)
{

}

//==============================================================================

void CompletedTripController::intialize(int index, ApplicationController *applicationController)
{
     TripData fetchedTrip = applicationController->getTripsManager().getCompletedTrips()->at(index);
    _completedTrip = new TripData(fetchedTrip);
}

//==============================================================================

Trip* CompletedTripController::getTrip()
{
    Trip *trip = new Trip(_completedTrip);
    return trip;
}
