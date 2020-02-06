#ifndef GOALSCONTROLLER_HPP
#define GOALSCONTROLLER_HPP

#include <QObject>
#include <core/Storage/DataBaseStorage.hpp>
#include <core/Storage/Goal.hpp>

class GoalsController : public QObject
{
    Q_OBJECT
public:
    explicit GoalsController(DataBaseStorage &dbStorage ,QObject *parent = nullptr);


signals:
    void goalAdded();

public slots:
    void addGoal(const QString& country, const QString &city, QDateTime departureDate);

private:
    DataBaseStorage &_dbStorage;
};

#endif // GOALSCONTROLLER_HPP
