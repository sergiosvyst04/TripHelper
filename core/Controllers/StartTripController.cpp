#include "StartTripController.hpp"

StartTripController::StartTripController(QObject *parent) : QObject(parent)
{

}

//==============================================================================

void StartTripController::intialize(ApplicationController *applicationController)
{
    _dbStorage = &applicationController->getDatabase();
}

//==============================================================================

void StartTripController::startTrip(const QString &name, QDateTime depatureDate)
{
    TripData tripToStart;
    tripToStart.name = name;
    tripToStart.depatureDate = depatureDate;
    tripToStart.days = {};
    tripToStart.backPackList = {};
    _dbStorage->startNewTrip(tripToStart);

    emit tripStarted();
}
