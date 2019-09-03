#ifndef LOCATIONCONTROLLER_HPP
#define LOCATIONCONTROLLER_HPP

#include <QObject>
#include <QGeoLocation>
#include <QGeoAddress>

class LocationController : public QObject
{
    Q_OBJECT
public:
    explicit LocationController(QObject *parent = nullptr);

signals:
    void currentCountryChanged();

public slots:
    void checkLocation();
    QGeoAddress getCurrentLocation();

private:
    QGeoLocation _locationController;
    QGeoAddress _currentLocation;
};

#endif // LOCATIONCONTROLLER_HPP
