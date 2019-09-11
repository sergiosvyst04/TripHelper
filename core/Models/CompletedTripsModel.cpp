#include "CompletedTripsModel.hpp"
#include "QDebug"
#include "core/Controllers/ApplicationController.hpp"

CompletedTripsModel::CompletedTripsModel(QObject *parent)
    : QAbstractListModel(parent)
{

}

//==============================================================================

int CompletedTripsModel::rowCount(const QModelIndex &parent) const
{
    return _completedTrips.size();
}

//==============================================================================

QVariant CompletedTripsModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    const auto &completedTrip = new Trip( new TripData (_completedTrips.at(index.row())));


    switch (role) {
    case NameRole:
        return completedTrip->getName();
    case DepatureDateRole:
        return completedTrip->getDepatureDate();
    case VisitedCitiesRole:
        return completedTrip->getAllCities().size();
    case VisitedCountriesRole:
        return  QVariant::fromValue(completedTrip->getAllCountries());
    case TakenPhotosRole:
        return completedTrip->getAllPhotos().size();
    case IdeasRole:
        return completedTrip->getAllIdeas().size();
    }

    return QVariant();
}

//==============================================================================

QHash<int, QByteArray> CompletedTripsModel::roleNames() const
{
    static QHash<int, QByteArray> roleNames {
        { NameRole, "name"},
        { DepatureDateRole, "depatureDate" },
        { VisitedCountriesRole, "visitedCountries" },
        { VisitedCitiesRole, "visitedCities" },
        { TakenPhotosRole, "takenPhotos" },
        { IdeasRole, "ideas" }
    };
    return roleNames;
}

//==============================================================================

void CompletedTripsModel::getCompletedTrips(QList<TripData> completedTrips)
{
    beginResetModel();
    _completedTrips = completedTrips;
    endResetModel();
}

//==============================================================================

void CompletedTripsModel::addTrip(const TripData &completedTrip)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    _completedTrips.push_back(completedTrip);
    endInsertRows();
}

//==============================================================================
