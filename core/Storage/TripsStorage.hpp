#ifndef TRIPSSTORAGE_HPP
#define TRIPSSTORAGE_HPP

#include <QObject>
#include "core/Storage/TripData.hpp"

class TripsStorage : public QObject
{
    Q_OBJECT
public:
    explicit         TripsStorage(QObject *parent = nullptr);
    TripData*        retrieveWaitingTrip();
    TripData*        retrieveActivetrip();
    void             retrieveCompletedTrips();

    TripData*            getActiveTrip();
    TripData*            getWaitingTrip();
    QList<TripData>*     getCompletedTrips();

    TripData*           parseTrip(QJsonValue &value);
    QVector<QString>    parseTripDayData(QVector<QVariant> &jsonVector, QVector<QString> &tripDayVector);
    QVector<Photo>      parsePhotos(QVector<QVariant> &photosOfDay);
    QList<BackPackItem> parseBackPack(QVector<QVariant> &jsonBackpackItems);
    QList<TripDay>      parseTripDays(QJsonArray &tripDaysJsonArray);

    QJsonArray          parseDayDataToJson(QVector<QString> &vector);
    QJsonArray          parseDayPhotosToJson(QVector<Photo> &photos);
    QJsonArray          parseTripdaysToJson(QList<TripDay> &days);
    QJsonArray          parseBackpackListToJson(QList<BackPackItem> &backpackList);
    QJsonArray          parseCompletedTripsToJson(QList<TripData>* compTrips);
    QJsonObject         parseTripToJson(TripData *trip);
    QJsonObject         parseOneDayDataToJson(TripDay &tripDay);

    QJsonDocument       readJsonData(const QString &path);
    void                writeJsonFile(const QString &path, QJsonDocument &jsonDoc);

    void updateTrips();
    void loadTrips();
    
signals:

public slots:

private:
    QList<TripData> *_completedTrips;
    TripData *_activeTrip;
    TripData *_waitingTrip;
};

#endif // TRIPSSTORAGE_HPP
