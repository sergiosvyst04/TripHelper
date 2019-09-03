#ifndef TRIPSSTORAGE_HPP
#define TRIPSSTORAGE_HPP

#include <QObject>
#include "core/Models/CompletedTripsModel.hpp"
#include "core/Storage/TripData.hpp"

class TripsStorage : public QObject
{
    Q_OBJECT
public:
    explicit TripsStorage(QObject *parent = nullptr);
    TripData retrieveWaitingTrip();
    TripData* retrieveActivetrip();
    void retrieveCompletedTrips();

    TripData* parseTrip(QJsonValue &value);
    QVector<QString> parseTripDayData(QVector<QVariant> &jsonVector, QVector<QString> &tripDayVector);
    QVector<Photo> parsePhotos(QVector<QVariant> &photosOfDay);
    QList<BackPackItem> parseBackPack(QVector<QVariant> &jsonBackpackItems);
    QJsonDocument readJsonData(const QString &path);
    QList<TripDay> parseTripDays(QJsonArray &tripDaysJsonArray);

    TripData* getActiveTrip();
    TripData& getWaitingTrip();
    CompletedTripsModel* getCompletedTripsModel();
    
signals:

public slots:

private:
    CompletedTripsModel *_completedTripsModel;
    TripData *_activeTrip;
    TripData _waitingTrip;
};

#endif // TRIPSSTORAGE_HPP
