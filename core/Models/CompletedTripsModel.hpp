#ifndef COMPLETEDTRIPSMODEL_HPP
#define COMPLETEDTRIPSMODEL_HPP

#include <QAbstractListModel>
#include "core/Storage/Trip.hpp"
#include "core/Storage/TripData.hpp"
#include "core/Models/BackPackModel.hpp"
#include "core/Controllers/ApplicationController.hpp"

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
public slots:
    void getCompletedTrips(ApplicationController *applicationController);
    void addTrip(const TripData &completedTrip);

private:
    QVector<TripData> _completedTrips;
};

#endif // COMPLETEDTRIPSMODEL_HPP
