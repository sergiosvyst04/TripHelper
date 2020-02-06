#include "GoalsModel.hpp"
#include <QDebug>
#include <QDateTime>

GoalsModel::GoalsModel(QObject *parent)
    : QAbstractListModel(parent)
{

}

//==============================================================================

int GoalsModel::rowCount(const QModelIndex &) const
{
    return _goals.size();
}

//==============================================================================

QVariant GoalsModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= _goals.size())
        return QVariant();

    const auto &goal = _goals.at(index.row());

    switch (role) {
    case CountryRole:
        return QString::fromStdString(goal.country);
    case CityRole:
        return QString::fromStdString(goal.city);
    case DepatureDate:
        return goal.depatureDate;

    }

    return QVariant();
}

//==============================================================================

QHash<int, QByteArray> GoalsModel::roleNames() const
{
    static QHash<int, QByteArray> roleNames {
        { CountryRole, "country"},
        { CityRole, "city"},
        { DepatureDate, "depatureDate"}
    };
    return roleNames;
}

//==============================================================================

void GoalsModel::readGoals()
{
    QList<QVariant> goals = _dbStorage->getGoals();

    for(auto &goal : goals)
    {
        QVariantMap goalMap = goal.toMap();
        Goal currentGoal;
        currentGoal.city = goalMap.value("cityDestination").toString().toStdString();
        currentGoal.country = goalMap.value("countryDestination").toString().toStdString();
        currentGoal.depatureDate = QDateTime::fromString(goalMap.value("depatureDate").toString(), "d/M/yyyy");
        _goals.push_back(currentGoal);
    }
}

//==============================================================================

void GoalsModel::intialize(ApplicationController *applicationController)
{
    _dbStorage = &applicationController->getDatabase();
    readGoals();
}


