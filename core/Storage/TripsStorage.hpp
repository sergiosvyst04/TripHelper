#ifndef TRIPSSTORAGE_HPP
#define TRIPSSTORAGE_HPP

#include <QObject>
#include "core/Models/CompletedTripsModel.hpp"
#include "core/Storage/Trip.hpp"

class TripsStorage : public QObject
{
    Q_OBJECT
public:
    explicit TripsStorage(QObject *parent = nullptr);
    Trip retrieveWaitingTrip();
    Trip retrieveActivetrip();
    void retrieveCompletedTrips();

    Trip parseTrip(QJsonValue &value);
    QVector<QString> parseTripDayData(QVector<QVariant> &jsonVector, QVector<QString> &tripDayVector);
    QVector<Photo> parsePhotos(QVector<QVariant> &photosOfDay);
    QList<BackPackItem> parseBackPack(QVector<QVariant> &jsonBackpackItems);
    QJsonDocument readJsonData(const QString &path);
    QList<TripDay> parseTripDays(QJsonArray &tripDaysJsonArray);

    Trip& getActiveTrip();
    Trip& getWaitingTrip();
    CompletedTripsModel* getCompletedTripsModel();
    
signals:

public slots:

private:
    CompletedTripsModel *_completedTripsModel;
    Trip _activeTrip;
    Trip _waitingTrip;
};

#endif // TRIPSSTORAGE_HPP
