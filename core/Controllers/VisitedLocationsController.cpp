#include "VisitedLocationsController.hpp"

VisitedLocationsController::VisitedLocationsController(DataBaseStorage &dbStorage, AuthenticationService &authService ,QObject *parent)
    : _dbStorage(dbStorage),
      _authService(authService),
      QObject(parent)
{
    if(_authService.isSignedIn())
        readLocations();

    connect(&_authService, &AuthenticationService::signedIn, this, &VisitedLocationsController::readLocations);

    connect(this, &VisitedLocationsController::newLocationAdded, &_dbStorage, &DataBaseStorage::addLocation);


}

//==============================================================================

QVector<QString> VisitedLocationsController::getCities()
{
    QVector<QString> cities;
    for(auto location : _visitedLocations)
        cities.push_back(location.city);
    return cities;
}

//==============================================================================

QVector<QString> VisitedLocationsController::getCountries()
{
    QVector<QString> countries;
    for(auto location : _visitedLocations)
        if(!countries.contains(location.country))
            countries.push_back(location.country);
    return countries;
}

//==============================================================================

void VisitedLocationsController::addLocation(QString country, QString city)
{

    Location newLocation;
    newLocation.country = country;
    newLocation.city = city;

    if(!_visitedLocations.contains(newLocation))
    {
        _visitedLocations.push_back(newLocation);
        emit newLocationAdded(newLocation);
    }

    emit locationAdded();
}

//==============================================================================

int VisitedLocationsController::getAmountOfVisitedCities() const
{
    QVector<QString> cities;
    for(auto &location : _visitedLocations)
        cities.push_back(location.city);
    return cities.size();
}

//==============================================================================

int VisitedLocationsController::getAmountOfVisitedCountries() const
{
    QVector<QString> countries;
    for(auto &location : _visitedLocations)
    {
        if(!countries.contains(location.country))
            countries.push_back(location.country);
    }
    return countries.size();
}

//==============================================================================

void VisitedLocationsController::readLocations()
{
    _visitedLocations = _dbStorage.getVisitedLocations();
}


