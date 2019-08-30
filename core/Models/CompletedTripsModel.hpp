#ifndef COMPLETEDTRIPSMODEL_HPP
#define COMPLETEDTRIPSMODEL_HPP

#include <QAbstractListModel>
#include "core/Storage/Trip.hpp"

class CompletedTripsModel : public QAbstractListModel
{
    Q_OBJECT

    enum CompletedTripItemRole {
        NameRole = Qt::UserRole + 1,
        DepatureDateRole,
        VisitedCountriesRole,
        VisitedCitiesRole,
        TakenPhotosRole,
        IdeasRole
    };

public:
    explicit CompletedTripsModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash <int, QByteArray> roleNames() const override;

    void getCompletedTrips(QList<Trip> completedTrips);

private:
    QList<Trip> _completedTrips;
};

#endif // COMPLETEDTRIPSMODEL_HPP
