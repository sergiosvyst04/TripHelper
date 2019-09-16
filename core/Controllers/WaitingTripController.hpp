#ifndef WAITINGTRIPCONTROLLER_HPP
#define WAITINGTRIPCONTROLLER_HPP

#include <QObject>
#include "core/Storage/TripData.hpp"
#include "core/Models/BackPackModel.hpp"
#include "core/Controllers/ApplicationController.hpp"

class WaitingTripController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(Trip* trip READ getTrip)
//    Q_PROPERTY(BackPackModel* backPack READ getBackpack)

public:
    explicit WaitingTripController(QObject *parent = nullptr);
    Q_INVOKABLE void intialize(ApplicationController *applicationController);

signals:

public slots:
    Trip* getTrip();
//    BackPackModel* getBackpack();

private:
    TripData *_waitingTrip;
//    BackPackModel *_backPackModel;
};

#endif // WAITINGTRIPCONTROLLER_HPP
