#include "ApplicationController.hpp"


ApplicationController::ApplicationController(DataBaseStorage &dbStorage ,TripsManager &tripsManager ,QObject *parent)
    : QObject(parent),
      _dbStorage(dbStorage),
      _tripsManager(tripsManager)
{

}

//==============================================================================

TripsManager& ApplicationController::getTripsManager()
{
    return _tripsManager;
}

//==============================================================================

DataBaseStorage& ApplicationController::getDatabase()
{
    return _dbStorage;
}
