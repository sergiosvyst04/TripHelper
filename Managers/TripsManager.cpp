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

QList<TripData>* TripsManager::completedTrips()
{
    return _tripsStorage.getCompletedTrips();
}

//==============================================================================

TripsStorage* TripsManager::getStorage()
{
    return &_tripsStorage;
}
