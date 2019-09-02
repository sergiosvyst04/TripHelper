#include "TripDaysModel.hpp"

TripDaysModel::TripDaysModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

//==============================================================================

int TripDaysModel::rowCount(const QModelIndex &parent) const
{
   return _days.size();
}

QHash <int, QByteArray> TripDaysModel::roleNames() const
{
    static QHash<int, QByteArray> roleNames {
        {PhotosOfDayRole, "photos"},
        {NotesOfDayRole, "notes"},
        {IdeasOfDayRole, "ideas"},
        {CitiesOfDayRole, "cities"},
        {CountriesOfDayRole, "clountries"}
    };

    return roleNames;
}

//==============================================================================

QVariant TripDaysModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    const auto &day = _days.at(index.row());

    switch(role){
    case PhotosOfDayRole:
        return QVariant::fromValue(day.photos);
    case NotesOfDayRole:
        return QVariant::fromValue(day.notes);
    case IdeasOfDayRole:
        return QVariant::fromValue(day.ideas);
    case CitiesOfDayRole:
        return QVariant::fromValue(day.cities);
    case CountriesOfDayRole:
        return QVariant::fromValue(day.countries);
    }

    return QVariant();
}

//==============================================================================

void TripDaysModel::getDays(QList<TripDay> tripDays)
{
    _days = tripDays;
}
