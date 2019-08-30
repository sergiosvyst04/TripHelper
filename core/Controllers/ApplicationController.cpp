#include "ApplicationController.hpp"

ApplicationController::ApplicationController(QObject *parent) : QObject(parent)
{

}

//==============================================================================

TripsManager& ApplicationController::getTripsManager()
{
    return _tripsManager;
}
