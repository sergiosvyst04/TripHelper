#ifndef ACTIVETRIPCONTROLLER_HPP
#define ACTIVETRIPCONTROLLER_HPP

#include <QObject>
#include <core/Storage/Trip.hpp>
#include "core/Controllers/ApplicationController.hpp"

class ActiveTripController : public QObject
{
    Q_OBJECT
//    Q_PROPERTY(QString name READ getName CONSTANT)


public:
    explicit ActiveTripController(QObject *parent = nullptr);
    void addNote(const QString &newNote);
    void addNewIdea(const QString &newIdea);
    void makeCheckIn();
    void endTrip();




signals:

public slots:
    void intialize(ApplicationController* applicationController);

private:
    std::unique_ptr<Trip> _activeTrip;
};

#endif // ACTIVETRIPCONTROLLER_HPP
