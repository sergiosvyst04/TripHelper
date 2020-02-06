#include "GoalsController.hpp"

GoalsController::GoalsController(DataBaseStorage &dbStorage ,QObject *parent)
    : _dbStorage(dbStorage),
      QObject(parent)
{
    connect(this, &GoalsController::goalAdded, &_dbStorage, &DataBaseStorage::updateUsersData);
}

void GoalsController::addGoal(const QString &country,const QString &city, QDateTime departureDate)
{
    departureDate.setTime(QTime(0,0));
    Goal newGoal{
        country.toStdString(),
                city.toStdString(),
                departureDate
    };

    _dbStorage.addGoal(newGoal);
    emit goalAdded();
}
