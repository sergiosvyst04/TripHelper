#ifndef TRIPCONTROLLER_HPP
#define TRIPCONTROLLER_HPP

#include <QObject>
#include <QPointer>
#include <memory>
#include "core/Storage/Trip.hpp"

class TripController : public QObject
{
    Q_OBJECT
public:
    explicit TripController(QObject *parent = nullptr);

signals:
    void currentTripStateChanged();
    void forgotToPack();

public slots:
    Trip *getCurrentTrip();
    bool hasWaitingTrip();
    bool hasActiveTrip();
    bool hasUnCompletedTrip();
    void createTrip(const QString &name, QDateTime depatureDate);

private:
    std::unique_ptr<Trip> _currentTrip;
};

#endif // TRIPCONTROLLER_HPP
