#include "DataBaseStorage.hpp"
#include "QJsonArray"
#include "QJsonDocument"
#include "QJsonObject"
#include "QFile"
#include "QVariant"
#include <QDebug>
#include <QCryptographicHash>

DataBaseStorage::DataBaseStorage(QObject *parent) : QObject(parent)
{
    _usersDB = new std::map<QString, UserInfo>;
    readUsers();
}

void DataBaseStorage::readUsers()
{
    QFile file("/home/sergio/Desktop/TripFiles/UsersDB.json");
    file.open(QFile::ReadOnly | QIODevice::Text);
    QString users = file.readAll();

    QJsonDocument jsonDoc = QJsonDocument::fromJson(users.toUtf8());

    QJsonArray jsonArray = jsonDoc.array();
    std::map<QString, UserInfo> usersMap = parseUsersJsonArray(jsonArray);

    for(auto p = usersMap.begin(); p != usersMap.end(); ++p)
    {
        _usersDB->insert(std::pair<QString, UserInfo>(p->first, p->second));
    }

}

std::map<QString, UserInfo> DataBaseStorage::parseUsersJsonArray(QJsonArray &usersArray)
{
    std::map<QString, UserInfo> usersMap;
    for(auto user : usersArray)
    {
        QJsonObject currentUser = user.toObject();
        UserInfo userInfo;

        QVariantMap map = currentUser.toVariantMap();
        QVariantMap currentUserInfo = map.begin().value().toMap();
        QString userId = map.begin().key();

        userInfo.name = currentUserInfo.value("name").toString();
        userInfo.cityResidence = currentUserInfo.value("cityResidence").toString();
        userInfo.countryResidence = currentUserInfo.value("countryResidence").toString();

        usersMap.insert(std::pair<QString, UserInfo>(userId,userInfo));
    }

    return usersMap;
}

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
    writeUsers(jsonDocument);
}

void DataBaseStorage::writeUsers(QJsonDocument &jsonDocument)
{
    QFile file("/home/sergio/Desktop/TripFiles/UsersDB.json");
    file.open(QFile::WriteOnly | QIODevice::Text);
    if(!file.isOpen())
    {
        qDebug() << "NOT OPENED";
    }

    file.write(jsonDocument.toJson());
    file.close();
}

void DataBaseStorage::saveUser(const QString &email, const QString &password)
{
    QByteArray userId = QCryptographicHash::hash(email.toUtf8() + password.toUtf8(), QCryptographicHash::Sha256).toHex();

    _usersDB->insert(std::pair<QString, UserInfo>(userId, UserInfo{
                                                      "",
                                                      "",
                                                      ""
                                                  }));
}

std::map<QString, UserInfo>* DataBaseStorage::getUsersDb() const
{
    return _usersDB;
}

