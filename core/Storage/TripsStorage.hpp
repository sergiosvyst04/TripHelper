//#ifndef TRIPSSTORAGE_HPP
//#define TRIPSSTORAGE_HPP

//#include <QObject>
//#include "core/Storage/TripData.hpp"
//#include <core/Storage/DataBaseStorage.hpp>

//class TripsStorage : public QObject
//{
//    Q_OBJECT
//public:
//    explicit         TripsStorage(DataBaseStorage& dbStorage , QObject *parent = nullptr);
//    TripData*        retrieveWaitingTrip();
//    TripData*        retrieveActivetrip();
//    void             retrieveCompletedTrips();

//    TripData*            getActiveTrip();
//    TripData*            getWaitingTrip();
//    QList<TripData>*     getCompletedTrips();

//    TripData*           parseTrip(QJsonValue &value);
//    QVector<QString>    parseTripDayData(const QList<QVariant> &jsonVector, QVector<QString> &tripDayVector);
//    QVector<Photo>      parsePhotos(const QList<QVariant> &photosOfDay);
//    QList<BackPackItem> parseBackPack(const QList<QVariant> &jsonBackpackItems);
//    QList<TripDay>      parseTripDays(const QList<QVariant> &tripDaysJsonArray);

//    QJsonArray          parseDayDataToJson(QVector<QString> &vector);
//    QJsonArray          parseDayPhotosToJson(QVector<Photo> &photos);
//    QJsonArray          parseTripdaysToJson(QList<TripDay> &days);
//    QJsonArray          parseBackpackListToJson(QList<BackPackItem> &backpackList);
//    QJsonArray          parseCompletedTripsToJson(QList<TripData>* compTrips);
//    QJsonObject         parseTripToJson(TripData *trip);
//    QJsonObject         parseOneDayDataToJson(TripDay &tripDay);

//    QJsonDocument       readJsonData(const QString &path);
//    void                writeJsonFile(const QString &path, QJsonDocument &jsonDoc);

//    void updateTrips();
//    void loadTrips();
    
//signals:

//public slots:

//private:
//    DataBaseStorage &_dbStorage;
//    QList<TripData> *_completedTrips;
//    TripData *_activeTrip;
//    TripData *_waitingTrip;
//};

//#endif // TRIPSSTORAGE_HPP
