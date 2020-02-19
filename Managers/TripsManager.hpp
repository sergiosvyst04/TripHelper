#ifndef TRIPSMANAGER_HPP
#define TRIPSMANAGER_HPP

#include <QObject>
#include "core/Storage/TripData.hpp"
#include <core/Storage/DataBaseStorage.hpp>
#include <core/Services/AuthenticationService.hpp>
#include <core/Storage/Trip.hpp>

class TripsManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVector<TripData>* completedTrips READ getCompletedTrips CONSTANT)
public:
    explicit TripsManager(DataBaseStorage& dbStorage, AuthenticationService &authService, QObject *parent = nullptr);
    void                  retrieveUncompletedTrip();
    void                  retrieveCompletedTrips();

    TripData*             getUnCompletedTrip();
    QVector<TripData>*    getCompletedTrips();

    TripData*             parseTrip(QJsonValue &value);
    QVector<QString>      parseTripDayData(const QVector<QVariant> &jsonVector, QVector<QString> &tripDayVector);
    QVector<Photo>        parsePhotos(const QVector<QVariant> &photosOfDay);
    QVector<BackPackItem> parseBackPack(const QVector<QVariant> &jsonBackpackItems);
    QVector<TripDay>      parseTripDays(const QVector<QVariant> &tripDaysJsonArray);

    QVariantMap           parseTripToVariantMap(TripData *trip);
    QVariantList          parseBackpackToVariantList(QVector<BackPackItem> backpackList);
    QVariantList          parseTripDaysToVariantList(QVector<TripDay> days);
    QVariantList          parseDayPhotosToVariantList(QVector<Photo> photos);
    QVariantList          parseDayDataToVariantList(QVector<QString> dayData);

    void                  updateUncompletedTrip();
    void                  loadTrips();
signals:

public slots:
    bool checkIfActiveTripExists();
    bool checkIfWaitingTripExists();

private:
    DataBaseStorage &_dbStorage;
    AuthenticationService &_authService;
    QVector<TripData> *_completedTrips;
    TripData *_uncompletedTrip;
};

#endif // TRIPSMANAGER_HPP
