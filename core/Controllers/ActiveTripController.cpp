#include "ActiveTripController.hpp"
#include "QDebug"

ActiveTripController::ActiveTripController(QObject *parent) : QObject(parent)
{

}

//==============================================================================


void ActiveTripController::intialize(ApplicationController *applicationController)
{
    qDebug() << "intialize";
    _activeTrip = applicationController->getTripsManager().activeTrip();
    qDebug() << _activeTrip->getName();
}

//==============================================================================

void ActiveTripController::addNote(const QString &newNote)
{
    _activeTrip->addNote(newNote);
}

//==============================================================================

void ActiveTripController::addNewIdea(const QString &newIdea)
{
    _activeTrip->addNewIdea(newIdea);
}

//==============================================================================

void ActiveTripController::makeCheckIn()
{
    _activeTrip->makeCheckIn();
}

//==============================================================================

void ActiveTripController::endTrip()
{

}

//==============================================================================


