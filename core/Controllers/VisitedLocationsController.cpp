#include "VisitedLocationsController.hpp"

VisitedLocationsController::VisitedLocationsController(DataBaseStorage &dbStorage ,QObject *parent)
    : _dbStorage(dbStorage),
      QObject(parent)
{
    _visitedCities = _dbStorage.getLocations("visitedCities");
    _visitedCountries = _dbStorage.getLocations("visitedCountries");
}

QVector<QString> VisitedLocationsController::getCities()
{
    return _visitedCities;
}

QVector<QString> VisitedLocationsController::getCountries()
{
    return _visitedCountries;
}


