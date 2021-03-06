#include "DataBaseStorage.hpp"
#include "QJsonArray"
#include "QJsonDocument"
#include "QJsonObject"
#include "QFile"
#include "QVariant"
#include <QDebug>
#include <QCryptographicHash>
#include <QSettings>
#include <core/Controllers/VisitedLocationsController.hpp>
#include <core/Controllers/UserIdController.hpp>



DataBaseStorage::DataBaseStorage(QObject *parent) : QObject(parent)
{
    _usersDB = new std::map<QString, UserInfo>;
    _usersDataDB = new std::map<QString, std::map<QString, QVariant>>;

    readUsers();
    readUsersData();

    connect(this, &DataBaseStorage::usersChanged, this, &DataBaseStorage::updateUsers);
    connect(this, &DataBaseStorage::usersDataChanged, this, &DataBaseStorage::updateUsersData);


}

//==============================================================================

void DataBaseStorage::readUsers()
{
    QFile file("/home/sergio/Desktop/TripFiles/UsersDB.json");
    file.open(QFile::ReadOnly | QIODevice::Text);
    QString users = file.readAll();

    QJsonDocument jsonDoc = QJsonDocument::fromJson(users.toUtf8());

    QJsonArray jsonArray = jsonDoc.array();
    std::map<QString, UserInfo> usersMap = parseUsersJsonArray(jsonArray);

    for(auto p = usersMap.begin(); p != usersMap.end(); ++p)
        _usersDB->insert(std::pair<QString, UserInfo>(p->first, p->second));
}

//==============================================================================

void DataBaseStorage::readUsersData()
{
    QFile file("/home/sergio/Desktop/TripFiles/UsersDataDB.json");
    file.open(QFile::ReadOnly | QIODevice::Text);
    QString usersData = file.readAll();

    QJsonDocument jsonDoc = QJsonDocument::fromJson(usersData.toUtf8());
    qDebug() << "ISARRAY :" << jsonDoc.isArray();
    QJsonArray jsonArray = jsonDoc.array();

    std::map<QString, std::map<QString, QVariant>> usersDataMap = parseUsersDataJsonArray(jsonArray);

    for(auto p = usersDataMap.begin(); p != usersDataMap.end(); ++p)
        _usersDataDB->insert(std::pair<QString, std::map<QString, QVariant>>(p->first, p->second));
}

//==============================================================================

std::map<QString, UserInfo> DataBaseStorage::parseUsersJsonArray(QJsonArray &usersArray)
{
    std::map<QString, UserInfo> usersMap;
    for(auto user : usersArray)
    {
        QJsonObject currentUser = user.toObject();
        UserInfo userInfo;

        QVariantMap map = currentUser.toVariantMap();
        QVariantMap currentUserInfo = map.begin().value().toMap();
        QString userIdy = map.begin().key();

        userInfo.name = currentUserInfo.value("name").toString();
        userInfo.cityResidence = currentUserInfo.value("cityResidence").toString();
        userInfo.countryResidence = currentUserInfo.value("countryResidence").toString();

        usersMap.insert(std::pair<QString, UserInfo>(userIdy,userInfo));
    }

    return usersMap;
}

//==============================================================================

std::map<QString, std::map<QString, QVariant>> DataBaseStorage::parseUsersDataJsonArray(QJsonArray &usersDataArray)
{
    std::map<QString, std::map<QString, QVariant>> usersDataMapToReturn;

    for(auto userDataObject : usersDataArray)
    {
        QJsonObject currentUserDataObject = userDataObject.toObject();
        QVariantMap userDataMap = currentUserDataObject.toVariantMap();

        QString key = userDataMap.begin().key();
        std::map<QString, QVariant> usersWithData = userDataMap.begin().value().toMap().toStdMap();

        usersDataMapToReturn.insert(std::pair<QString, std::map<QString, QVariant>>(key, usersWithData));
    }

    return usersDataMapToReturn;
}

//==============================================================================

void DataBaseStorage::updateUsers()
{
    QJsonDocument jsonDocument;
    QJsonArray  usersJsonArray;

    for(auto p = _usersDB->begin(); p != _usersDB->end(); ++p)
    {
        QVariantMap userInfo;
        QString userId = p->first;
        userInfo.insert("name", p->second.name);
        userInfo.insert("cityResidence", p->second.cityResidence);
        userInfo.insert("countryResidence", p->second.countryResidence);

        QMap<QString, QVariant> user;
        user.insert(userId, userInfo);
        usersJsonArray.push_back(QJsonValue::fromVariant(user));
    }

    jsonDocument.setArray(usersJsonArray);
    writeDataToJsonFile(jsonDocument, "/home/sergio/Desktop/TripFiles/UsersDB.json");

}

//==============================================================================

void DataBaseStorage::updateUsersData()
{
    QJsonDocument jsonDocument;
    QJsonArray usersDataJsonArray;

    for(auto p = _usersDataDB->begin(); p != _usersDataDB->end(); ++p)
    {
        QVariantMap currentDataTypeData;
        QVariantMap usersDataMap;
        QString dataType = p->first;
        auto usersData = p->second;

        for(auto p = usersData.begin(); p != usersData.end(); ++p)
        {
            QString uid = p->first;
            QVariant data = p->second;
            usersDataMap.insert(uid, data);
        }
        currentDataTypeData.insert(dataType, QVariant::fromValue(usersDataMap));
        usersDataJsonArray.push_back(QJsonValue::fromVariant(currentDataTypeData));
    }
    jsonDocument.setArray(usersDataJsonArray);
    writeDataToJsonFile(jsonDocument, "/home/sergio/Desktop/TripFiles/UsersDataDB.json");
    qDebug() << "users data was updated!";
}

//==============================================================================

void DataBaseStorage::writeDataToJsonFile(QJsonDocument &jsonDocument, const QString &path)
{
    QFile file(path);
    file.open(QFile::WriteOnly | QIODevice::Text);
    if(!file.isOpen())
    {
        qDebug() << "NOT OPENED";
    }

    file.write(jsonDocument.toJson());
    file.close();
}

//==============================================================================

void DataBaseStorage::saveUser(const QString &email, const QString &password)
{
    QByteArray usersId = QCryptographicHash::hash(email.toUtf8() + password.toUtf8(), QCryptographicHash::Sha256).toHex();
    QString id = usersId;
    UserIdController::Instance().setUserId(id);

    _usersDB->insert(std::pair<QString, UserInfo>(UserIdController::Instance().userId(), UserInfo{
                                                      "",
                                                      "",
                                                      ""
                                                  }));
    emit usersChanged();
}

//==============================================================================

void DataBaseStorage::saveUserInfo(UserInfo &userInfo)
{
    _usersDB->at(UserIdController::Instance().userId()) = userInfo;

    _usersDataDB->at("completedTrips").insert(std::pair<QString, QVariant>(UserIdController::Instance().userId(), QVariant::fromValue(QVector<QVariant>())));
    _usersDataDB->at("visitedLocations").insert(std::pair<QString, QVariant>(UserIdController::Instance().userId(), QVariant::fromValue(QVector<QVariant>())));
    _usersDataDB->at("goals").insert(std::pair<QString, QVariant>(UserIdController::Instance().userId(), QVariant::fromValue(QVector<QVariant>())));
    _usersDataDB->at("uncompletedTrip").insert(std::pair<QString, QVariant>(UserIdController::Instance().userId(), QVariant()));

    emit usersChanged();
    emit usersDataChanged();
}

//==============================================================================

void DataBaseStorage::updateUserInfo(UserInfo &userInfo)
{
    _usersDB->at(UserIdController::Instance().userId()) = userInfo;
    emit usersChanged();
}


//==============================================================================

std::map<QString, UserInfo>* DataBaseStorage::getUsersDb() const
{
    return _usersDB;
}

//==============================================================================

QVector<QVariant> DataBaseStorage::getCompletedTrips()
{
    qDebug() << "GET : " << UserIdController::Instance().userId();
    return  _usersDataDB->at("completedTrips").at(UserIdController::Instance().userId()).toList().toVector();
}

//==============================================================================

QVariant DataBaseStorage::getUncompletedTrip()
{
    return _usersDataDB->at("uncompletedTrip").at(UserIdController::Instance().userId());
}

//==============================================================================

void DataBaseStorage::addGoal(Goal &goal)
{
    QVariantMap goalToPush;
    goalToPush.insert("countryDestination", QString::fromStdString(goal.country));
    goalToPush.insert("cityDestination", QString::fromStdString(goal.city));
    goalToPush.insert("depatureDate", goal.depatureDate.toString("d/M/yyyy"));

    QVariantList userGoals = _usersDataDB->at("goals").at(UserIdController::Instance().userId()).toList();
    userGoals.append(goalToPush);
    _usersDataDB->at("goals").at(UserIdController::Instance().userId()) = userGoals;

    emit usersDataChanged();
}

//==============================================================================


void DataBaseStorage::addLocation(const Location &location)
{
    QVariantMap locationToPush;
    locationToPush.insert("country", location.country);
    locationToPush.insert("city", location.city);

    QVariantList userLocations = _usersDataDB->at("visitedLocations").at(UserIdController::Instance().userId()).toList();
    userLocations.append(locationToPush);

    _usersDataDB->at("visitedLocations").at(UserIdController::Instance().userId()) = userLocations;
    emit usersDataChanged();
}

//==============================================================================

void DataBaseStorage::updateUncompletedTrip(QVariantMap &trip)
{
    _usersDataDB->at("uncompletedTrip").at(UserIdController::Instance().userId()) = trip;

    emit usersDataChanged();
}

//==============================================================================

QVector<QVariant> DataBaseStorage::getGoals()
{
    return _usersDataDB->at("goals").at(UserIdController::Instance().userId()).toList().toVector();
}

//==============================================================================

QVector<Location> DataBaseStorage::getVisitedLocations()
{
    QVariantList locationsList = _usersDataDB->at("visitedLocations").at(UserIdController::Instance().userId()).toList();
    QVector<Location> visitedLocations;

    for(auto &location : locationsList)
    {
        QVariantMap locationVariantMap = location.toMap();
        Location currentLocation;
        currentLocation.country = locationVariantMap.value("country").toString();
        currentLocation.city = locationVariantMap.value("city").toString();

        visitedLocations.push_back(currentLocation);
    }

    return visitedLocations;
}

//==============================================================================

QVector<Photo> DataBaseStorage::getAllPhotos()
{
    QVector<Photo> photos;
    QVariantList completedTrips = _usersDataDB->at("completedTrips").at(UserIdController::Instance().userId()).toList();

    for(auto &completedTrip : completedTrips)
    {
        QVariantMap currentTrip = completedTrip.toMap();
        QVariantList currentTripDays = currentTrip.value("tripDays").toList();
        for(auto &day : currentTripDays)
        {
            QVariantMap currentDayMap = day.toMap();
            QVariantList photosOfDay = currentDayMap.value("photos").toList();
            for(auto &photo : photosOfDay)
            {
                QVariantMap photoMap = photo.toMap();
                Photo photoItem;

                QGeoAddress address;
                QString source = photoMap.value("source").toString();
                QDateTime timeStamp = QDateTime::fromString(photoMap.value("date").toString(), "d/M/yyyy");
                QStringList addressString = photoMap.value("location").toString().split("/");
                address.setCountry(addressString.at(0));
                address.setCity(addressString.at(1));

                Photo retrievedPhoto;
                retrievedPhoto.source = source;
                retrievedPhoto.timestamp = timeStamp;
                retrievedPhoto.location = address;

                photos.push_back(retrievedPhoto);
            }
        }
    }

    return photos;
}

//==============================================================================

void DataBaseStorage::addCity(const QString &city)
{
    QVariantList usersCities =  _usersDataDB->at("visitedCities").at(UserIdController::Instance().userId()).toList();
    usersCities.push_back(city);
    _usersDataDB->at("visitedCities").at(UserIdController::Instance().userId()) = usersCities;

    emit usersDataChanged();
}

//==============================================================================

void DataBaseStorage::addCountry(const QString &country)
{
    QVariantList usersCountries = _usersDataDB->at("visitedCountries").at(UserIdController::Instance().userId()).toList();
    usersCountries.push_back(country);
    _usersDataDB->at("visitedCountries").at(UserIdController::Instance().userId()) = usersCountries;

    emit usersDataChanged();
}

//==============================================================================

void DataBaseStorage::startNewTrip(TripData &tripData)
{
    QVariantMap tripToBeStarted;
    tripToBeStarted.insert("backpack", QVariant::fromValue(QVector<QVariant>()));
    tripToBeStarted.insert("tripDays",  QVariant::fromValue(QVector<QVariant>()));
    tripToBeStarted.insert("name", tripData.name);
    tripToBeStarted.insert("depatureDate", tripData.depatureDate.toString("d/M/yyyy"));

    _usersDataDB->at("uncompletedTrip").at(UserIdController::Instance().userId()) = tripToBeStarted;
    emit usersDataChanged();
    emit uncompletedTripUpdated();
}

