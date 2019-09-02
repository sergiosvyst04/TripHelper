#include "TripsStorage.hpp"
#include "QFile"
#include "QJsonDocument"
#include "QJSValue"
#include "QJsonObject"
#include "QJsonArray"
#include "QDebug"
#include "memory"


TripsStorage::TripsStorage(QObject *parent) : QObject(parent)
{  
    _completedTripsModel = new CompletedTripsModel();

    retrieveCompletedTrips();
    _waitingTrip = std::unique_ptr<Trip>(retrieveWaitingTrip().get());
    _activeTrip = std::unique_ptr<Trip>(retrieveActivetrip().get());
}

//==============================================================================

void TripsStorage::retrieveCompletedTrips()
{
    QJsonDocument jsonDocument = readJsonData("/home/sergio/projects/Triphelper/Data/UsersInfo.json");
    QJsonObject jsonObject = jsonDocument.object();

    QJsonValue completed = jsonObject.value(QString("completed"));
    QJsonArray jsonTripsVector = completed.toArray();

    QList<Trip> tripsList;
    for(int i = 0; i < jsonTripsVector.size(); i++)
    {
        QJsonValue compTrip = jsonTripsVector.at(i);
        std::unique_ptr<Trip> completedTrip = parseTrip(compTrip);
        tripsList.push_back(*completedTrip);
    }

    _completedTripsModel->getCompletedTrips(tripsList);
}

//==============================================================================

std::unique_ptr<Trip> TripsStorage::retrieveActivetrip()
{
    QJsonDocument jsDoc = readJsonData("/home/sergio/projects/Triphelper/Data/UsersInfo.json");
    QJsonObject jsObject = jsDoc.object();

    QJsonValue active = jsObject.value(QString("active"));
    std::unique_ptr<Trip> activeTrip = parseTrip(active);

    return activeTrip;
}

//==============================================================================

std::unique_ptr<Trip> TripsStorage::retrieveWaitingTrip()
{
    QJsonDocument jsonDoc = readJsonData("/home/sergio/projects/Triphelper/Data/UsersInfo.json");

    QJsonObject jsObject = jsonDoc.object();
    QJsonValue waiting = jsObject.value(QString("waiting"));

    std::unique_ptr<Trip> waitingTrip = parseTrip(waiting);

    return waitingTrip;
}

//==============================================================================

QJsonDocument TripsStorage::readJsonData(const QString &path)
{
    QFile file(path);
    file.open(QFile::ReadOnly | QIODevice::Text);
    QString jsonData = file.readAll();
    QJsonDocument jsonDoc = QJsonDocument::fromJson(jsonData.toUtf8());

    return jsonDoc;
}

//==============================================================================

std::unique_ptr<Trip> TripsStorage::parseTrip(QJsonValue &activeTrip)
{
    std::unique_ptr<Trip> parsedActiveTrip;

    QString tripName = activeTrip["name"].toString();
    QDateTime depatureDate = QDateTime::fromString(activeTrip["depatureDate"].toString(), "d/M/yyyy");
    QVector<QVariant> jsonBackpack = activeTrip["backpack"].toArray().toVariantList().toVector();
    QList<BackPackItem> backpack = parseBackPack(jsonBackpack);

    QJsonArray daysArray = activeTrip["tripDays"].toArray();

    QList<TripDay> tripDays = parseTripDays(daysArray);

    parsedActiveTrip.get()->setBackPackList(backpack);
    parsedActiveTrip.get()->setDays(tripDays);
    parsedActiveTrip.get()->setName(tripName);
    parsedActiveTrip.get()->setDepatureDate(depatureDate);

    return parsedActiveTrip;
}

//==============================================================================

QList<TripDay> TripsStorage::parseTripDays(QJsonArray &tripDaysJsonArray)
{
    QList<TripDay> tripDays;

    for(int i = 0; i < tripDaysJsonArray.size(); i++)
    {
        TripDay tripDay;

        QVector<QVariant> photosOfDay = tripDaysJsonArray.at(i)["photos"].toArray().toVariantList().toVector();
        tripDay.photos = parsePhotos(photosOfDay);

        QVector<QVariant> citiesOfDay = tripDaysJsonArray.at(i)["cities"].toArray().toVariantList().toVector();
        tripDay.cities = parseTripDayData(citiesOfDay, tripDay.cities);

        QVector<QVariant> countriessOfDay = tripDaysJsonArray.at(i)["countries"].toArray().toVariantList().toVector();
        tripDay.countries = parseTripDayData(countriessOfDay, tripDay.countries);

        QVector<QVariant> notesOfDay = tripDaysJsonArray.at(i)["notes"].toArray().toVariantList().toVector();
        tripDay.notes = parseTripDayData(notesOfDay, tripDay.notes);

        QVector<QVariant> ideasOfDay = tripDaysJsonArray.at(i)["ideas"].toArray().toVariantList().toVector();
        tripDay.ideas = parseTripDayData(ideasOfDay, tripDay.ideas);

        tripDays.push_back(tripDay);
    }

    return tripDays;
}

//==============================================================================

QList<BackPackItem> TripsStorage::parseBackPack(QVector<QVariant> &jsonBackpackItems)
{
    QList<BackPackItem> backpackItemslist;
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

QVector<QString> TripsStorage::parseTripDayData(QVector<QVariant> &jsonVector, QVector<QString> &tripDayVector)
{
    for(int i = 0; i < jsonVector.size(); i++)
        tripDayVector.push_back(jsonVector.at(i).toString());

    return tripDayVector;
}

//==============================================================================

QVector<Photo> TripsStorage::parsePhotos(QVector<QVariant> &photosOfDay)
{
    QVector<Photo> parsedPhotos;
    for(int j = 0; j < photosOfDay.size(); j++)
    {
        QJsonObject jsonPhotoItem = photosOfDay[j].toJsonObject();
        QStringList locaction = jsonPhotoItem.value(QString("location")).toString().split("/");
        QGeoAddress address;

        address.setCounty(locaction.at(0));
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

std::unique_ptr<Trip> TripsStorage::getActiveTrip()
{
    return std::unique_ptr<Trip>(_activeTrip.get());
}

//==============================================================================

std::unique_ptr<Trip> TripsStorage::getWaitingTrip()
{
    return std::unique_ptr<Trip>(_waitingTrip.get());
}

//==============================================================================

CompletedTripsModel* TripsStorage::getCompletedTripsModel()
{
    return _completedTripsModel;
}
