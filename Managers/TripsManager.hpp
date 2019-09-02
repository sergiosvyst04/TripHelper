#ifndef TRIPSMANAGER_HPP
#define TRIPSMANAGER_HPP

#include <QObject>
#include "core/Storage/TripsStorage.hpp"

class TripsManager : public QObject
{
    Q_OBJECT
public:
    explicit TripsManager(QObject *parent = nullptr);
    
    std::unique_ptr<Trip> activeTrip();
    std::unique_ptr<Trip> waitingTrip();
    CompletedTripsModel* completedTrips();

signals:

public slots:
    
private:
    TripsStorage _tripsStorage;
};

#endif // TRIPSMANAGER_HPP
