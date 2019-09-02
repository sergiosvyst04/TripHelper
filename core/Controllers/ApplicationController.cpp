#include "ApplicationController.hpp"

ApplicationController::ApplicationController(TripsManager &tripsManager ,QObject *parent)
    : _tripsManager(tripsManager),
      QObject(parent)
{

}

//==============================================================================

TripsManager& ApplicationController::getTripsManager()
{
    return _tripsManager;
}

//==============================================================================

//void ApplicationController::init(TripsManager &tripsManager)
//{
//   _tripsManager = tripsManager;
//}
