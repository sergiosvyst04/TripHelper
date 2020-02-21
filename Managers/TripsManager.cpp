#include "TripsManager.hpp"
#include "QDebug"
#include "QFile"
#include "QJsonDocument"
#include "QJSValue"
#include "QJsonObject"
#include "QJsonArray"
#include "QDebug"
#include "QStandardPaths"
#include <QSettings>


TripsManager::TripsManager(DataBaseStorage& dbStorage, AuthenticationService &authService, QObject *parent)
    : _dbStorage(dbStorage),
      _authService(authService),
      QObject(parent)
{
    _completedTrips = new QVector<TripData>();

    if(_authService.isSignedIn())
        loadTrips();

    connect(&_authService, &AuthenticationService::signedIn, this, &TripsManager::loadTrips);
}

//==============================================================================

void TripsManager::loadTrips()
{
    _completedTrips->clear();
    retrieveCompletedTrips();

    _uncompletedTrip = new TripData();
    retrieveUncompletedTrip();
}

//==============================================================================

void TripsManager::retrieveCompletedTrips()
{   
    QVector<QVariant> completedTripsList = _dbStorage.getCompletedTrips();

    for(auto compTrip : completedTripsList)
    {
        QVariantMap tripMap = compTrip.toMap();
        TripData trip;
        trip.name = tripMap.value("name").toString();
        trip.backPackList = parseBackPack(tripMap.value("backpack").toList().toVector());
        trip.depatureDate = QDateTime::fromString(tripMap.value("depatureDate").toString(), "d/M/yyyy");
        trip.days = parseTripDays(tripMap.value("tripDays").toList().toVector());
        _completedTrips->push_back(trip);
    }
}

//==============================================================================

void TripsManager::retrieveUncompletedTrip()
{
    QVariantMap uncompletedTripMap = _dbStorage.getUncompletedTrip().toMap();

    _uncompletedTrip->name = uncompletedTripMap.value("name").toString();
    _uncompletedTrip->backPackList = parseBackPack(uncompletedTripMap.value("backpack").toList().toVector());
    _uncompletedTrip->depatureDate = QDateTime::fromString(uncompletedTripMap.value("depatureDate").toString(), "d/M/yyyy");
    _uncompletedTrip->days = parseTripDays(uncompletedTripMap.value("tripDays").toList().toVector());
}

//==============================================================================

QVector<TripDay> TripsManager::parseTripDays(const QVector<QVariant> &tripDays)
{
    QVector<TripDay> tripDaysList;

    for(auto &currentTripDay : tripDays)
    {
        TripDay tripDay;
        QVariantMap currentDayMap = currentTripDay.toMap();

        tripDay.photos = parsePhotos(currentDayMap.value("photos").toList().toVector());
        tripDay.cities = parseTripDayData(currentDayMap.value("cities").toList().toVector(), tripDay.cities);
        tripDay.countries = parseTripDayData(currentDayMap.value("countries").toList().toVector(), tripDay.countries);
        tripDay.notes = parseTripDayData(currentDayMap.value("notes").toList().toVector(), tripDay.notes);
        tripDay.ideas = parseTripDayData(currentDayMap.value("ideas").toList().toVector(), tripDay.ideas);

        tripDaysList.push_back(tripDay);
    }

    return tripDaysList;
}

//==============================================================================

QVector<BackPackItem> TripsManager::parseBackPack(const QVector<QVariant> &jsonBackpackItems)
{
    QVector<BackPackItem> backpackItemslist;
    for(int i = 0; i < jsonBackpackItems.size(); i++)
    {
        QJsonObject jsonBackPackItem = jsonBackpackItems.at(i).toJsonObject();

        bool itemIsPacked = jsonBackPackItem.value("isPacked").toBool();
        QString itemName = jsonBackPackItem.value("name").toString();

        BackPackItem newItem {
            itemIsPacked,
                    itemName
        };
        backpackItemslist.push_back(newItem);
    }

    return backpackItemslist;
}

//==============================================================================

QVector<QString> TripsManager::parseTripDayData(const QVector<QVariant> &jsonVector, QVector<QString> &tripDayVector)
{
    for(int i = 0; i < jsonVector.size(); i++)
        tripDayVector.push_back(jsonVector.at(i).toString());

    return tripDayVector;
}

//==============================================================================

QVector<Photo> TripsManager::parsePhotos(const QVector<QVariant> &photosOfDay)
{
    QVector<Photo> parsedPhotos;
    for(int j = 0; j < photosOfDay.size(); j++)
    {
        QJsonObject jsonPhotoItem = photosOfDay[j].toJsonObject();
        QStringList locaction = jsonPhotoItem.value(QString("location")).toString().split("/");
        QGeoAddress address;

        address.setCountry(locaction.at(0));
        address.setCity(locaction.at(1));

        QString source = jsonPhotoItem.value(QString("source")).toString();
        QDateTime date = QDateTime::fromString(jsonPhotoItem.value(QString("date")).toString(), "d/M/yyyy");
        Photo parsedPhoto {
            source,
                    date,
                    address
        };

        parsedPhotos.push_back(parsedPhoto);
    }

    return parsedPhotos;
}

//==============================================================================


TripData* TripsManager::getUnCompletedTrip()
{
    return _uncompletedTrip;
}

//==============================================================================

QVector<TripData>* TripsManager::getCompletedTrips()
{
    return _completedTrips;
}

//==============================================================================

bool TripsManager::checkIfActiveTripExists()
{
    if(_uncompletedTrip->name == "")
        return false;
    else
        return _uncompletedTrip->depatureDate < QDateTime::currentDateTime();
}

//==============================================================================

bool TripsManager::checkIfWaitingTripExists()
{
    if(_uncompletedTrip->name == "")
        return false;
    else
        return _uncompletedTrip->depatureDate > QDateTime::currentDateTime();
}

//==============================================================================

void TripsManager::updateUncompletedTrip()
{
    QVariantMap uncompletedTripMap = parseTripToVariantMap(_uncompletedTrip);
    _dbStorage.updateUncompletedTrip(uncompletedTripMap);
}

//==============================================================================


QVariantMap TripsManager::parseTripToVariantMap(TripData *trip)
{
    QVariantMap tripMap;

    QVariantList backpack = parseBackpackToVariantList(trip->backPackList);
    QVariantList tripDays = parseTripDaysToVariantList(trip->days);

    tripMap.insert("name", trip->name);
    tripMap.insert("depatureDate", trip->depatureDate.toString("d/M/yyyy"));
    tripMap.insert("backpack", backpack);
    tripMap.insert("tripDays", tripDays);

    return tripMap;
}

//==============================================================================

QVariantList TripsManager::parseBackpackToVariantList(QVector<BackPackItem> backpackList)
{
    QVariantList backpack;
    for(auto &item : backpackList)
    {
        QVariantMap backpackItem;
        backpackItem.insert("isPacked", item.isPacked);
        backpackItem.insert("name", item.name);
        backpack.push_back(backpackItem);
    }
    return backpack;
}

//==============================================================================

QVariantList TripsManager::parseTripDaysToVariantList(QVector<TripDay> days)
{
    QVariantList tripDays;
    for(auto &day : days)
    {
        QVariantMap tripDay;
        tripDay.insert("ideas", parseDayDataToVariantList(day.ideas));
        tripDay.insert("notes", parseDayDataToVariantList(day.notes));
        tripDay.insert("cities", parseDayDataToVariantList(day.cities));
        tripDay.insert("countries", parseDayDataToVariantList(day.countries));
        tripDay.insert("photos", parseDayPhotosToVariantList(day.photos));

        tripDays.push_back(tripDay);
    }
    return tripDays;
}

//==============================================================================

QVariantList TripsManager::parseDayPhotosToVariantList(QVector<Photo> photos)
{
    QVariantList photosList;
    for(auto &photo : photos)
    {
        QVariantMap photoMap;
        photoMap.insert("source", photo.source);
        photoMap.insert("location", QString("%1/%2").arg(photo.location.country()).arg(photo.location.city()));
        photoMap.insert("date", photo.timestamp.toString("d/M/yyyy"));
        photosList.push_back(photoMap);
    }

    return photosList;
}

//==============================================================================

QVariantList TripsManager::parseDayDataToVariantList(QVector<QString> dayData)
{
    QVariantList dayDataVariantList;

    for(auto &dataItem : dayData)
    {
        dayDataVariantList.push_back(dataItem);
    }

    return dayDataVariantList;
}




