#include "TripsManager.hpp"
#include "QDebug"

TripsManager::TripsManager(QObject *parent) : QObject(parent)
{
}

//==============================================================================

TripData* TripsManager::activeTrip()
{
    return _tripsStorage.getActiveTrip();
}

//==============================================================================

TripData* TripsManager::waitingTrip()
{
    return _tripsStorage.getWaitingTrip();
}

//==============================================================================

CompletedTripsModel* TripsManager::completedTrips()
{
    return _tripsStorage.getCompletedTripsModel();
}
