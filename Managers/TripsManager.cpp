#include "TripsManager.hpp"

TripsManager::TripsManager(QObject *parent) : QObject(parent)
{

}

//==============================================================================

std::unique_ptr<Trip> TripsManager::activeTrip()
{
    return _tripsStorage.getActiveTrip();
}

//==============================================================================

std::unique_ptr<Trip> TripsManager::waitingTrip()
{
    return _tripsStorage.getWaitingTrip();
}

//==============================================================================

CompletedTripsModel* TripsManager::completedTrips()
{
    return _tripsStorage.getCompletedTripsModel();
}

//==============================================================================

