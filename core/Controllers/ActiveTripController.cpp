#include "ActiveTripController.hpp"
#include "QDebug"

ActiveTripController::ActiveTripController(QObject *parent) : QObject(parent)
{
    _locationController = new LocationController();
}

//==============================================================================


void ActiveTripController::intialize(ApplicationController *applicationController, LocationController *locationController)
{
    _activeTrip = applicationController->getTripsManager().getUnCompletedTrip();
    _locationController = locationController;
    _tripsManager = &applicationController->getTripsManager();

    connect(this, &ActiveTripController::activeTripDataChanged, _tripsManager, &TripsManager::updateUncompletedTrip);
}

//==============================================================================

void ActiveTripController::addNote(const QString &newNote)
{
    TripDay &currentTripDay = _activeTrip->days.last();
    currentTripDay.notes.push_back(newNote);

    emit activeTripDataChanged();
}

//==============================================================================

void ActiveTripController::addNewIdea(const QString &newIdea)
{
    TripDay &currentTripDay = _activeTrip->days.last();
    currentTripDay.ideas.push_back(newIdea);

    emit activeTripDataChanged();
}

//==============================================================================

void ActiveTripController::makeCheckIn()
{
    TripDay &currentTripDay = _activeTrip->days.last();
    QString city = _locationController->getCurrentLocation().city();
    QString country = _locationController->getCurrentLocation().country();
    currentTripDay.cities.push_back(city);
    currentTripDay.countries.push_back(country);

    // checkIfSuchCityISVisited
    emit activeTripDataChanged();
}

//==============================================================================

void ActiveTripController::addNewPhoto(const QString &path)
{
    TripDay& currentTripDay = _activeTrip->days.last();
    QGeoAddress location = _locationController->getCurrentLocation();
    QDateTime timestamp = QDateTime::currentDateTime();

    Photo newPhoto {
        path,
        timestamp,
        location
    };

    currentTripDay.photos.push_back(newPhoto);
    emit activeTripDataChanged();
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

//==============================================================================

QString ActiveTripController::getCurrentCity()
{
    QString currentCity = _locationController->getCurrentLocation().city();
    emit currentCityChanged();
    return currentCity;
}
