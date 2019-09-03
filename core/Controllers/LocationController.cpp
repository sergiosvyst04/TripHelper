#include "LocationController.hpp"
#include "QTimer"
#include "QDebug"

LocationController::LocationController(QObject *parent) : QObject(parent)
{

    QTimer *timer = new QTimer();
    timer->start(30000);

    connect(timer, &QTimer::timeout, this, &LocationController::checkLocation);
}

//==============================================================================

void LocationController::checkLocation()
{
    QGeoAddress currentAddress = _locationController.address();
    if(_currentLocation.country() != currentAddress.country())
    {
        emit currentCountryChanged();
    }

    _currentLocation = currentAddress;
}

//==============================================================================

QGeoAddress LocationController::getCurrentLocation()
{
    return _currentLocation;
}
