#include "TripsManager.hpp"

TripsManager::TripsManager(QObject *parent) : QObject(parent)
{

}

//==============================================================================

Trip* TripsManager::activeTrip()
{
    return _tripsStorage.getActiveTrip();
}

//==============================================================================

Trip& TripsManager::waitingTrip()
{
    return _tripsStorage.getWaitingTrip();
}

//==============================================================================

CompletedTripsModel* TripsManager::completedTrips()
{
    return _tripsStorage.getCompletedTripsModel();
}
