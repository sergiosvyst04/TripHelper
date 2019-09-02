#ifndef APPLICATIONCONTROLLER_HPP
#define APPLICATIONCONTROLLER_HPP

#include <QObject>
#include "Managers/TripsManager.hpp"

class ApplicationController : public QObject
{
    Q_OBJECT
public:
    explicit ApplicationController(TripsManager &tripsManager ,QObject *parent = nullptr);
    TripsManager& getTripsManager();
//    Q_INVOKABLE void init(TripsManager &tripsManager);

signals:

public slots:
    
private:
   TripsManager &_tripsManager;
};

#endif // APPLICATIONCONTROLLER_HPP
