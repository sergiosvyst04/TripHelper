#ifndef ACTIVETRIPCONTROLLER_HPP
#define ACTIVETRIPCONTROLLER_HPP

#include <QObject>
#include <core/Storage/Trip.hpp>
#include "core/Controllers/ApplicationController.hpp"
#include "core/Controllers/LocationController.hpp"

class ActiveTripController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(Trip* trip READ getTrip NOTIFY tripChanged)
    Q_PROPERTY(QString currentCity READ getCurrentCity NOTIFY currentCityChanged)

public:
    explicit ActiveTripController(QObject *parent = nullptr);


signals:
    void tripChanged();
    void currentCityChanged();

public slots:
    void addNote(const QString &newNote);
    void addNewIdea(const QString &newIdea);
    void makeCheckIn();
    void endTrip();
    void addNewPhoto(const QString &path);

    QString getCurrentCity();
    Trip* getTrip();

    void intialize(ApplicationController* applicationController, LocationController *locationController);

private:
    TripData *_activeTrip;
    LocationController *_locationController;
    TripsStorage *_tripsStorage;

};

#endif // ACTIVETRIPCONTROLLER_HPP
