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

void GoalsModel::addGoal(const QString &country, const QString &city, QDateTime depatureDate)
{
    depatureDate.setTime(QTime(0,0));
    Goal newGoal {
        country.toStdString(),
                city.toStdString(),
                depatureDate
    };

    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    _goals.push_back(newGoal);
    endInsertRows();

    emit goalAdded();
}

//==============================================================================



