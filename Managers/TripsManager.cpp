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


TripsManager::TripsManager(DataBaseStorage& dbStorage, QObject *parent)
    : _dbStorage(dbStorage),
      QObject(parent)
{
    _completedTrips = new QVector<TripData>();
    loadTrips();
}

//==============================================================================

void TripsManager::loadTrips()
{
    _completedTrips->clear();
    retrieveCompletedTrips();
    _activeTrip = retrieveActivetrip();
    _waitingTrip = retrieveWaitingTrip();
}

//==============================================================================

void TripsManager::retrieveCompletedTrips()
{
    QSettings idGenerator;
    QVector<QVariant> completedTripsList = _dbStorage.getCompletedTrips(idGenerator.value("userId").toString());

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

TripData* TripsManager::retrieveActivetrip()
{
    QJsonDocument jsDoc = readJsonData(QStandardPaths::writableLocation(QStandardPaths::DataLocation));
    QJsonObject jsObject = jsDoc.object();

    QJsonValue active = jsObject.value(QString("active"));

    TripData *activeTrip = parseTrip(active);
    return activeTrip;
}

//==============================================================================

TripData* TripsManager::retrieveWaitingTrip()
{
    QJsonDocument jsonDoc = readJsonData(QStandardPaths::writableLocation(QStandardPaths::DataLocation));

    QJsonObject jsObject = jsonDoc.object();
    QJsonValue waiting = jsObject.value(QString("waiting"));

    TripData *waitingTrip = parseTrip(waiting);

    return waitingTrip;
}

//==============================================================================

QJsonDocument TripsManager::readJsonData(const QString &path)
{
    QFile file(path);
    file.open(QFile::ReadOnly | QIODevice::Text);
    QString jsonData = file.readAll();

    QJsonDocument jsonDoc = QJsonDocument::fromJson(jsonData.toUtf8());
    return jsonDoc;
}

//==============================================================================

void TripsManager::writeJsonFile(const QString &path, QJsonDocument &jsonDoc)
{
    QFile file(QStandardPaths::writableLocation(QStandardPaths::DataLocation));
    if(!file.open(QFile::WriteOnly | QFile::Text))
    {
        qDebug() << "not opened";
        return;
    }


    file.write(jsonDoc.toJson());
    file.close();
    loadTrips();
}


//==============================================================================

TripData* TripsManager::parseTrip(QJsonValue &activeTrip)
{
    //    TripData *parsedActiveTrip = new TripData();

    //    QString tripName = activeTrip["name"].toString();
    //    QDateTime depatureDate = QDateTime::fromString(activeTrip["depatureDate"].toString(), "d/M/yyyy");
    //    QVector<QVariant> jsonBackpack = activeTrip["backpack"].toArray().toVariantList().toVector();
    //    QVector<BackPackItem> backpack = parseBackPack(jsonBackpack);

    //    QJsonArray daysArray = activeTrip["tripDays"].toArray();

    //    QVector<TripDay> tripDays = parseTripDays(daysArray);

    //    parsedActiveTrip->name = tripName;
    //    parsedActiveTrip->backPackList = backpack;
    //    parsedActiveTrip->days = tripDays;
    //    parsedActiveTrip->depatureDate = depatureDate;

    //    return parsedActiveTrip;
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

TripData* TripsManager::getActiveTrip()
{
    return _activeTrip;
}

//==============================================================================

TripData* TripsManager::getWaitingTrip()
{
    return _waitingTrip;
}

//==============================================================================

QVector<TripData>* TripsManager::getCompletedTrips()
{
    return _completedTrips;
}

//==============================================================================

void TripsManager::updateTrips()
{
    QJsonDocument jsonDocument;
    QJsonObject rootObject;
    QJsonObject activeTrip = parseTripToJson(_activeTrip);
    QJsonObject waitingTrip = parseTripToJson(_waitingTrip);
    QJsonArray completedTripss = parseCompletedTripsToJson(_completedTrips);

    rootObject.insert("active", activeTrip);
    rootObject.insert("completed", completedTripss);
    rootObject.insert("waiting", waitingTrip);
    jsonDocument.setObject(rootObject);

    writeJsonFile(":/db/assets/UsersData.json", jsonDocument);
}

//==============================================================================

QJsonArray TripsManager::parseCompletedTripsToJson(QVector<TripData> *compTrips)
{
    QJsonArray completedTrips;
    for(int i = 0; i < compTrips->size(); i++)
    {
        QJsonObject compTrip = parseTripToJson(&compTrips->operator[](i));
        completedTrips.push_back(compTrip);
    }
    return completedTrips;
}

//==============================================================================


QJsonObject TripsManager::parseTripToJson(TripData *parsedTrip)
{
    QJsonObject jsonTrip;
    QJsonValue jsonTripName = QJsonValue(parsedTrip->name);
    QJsonValue jsonTripDepatureDate = QJsonValue(parsedTrip->depatureDate.toString("d/M/yyyy"));
    QJsonArray jsonTripDays = parseTripdaysToJson(parsedTrip->days);
    QJsonValue jsonTripBackPackList = parseBackpackListToJson(parsedTrip->backPackList);

    jsonTrip.insert("backpack", jsonTripBackPackList);
    jsonTrip.insert("depatureDate", jsonTripDepatureDate);
    jsonTrip.insert("name", jsonTripName);
    jsonTrip.insert("tripDays", jsonTripDays);

    return jsonTrip;
}

//==============================================================================

QJsonArray TripsManager::parseTripdaysToJson(QVector<TripDay> &days)
{
    QJsonArray tripDays = QJsonValue::fromVariant(QVariant::fromValue(days)).toArray();
    for(int i = 0; i < days.size(); i++)
    {
        QJsonObject obj = parseOneDayDataToJson(days[i]);
        tripDays.push_back(obj);
    }

    return tripDays;
}

//==============================================================================

QJsonObject TripsManager::parseOneDayDataToJson(TripDay &tripDay)
{
    QJsonObject jsonTripDay;

    jsonTripDay.insert("cities", parseDayDataToJson(tripDay.cities));
    jsonTripDay.insert("countries", parseDayDataToJson(tripDay.countries));
    jsonTripDay.insert("notes", parseDayDataToJson(tripDay.notes));
    jsonTripDay.insert("ideas", parseDayDataToJson(tripDay.ideas));
    jsonTripDay.insert("photos", parseDayPhotosToJson(tripDay.photos));

    return jsonTripDay;
}

//==============================================================================

QJsonArray TripsManager::parseDayDataToJson(QVector<QString> &vector)
{
    QJsonArray jsonArray;
    for(int i = 0; i < vector.size(); i++)
    {
        QJsonValue data(vector.at(i));
        jsonArray.push_back(data);
    }
    return jsonArray;
}

//==============================================================================

QJsonArray TripsManager::parseDayPhotosToJson(QVector<Photo> &photos)
{
    QJsonArray jsonArray;
    for(int i = 0; i < photos.size(); i++)
    {
        QJsonObject photo;
        photo.insert("date", QJsonValue(photos[i].timestamp.toString("d/M/yyyy")));
        photo.insert("location", QJsonValue(QString("%1/%2").arg(photos[i].location.country()).arg(photos[i].location.city())));
        photo.insert("source", QJsonValue(photos[i].source));
        jsonArray.push_back(photo);
    }
    return jsonArray;
}

//==============================================================================

QJsonArray TripsManager::parseBackpackListToJson(QVector<BackPackItem> &backpackList)
{
    QJsonArray backpack;
    for(int i = 0; i < backpackList.size(); i++)
    {
        QJsonObject backpackItem;
        backpackItem.insert("isPacked",backpackList.at(i).isPacked);
        backpackItem.insert("name", backpackList.at(i).name);
        backpack.push_back(backpackItem);
    }

    return backpack;
}

//==============================================================================
