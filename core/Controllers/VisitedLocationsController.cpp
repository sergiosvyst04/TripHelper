#include "VisitedLocationsController.hpp"

VisitedLocationsController::VisitedLocationsController(DataBaseStorage &dbStorage, AuthenticationService &authService ,QObject *parent)
    : _dbStorage(dbStorage),
      _authService(authService),
      QObject(parent)
{
    if(_authService.isSignedIn())
        readLocations();

    connect(&_authService, &AuthenticationService::signedIn, this, &VisitedLocationsController::readLocations);


    connect(this, &VisitedLocationsController::newCityAdded, &_dbStorage, &DataBaseStorage::addCity);
    connect(this, &VisitedLocationsController::newCountryAdded, &_dbStorage, &DataBaseStorage::addCountry);
}

//==============================================================================

QVector<QString> VisitedLocationsController::getCities()
{
    return _visitedCities;
}

//==============================================================================

QVector<QString> VisitedLocationsController::getCountries()
{
    return _visitedCountries;
}

//==============================================================================

void VisitedLocationsController::addLocation(QString country, QString city)
{
    if(!_visitedCountries.contains(country)) {
        _visitedCountries.push_back(country);
        emit newCountryAdded(country);
    }

    if(!_visitedCities.contains(city)) {
        _visitedCities.push_back(city);
        emit newCityAdded(city);
    }

    emit locationAdded();
}

//==============================================================================

int VisitedLocationsController::getAmountOfVisitedCities() const
{
    return _visitedCities.size();
}

//==============================================================================

int VisitedLocationsController::getAmountOfVisitedCountries() const
{
    return _visitedCountries.size();
}

//==============================================================================

void VisitedLocationsController::readLocations()
{
    _visitedCities = _dbStorage.getLocations("visitedCities");
    _visitedCountries = _dbStorage.getLocations("visitedCountries");
}


