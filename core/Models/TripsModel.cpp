#include "TripsModel.hpp"
#include <QDebug>

TripsModel::TripsModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

//==============================================================================

int TripsModel::rowCount(const QModelIndex &parent) const
{
       return _trips.size();
}

//==============================================================================

QVariant TripsModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();
    
    const auto &trip = _trips.at(index.row());
    
    
    switch (role) {
    case TripName:
        return  trip.getName();
    case TripDepatureDate:
        return trip.getDepatureDate();
    case TripState:
        return trip.getState();
    case TripDays:
        return QVariant::fromValue<QList<TripDay>>(trip.getDays());
    case TripList:
        return QVariant::fromValue(trip.getList());
    case TripBackPack:
        return QVariant::fromValue(trip.getBackPack());
    case TripCurrentLocation:
        return QVariant::fromValue<QGeoAddress>(trip.getCurrentLocation());
    }
    
    return QVariant();
}

//==============================================================================

QHash <int, QByteArray> TripsModel::roleNames() const
{
    static QHash<int, QByteArray> roleNames {
        { TripName, "name"},
        { TripDepatureDate, "depatureDate"},
        { TripState, "state"},
        { TripDays, "days"},
        { TripList, "list"},
        { TripBackPack, "backpack"},
        { TripCurrentLocation, "currentLocation"}
    };
    return roleNames;
}

//==============================================================================

void TripsModel::addTrip(const QString &name, QDateTime depatureDate)
{
    Trip newTrip(name, depatureDate);

    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    _trips.push_back(newTrip);
    endInsertRows();
    qDebug() << _trips.size();
}

//==============================================================================

