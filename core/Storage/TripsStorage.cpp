//#include "TripsStorage.hpp"
//#include "QFile"
//#include "QJsonDocument"
//#include "QJSValue"
//#include "QJsonObject"
//#include "QJsonArray"
//#include "QDebug"
//#include "QStandardPaths"
//#include <QSettings>


//TripsStorage::TripsStorage(DataBaseStorage& dbStorage ,QObject *parent)
//    : _dbStorage(dbStorage),
//      QObject(parent)
//{
//    _completedTrips = new QList<TripData>();
//    loadTrips();
//}

////==============================================================================

//void TripsStorage::loadTrips()
//{
//    _completedTrips->clear();
//    retrieveCompletedTrips();
//    _activeTrip = retrieveActivetrip();
//    _waitingTrip = retrieveWaitingTrip();
//}

////==============================================================================

//void TripsStorage::retrieveCompletedTrips()
//{
//    QSettings idGenerator;
//    QList<QVariant> completedTripsList = _dbStorage.getCompletedTrips(idGenerator.value("userId").toString());

//    for(auto compTrip : completedTripsList)
//    {
//        QVariantMap tripMap = compTrip.toMap();
//        TripData trip;
//        trip.name = tripMap.value("name").toString();
//        trip.backPackList = parseBackPack(tripMap.value("backpack").toList());
//        trip.depatureDate = QDateTime::fromString(tripMap.value("depatureDate").toString(), "d/M/yyyy");
//        trip.days = parseTripDays(tripMap.value("tripDays").toList());
//        _completedTrips->push_back(trip);
//    }
//}

////==============================================================================

//TripData* TripsStorage::retrieveActivetrip()
//{
//    QJsonDocument jsDoc = readJsonData(QStandardPaths::writableLocation(QStandardPaths::DataLocation));
//    QJsonObject jsObject = jsDoc.object();
    
//    QJsonValue active = jsObject.value(QString("active"));
    
//    TripData *activeTrip = parseTrip(active);
//    return activeTrip;
//}

////==============================================================================

//TripData* TripsStorage::retrieveWaitingTrip()
//{
//    QJsonDocument jsonDoc = readJsonData(QStandardPaths::writableLocation(QStandardPaths::DataLocation));
    
//    QJsonObject jsObject = jsonDoc.object();
//    QJsonValue waiting = jsObject.value(QString("waiting"));
    
//    TripData *waitingTrip = parseTrip(waiting);
    
//    return waitingTrip;
//}

////==============================================================================

//QJsonDocument TripsStorage::readJsonData(const QString &path)
//{
//    QFile file(path);
//    file.open(QFile::ReadOnly | QIODevice::Text);
//    QString jsonData = file.readAll();
    
//    QJsonDocument jsonDoc = QJsonDocument::fromJson(jsonData.toUtf8());
//    return jsonDoc;
//}

////==============================================================================

//void TripsStorage::writeJsonFile(const QString &path, QJsonDocument &jsonDoc)
//{
//    QFile file(QStandardPaths::writableLocation(QStandardPaths::DataLocation));
//    if(!file.open(QFile::WriteOnly | QFile::Text))
//    {
//        qDebug() << "not opened";
//        return;
//    }
    
    
//    file.write(jsonDoc.toJson());
//    file.close();
//    loadTrips();
//}


////==============================================================================

//TripData* TripsStorage::parseTrip(QJsonValue &activeTrip)
//{
//    //    TripData *parsedActiveTrip = new TripData();
    
//    //    QString tripName = activeTrip["name"].toString();
//    //    QDateTime depatureDate = QDateTime::fromString(activeTrip["depatureDate"].toString(), "d/M/yyyy");
//    //    QVector<QVariant> jsonBackpack = activeTrip["backpack"].toArray().toVariantList().toVector();
//    //    QList<BackPackItem> backpack = parseBackPack(jsonBackpack);
    
//    //    QJsonArray daysArray = activeTrip["tripDays"].toArray();
    
//    //    QList<TripDay> tripDays = parseTripDays(daysArray);
    
//    //    parsedActiveTrip->name = tripName;
//    //    parsedActiveTrip->backPackList = backpack;
//    //    parsedActiveTrip->days = tripDays;
//    //    parsedActiveTrip->depatureDate = depatureDate;
    
//    //    return parsedActiveTrip;
//}

////==============================================================================

//QList<TripDay> TripsStorage::parseTripDays(const QList<QVariant> &tripDays)
//{
//    QList<TripDay> tripDaysList;
    
//    for(auto &currentTripDay : tripDays)
//    {
//        TripDay tripDay;
//        QVariantMap currentDayMap = currentTripDay.toMap();

//        tripDay.photos = parsePhotos(currentDayMap.value("photos").toList());
//        tripDay.cities = parseTripDayData(currentDayMap.value("cities").toList(), tripDay.cities);
//        tripDay.countries = parseTripDayData(currentDayMap.value("countries").toList(), tripDay.countries);
//        tripDay.notes = parseTripDayData(currentDayMap.value("notes").toList(), tripDay.notes);
//        tripDay.ideas = parseTripDayData(currentDayMap.value("ideas").toList(), tripDay.ideas);
        
//        tripDaysList.push_back(tripDay);
//    }
    
//    return tripDaysList;
//}

////==============================================================================

//QList<BackPackItem> TripsStorage::parseBackPack(const QList<QVariant> &jsonBackpackItems)
//{
//    QList<BackPackItem> backpackItemslist;
//    for(int i = 0; i < jsonBackpackItems.size(); i++)
//    {
//        QJsonObject jsonBackPackItem = jsonBackpackItems.at(i).toJsonObject();
        
//        bool itemIsPacked = jsonBackPackItem.value("isPacked").toBool();
//        QString itemName = jsonBackPackItem.value("name").toString();
        
//        BackPackItem newItem {
//            itemIsPacked,
//                    itemName
//        };
//        backpackItemslist.push_back(newItem);
//    }
    
//    return backpackItemslist;
//}

////==============================================================================

//QVector<QString> TripsStorage::parseTripDayData(const QList<QVariant> &jsonVector, QVector<QString> &tripDayVector)
//{
//    for(int i = 0; i < jsonVector.size(); i++)
//        tripDayVector.push_back(jsonVector.at(i).toString());
    
//    return tripDayVector;
//}

////==============================================================================

//QVector<Photo> TripsStorage::parsePhotos(const QList<QVariant> &photosOfDay)
//{
//    QVector<Photo> parsedPhotos;
//    for(int j = 0; j < photosOfDay.size(); j++)
//    {
//        QJsonObject jsonPhotoItem = photosOfDay[j].toJsonObject();
//        QStringList locaction = jsonPhotoItem.value(QString("location")).toString().split("/");
//        QGeoAddress address;
        
//        address.setCountry(locaction.at(0));
//        address.setCity(locaction.at(1));
        
//        QString source = jsonPhotoItem.value(QString("source")).toString();
//        QDateTime date = QDateTime::fromString(jsonPhotoItem.value(QString("date")).toString(), "d/M/yyyy");
//        Photo parsedPhoto {
//            source,
//                    date,
//                    address
//        };
        
//        parsedPhotos.push_back(parsedPhoto);
//    }
    
//    return parsedPhotos;
//}

////==============================================================================

//TripData* TripsStorage::getActiveTrip()
//{
//    return _activeTrip;
//}

////==============================================================================

//TripData* TripsStorage::getWaitingTrip()
//{
//    return _waitingTrip;
//}

////==============================================================================

//QList<TripData>* TripsStorage::getCompletedTrips()
//{
//    return _completedTrips;
//}

////==============================================================================

//void TripsStorage::updateTrips()
//{
//    QJsonDocument jsonDocument;
//    QJsonObject rootObject;
//    QJsonObject activeTrip = parseTripToJson(_activeTrip);
//    QJsonObject waitingTrip = parseTripToJson(_waitingTrip);
//    QJsonArray completedTripss = parseCompletedTripsToJson(_completedTrips);
    
//    rootObject.insert("active", activeTrip);
//    rootObject.insert("completed", completedTripss);
//    rootObject.insert("waiting", waitingTrip);
//    jsonDocument.setObject(rootObject);
    
//    writeJsonFile(":/db/assets/UsersData.json", jsonDocument);
//}

////==============================================================================

//QJsonArray TripsStorage::parseCompletedTripsToJson(QList<TripData> *compTrips)
//{
//    QJsonArray completedTrips;
//    for(int i = 0; i < compTrips->size(); i++)
//    {
//        QJsonObject compTrip = parseTripToJson(&compTrips->operator[](i));
//        completedTrips.push_back(compTrip);
//    }
//    return completedTrips;
//}

////==============================================================================


//QJsonObject TripsStorage::parseTripToJson(TripData *parsedTrip)
//{
//    QJsonObject jsonTrip;
//    QJsonValue jsonTripName = QJsonValue(parsedTrip->name);
//    QJsonValue jsonTripDepatureDate = QJsonValue(parsedTrip->depatureDate.toString("d/M/yyyy"));
//    QJsonArray jsonTripDays = parseTripdaysToJson(parsedTrip->days);
//    QJsonValue jsonTripBackPackList = parseBackpackListToJson(parsedTrip->backPackList);
    
//    jsonTrip.insert("backpack", jsonTripBackPackList);
//    jsonTrip.insert("depatureDate", jsonTripDepatureDate);
//    jsonTrip.insert("name", jsonTripName);
//    jsonTrip.insert("tripDays", jsonTripDays);
    
//    return jsonTrip;
//}

////==============================================================================

//QJsonArray TripsStorage::parseTripdaysToJson(QList<TripDay> &days)
//{
//    QJsonArray tripDays = QJsonValue::fromVariant(QVariant::fromValue(days)).toArray();
//    for(int i = 0; i < days.size(); i++)
//    {
//        QJsonObject obj = parseOneDayDataToJson(days[i]);
//        tripDays.push_back(obj);
//    }
    
//    return tripDays;
//}

////==============================================================================

//QJsonObject TripsStorage::parseOneDayDataToJson(TripDay &tripDay)
//{
//    QJsonObject jsonTripDay;
    
//    jsonTripDay.insert("cities", parseDayDataToJson(tripDay.cities));
//    jsonTripDay.insert("countries", parseDayDataToJson(tripDay.countries));
//    jsonTripDay.insert("notes", parseDayDataToJson(tripDay.notes));
//    jsonTripDay.insert("ideas", parseDayDataToJson(tripDay.ideas));
//    jsonTripDay.insert("photos", parseDayPhotosToJson(tripDay.photos));
    
//    return jsonTripDay;
//}

////==============================================================================

//QJsonArray TripsStorage::parseDayDataToJson(QVector<QString> &vector)
//{
//    QJsonArray jsonArray;
//    for(int i = 0; i < vector.size(); i++)
//    {
//        QJsonValue data(vector.at(i));
//        jsonArray.push_back(data);
//    }
//    return jsonArray;
//}

////==============================================================================

//QJsonArray TripsStorage::parseDayPhotosToJson(QVector<Photo> &photos)
//{
//    QJsonArray jsonArray;
//    for(int i = 0; i < photos.size(); i++)
//    {
//        QJsonObject photo;
//        photo.insert("date", QJsonValue(photos[i].timestamp.toString("d/M/yyyy")));
//        photo.insert("location", QJsonValue(QString("%1/%2").arg(photos[i].location.country()).arg(photos[i].location.city())));
//        photo.insert("source", QJsonValue(photos[i].source));
//        jsonArray.push_back(photo);
//    }
//    return jsonArray;
//}

////==============================================================================

//QJsonArray TripsStorage::parseBackpackListToJson(QList<BackPackItem> &backpackList)
//{
//    QJsonArray backpack;
//    for(int i = 0; i < backpackList.size(); i++)
//    {
//        QJsonObject backpackItem;
//        backpackItem.insert("isPacked",backpackList.at(i).isPacked);
//        backpackItem.insert("name", backpackList.at(i).name);
//        backpack.push_back(backpackItem);
//    }
    
//    return backpack;
//}

////==============================================================================
