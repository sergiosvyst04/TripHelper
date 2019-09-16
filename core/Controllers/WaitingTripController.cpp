#include "WaitingTripController.hpp"
#include "QDebug"

WaitingTripController::WaitingTripController(QObject *parent) : QObject(parent)
{

}

//==============================================================================

void WaitingTripController::intialize(ApplicationController *applicationController)
{
//    _backPackModel = new BackPackModel();
    _waitingTrip = applicationController->getTripsManager().waitingTrip();
//    _backPackModel->setItemsList(_waitingTrip->backPackList);
}

//==============================================================================

Trip* WaitingTripController::getTrip()
{
    Trip *trip = new Trip(_waitingTrip);
    return trip;
}

//==============================================================================

//BackPackModel* WaitingTripController::getBackpack()
//{
//    return _backPackModel;
//}
