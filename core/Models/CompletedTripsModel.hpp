#ifndef COMPLETEDTRIPSMODEL_HPP
#define COMPLETEDTRIPSMODEL_HPP

#include <QAbstractListModel>
#include "Storage/Trip.hpp"
#include "Storage/TripData.hpp"
#include "Models/BackPackModel.hpp"
#include "Controllers/ApplicationController.hpp"

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
