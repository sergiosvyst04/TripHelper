#ifndef ACTIVETRIPCONTROLLER_HPP
#define ACTIVETRIPCONTROLLER_HPP

#include <QObject>
#include <core/Storage/Trip.hpp>
#include "core/Controllers/ApplicationController.hpp"

class ActiveTripController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(Trip* trip READ getTrip)

public:
    explicit ActiveTripController(QObject *parent = nullptr);


signals:

public slots:
    void addNote(const QString &newNote);
    void addNewIdea(const QString &newIdea);
    void makeCheckIn();
    void endTrip();
    void addNewPhoto(const QString &path);

    Trip* getTrip();

    void intialize(ApplicationController* applicationController);

private:
    Trip *_activeTrip;
};

#endif // ACTIVETRIPCONTROLLER_HPP
