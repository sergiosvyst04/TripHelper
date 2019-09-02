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
        //            case TripCurrentLocation:
        //                return QVariant::fromValue<QGeoAddress>(trip.getCurrentLocation());
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
}

//==============================================================================

bool TripsModel::checkIfActiveTripExists()
{
    for(int i =0; i < _trips.size(); i++)
        if(_trips.at(i).getState() == 1)
            return true;
    return false;
}

//==============================================================================

bool TripsModel::checkIfWaitingTripexists()
{
    qDebug() << "checking";
    for(int i =0; i < _trips.size(); i++)
        if(_trips.at(i).getState() == 0)
            return true;
    return false;
}

//==============================================================================

Trip *TripsModel::getWaitingTrip()
{
    qDebug() << "get waiting trip";
    for(int i = 0; i < _trips.size(); i++)
        if(_trips.at(i).getState() == 0)
            return &_trips[i];
    return _trips.empty() ? nullptr : &_trips.last();
}

