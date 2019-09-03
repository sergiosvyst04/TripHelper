#include "TripDayController.hpp"
#include "memory"
#include "QPointer"
#include "QDebug"

TripDayController::TripDayController(QObject *parent) : QObject(parent)
{
    _tripDay = new TripDay();
}

//==============================================================================

void TripDayController::intialize(int index, ActiveTripController *atc)
{
    std::unique_ptr<Trip> trip(atc->getTrip());
    _tripDay = new TripDay(trip.get()->getDays().at(index));
}

//==============================================================================

QVector<Photo> TripDayController::getPhotosOfDay()
{
    return _tripDay->photos;
}

//==============================================================================

QVector<QString> TripDayController::getCitiesOfDay()
{
    return _tripDay->cities;
}

//==============================================================================

QVector<QString> TripDayController::getIdeasOfDay()
{
    return _tripDay->ideas;
}

//==============================================================================

QVector<QString> TripDayController::getNotesOfDay()
{
    return _tripDay->notes;
}
