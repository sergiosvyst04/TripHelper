#ifndef TRIPSMODEL_HPP
#define TRIPSMODEL_HPP

#include <QAbstractListModel>
#include "core/Storage/Trip.hpp"

class TripsModel : public QAbstractListModel
{
    Q_OBJECT

    enum TripRoles {
        TripName = Qt::UserRole + 1,
        TripDepatureDate,
        TripState,
        TripDays,
        TripList,
        TripBackPack,
        TripCurrentLocation
    };

public:
    explicit TripsModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

public slots:
    void addTrip(const QString &name, QDateTime depatureDate);

private:
    QVector <Trip> _trips;
};

#endif // TRIPSMODEL_HPP
