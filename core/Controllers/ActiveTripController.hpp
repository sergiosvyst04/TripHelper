#ifndef ACTIVETRIPCONTROLLER_HPP
#define ACTIVETRIPCONTROLLER_HPP

#include <QObject>
#include <core/Storage/Trip.hpp>

class ActiveTripController : public QObject
{
    Q_OBJECT
public:
    explicit ActiveTripController(QObject *parent = nullptr);

    void intialize();
signals:

public slots:

private:
    Trip _activeTrip;
};

#endif // ACTIVETRIPCONTROLLER_HPP
