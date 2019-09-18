#include "ApplicationController.hpp"


ApplicationController::ApplicationController(TripsManager &tripsManager ,QObject *parent)
    : QObject(parent),
      _tripsManager(tripsManager)
{

}

//==============================================================================

TripsManager& ApplicationController::getTripsManager()
{
    return _tripsManager;
}

//==============================================================================

