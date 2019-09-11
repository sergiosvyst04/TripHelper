#include "EndTripService.hpp"
#include "QDebug"

EndTripService::EndTripService(QObject *parent) : QObject(parent)
{

}

//==============================================================================

void EndTripService::intialize(ApplicationController *applicationController)
{
    _completedTripsModel = applicationController->getTripsManager().completedTrips();
    _activeTrip = applicationController->getTripsManager().activeTrip();
}

//==============================================================================

QVector<Photo> EndTripService::getAllPhotos()
{
    QVector<Photo> allPhotosList;
    for(int i = 0; i < _activeTrip->days.size(); i++)
    {
        for(int j = 0; j < _activeTrip->days.at(i).photos.size(); j++)
        {
            Photo photo = _activeTrip->days.at(i).photos.at(j);
            allPhotosList.push_back(photo);
        }
    }

    return allPhotosList;
}

//==============================================================================

QVector<QString> EndTripService::getAllCities()
{
    QVector<QString> allCitiesList;
    for(int i = 0; i < _activeTrip->days.size(); i++)
    {
        for(int j = 0; j < _activeTrip->days.at(i).cities.size(); j++)
        {
            QString city = _activeTrip->days.at(i).cities.at(j);
            allCitiesList.push_back(city);
        }
    }

    return allCitiesList;
}

//==============================================================================

QVector<QString> EndTripService::getAllCountries()
{
    QVector<QString> allCountriesList;
    for(int i = 0; i < _activeTrip->days.size(); i++)
    {
        for(int j = 0; j < _activeTrip->days.at(i).countries.size(); j++)
        {
            QString city = _activeTrip->days.at(i).countries.at(j);
            allCountriesList.push_back(city);
        }
    }

    return allCountriesList;
}

//==============================================================================

void EndTripService::endTrip()
{
    TripData* _completedTrip = _activeTrip;
    _activeTrip->days = {};
    _activeTrip->name = "";
    _activeTrip->backpack->destroyed();
    _completedTripsModel->addTrip(*_completedTrip);
}


