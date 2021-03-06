#ifndef APPLICATIONCONTROLLER_HPP
#define APPLICATIONCONTROLLER_HPP

#include <QObject>
#include "Managers/TripsManager.hpp"

class ApplicationController : public QObject
{
    Q_OBJECT
public:
    explicit ApplicationController(DataBaseStorage &dbStorage ,TripsManager &tripsManager, QObject *parent = nullptr);
    TripsManager& getTripsManager();
    DataBaseStorage& getDatabase();

signals:

public slots:
    
private:
   DataBaseStorage &_dbStorage;
   TripsManager &_tripsManager;
};

#endif // APPLICATIONCONTROLLER_HPP
