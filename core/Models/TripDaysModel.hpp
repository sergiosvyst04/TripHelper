#ifndef TRIPDAYSMODEL_HPP
#define TRIPDAYSMODEL_HPP

#include <QAbstractListModel>
#include "core/Storage/TripDay.hpp"

class TripDaysModel : public QAbstractListModel
{
    Q_OBJECT

    enum TripDayRole {
        PhotosOfDayRole = Qt::UserRole + 1,
        NotesOfDayRole,
        IdeasOfDayRole,
        CitiesOfDayRole,
        CountriesOfDayRole
    };

public:
    explicit TripDaysModel(QObject *parent = nullptr);

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash <int, QByteArray> roleNames() const override;
    void getDays(QList <TripDay> tripDays);

private:
    QList<TripDay> _days;
};

#endif // TRIPDAYSMODEL_HPP
