#ifndef TRIPSMANAGER_HPP
#define TRIPSMANAGER_HPP

#include <QObject>
#include "core/Storage/TripsStorage.hpp"

class TripsManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QList<TripData>* completedTrips READ completedTrips CONSTANT)
public:
    explicit TripsManager(QObject *parent = nullptr);
    
    TripData* activeTrip();
    TripData* waitingTrip();
    QList<TripData>* completedTrips();
    TripsStorage* getStorage();

signals:

public slots:
    
private:
    TripsStorage _tripsStorage;
};

#endif // TRIPSMANAGER_HPP
