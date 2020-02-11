#ifndef TRIPSMANAGER_HPP
#define TRIPSMANAGER_HPP

#include <QObject>
#include "core/Storage/TripData.hpp"
#include <core/Storage/DataBaseStorage.hpp>
#include <core/Services/AuthenticationService.hpp>

class TripsManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVector<TripData>* completedTrips READ getCompletedTrips CONSTANT)
public:
    explicit TripsManager(DataBaseStorage& dbStorage, AuthenticationService &authService, QObject *parent = nullptr);
    TripData*        retrieveWaitingTrip();
    TripData*        retrieveActivetrip();
    void             retrieveCompletedTrips();

    TripData*            getActiveTrip();
    TripData*            getWaitingTrip();
    QVector<TripData>*     getCompletedTrips();

    TripData*           parseTrip(QJsonValue &value);
    QVector<QString>    parseTripDayData(const QVector<QVariant> &jsonVector, QVector<QString> &tripDayVector);
    QVector<Photo>      parsePhotos(const QVector<QVariant> &photosOfDay);
    QVector<BackPackItem> parseBackPack(const QVector<QVariant> &jsonBackpackItems);
    QVector<TripDay>      parseTripDays(const QVector<QVariant> &tripDaysJsonArray);

    QJsonArray          parseDayDataToJson(QVector<QString> &vector);
    QJsonArray          parseDayPhotosToJson(QVector<Photo> &photos);
    QJsonArray          parseTripdaysToJson(QVector<TripDay> &days);
    QJsonArray          parseBackpackListToJson(QVector<BackPackItem> &backpackList);
    QJsonArray          parseCompletedTripsToJson(QVector<TripData>* compTrips);
    QJsonObject         parseTripToJson(TripData *trip);
    QJsonObject         parseOneDayDataToJson(TripDay &tripDay);

    QJsonDocument       readJsonData(const QString &path);
    void                writeJsonFile(const QString &path, QJsonDocument &jsonDoc);

    void updateTrips();
    void loadTrips();

signals:

public slots:

private:
    DataBaseStorage &_dbStorage;
    AuthenticationService &_authService;
    QVector<TripData> *_completedTrips;
    TripData *_activeTrip;
    TripData *_waitingTrip;
};

#endif // TRIPSMANAGER_HPP
