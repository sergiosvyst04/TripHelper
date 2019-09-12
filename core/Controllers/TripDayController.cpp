#include "TripDayController.hpp"
#include "memory"
#include "QPointer"
#include "QDebug"

TripDayController::TripDayController(QObject *parent) : QObject(parent)
{
    _tripDay = new TripDay();
}

//==============================================================================

void TripDayController::intialize(int index, Trip *trip)
{
    _tripDay = new TripDay(trip->getDays().at(index));
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
