#include "ActiveTripController.hpp"
#include "QDebug"

ActiveTripController::ActiveTripController(QObject *parent) : QObject(parent)
{
    _activeTrip = new TripData();
}

//==============================================================================


void ActiveTripController::intialize(ApplicationController *applicationController)
{
    qDebug() << "intialize";
    _activeTrip = applicationController->getTripsManager().activeTrip();
}

//==============================================================================

void ActiveTripController::addNote(const QString &newNote)
{
    TripDay &currentTripDay = _activeTrip->days.last();
    currentTripDay.notes.push_back(newNote);
}

//==============================================================================

void ActiveTripController::addNewIdea(const QString &newIdea)
{
    TripDay &currentTripDay = _activeTrip->days.last();
    currentTripDay.ideas.push_back(newIdea);
}

//==============================================================================

void ActiveTripController::makeCheckIn()
{
//    TripDay &currentTripDay = _activeTrip->getCurrentTripDay();
//    QString city = _activeTrip->getCurrentLocation().city();
//    currentTripDay.cities.push_back(city);
    // checkIfSuchCityISVisited
}

//==============================================================================

void ActiveTripController::addNewPhoto(const QString &path)
{
    TripDay& currentTripDay = _activeTrip->days.last();
    qDebug() << "count of photos before : " <<  currentTripDay.photos.size();
    QGeoAddress location;
    QDateTime timestamp = QDateTime::currentDateTime();

    Photo newPhoto {
        path,
                timestamp,
                location
    };

    currentTripDay.photos.push_back(newPhoto);
    qDebug() << "count of photos after : " <<  currentTripDay.photos.size();
}

//==============================================================================

void ActiveTripController::endTrip()
{

}

//==============================================================================

Trip* ActiveTripController::getTrip()
{
    Trip *trip = new Trip(_activeTrip);
    emit tripChanged();
    return  trip;
}
