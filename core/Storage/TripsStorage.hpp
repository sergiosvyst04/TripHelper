#ifndef TRIPSSTORAGE_HPP
#define TRIPSSTORAGE_HPP

#include <QObject>
#include "core/Models/CompletedTripsModel.hpp"
#include "core/Storage/Trip.hpp"
#include "QPointer"
#include "memory"

class TripsStorage : public QObject
{
    Q_OBJECT
public:
    explicit TripsStorage(QObject *parent = nullptr);
    std::unique_ptr<Trip> retrieveWaitingTrip();
    std::unique_ptr<Trip> retrieveActivetrip();
    void retrieveCompletedTrips();

    std::unique_ptr<Trip> parseTrip(QJsonValue &value);
    QVector<QString> parseTripDayData(QVector<QVariant> &jsonVector, QVector<QString> &tripDayVector);
    QVector<Photo> parsePhotos(QVector<QVariant> &photosOfDay);
    QList<BackPackItem> parseBackPack(QVector<QVariant> &jsonBackpackItems);
    QJsonDocument readJsonData(const QString &path);
    QList<TripDay> parseTripDays(QJsonArray &tripDaysJsonArray);

    std::unique_ptr<Trip> getActiveTrip();
    std::unique_ptr<Trip> getWaitingTrip();
    CompletedTripsModel* getCompletedTripsModel();
    
signals:

public slots:

private:
    CompletedTripsModel *_completedTripsModel;
    std::unique_ptr<Trip> _activeTrip;
    std::unique_ptr<Trip> _waitingTrip;
};

#endif // TRIPSSTORAGE_HPP
