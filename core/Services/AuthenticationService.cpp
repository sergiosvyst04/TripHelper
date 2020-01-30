#include "AuthenticationService.hpp"
#include "QCryptographicHash"
#include "QDebug"
#include "QFile"
#include "QJsonDocument"
#include "QJsonObject"
#include "QJsonArray"
#include <QList>

AuthenticationService::AuthenticationService(QObject *parent) : QObject(parent)
{
    readUsers();
}

void AuthenticationService::createUser(const QString &email, const QString &password)
{
    QByteArray userId = QCryptographicHash::hash(email.toUtf8() + password.toUtf8(), QCryptographicHash::Sha256).toHex();
    
    _users.insert(QString(userId), UserInfo {
                      "",
                      "",
                      ""
                  });
    
    updateUsers();
}

void AuthenticationService::readUsers()
{
    QFile file("/home/sergio/Desktop/TripFiles/UsersDB.json");
    file.open(QFile::ReadOnly | QIODevice::Text);
    QString users = file.readAll();
    
    QJsonDocument jsonDoc = QJsonDocument::fromJson(users.toUtf8());
    
    QJsonArray jsonArray = jsonDoc.array();
    QMap<QString, UserInfo> usersMap = parseUsersJsonArray(jsonArray);
    
    _users = usersMap;
}

QMap<QString, UserInfo> AuthenticationService::parseUsersJsonArray(const QJsonArray& usersArray)
{
    QMap<QString, UserInfo> usersMap;
    for(auto &&user : usersArray)
    {
        QJsonObject currentUser = user.toObject();
        UserInfo userInfo;
        
        QVariantMap map = currentUser.toVariantMap();
        QVariantMap currentUserInfo = map.begin().value().toMap();
        QString userId = map.begin().key();
        
        userInfo.name = currentUserInfo.value("name").toString();
        userInfo.cityResidence = currentUserInfo.value("cityResidence").toString();
        userInfo.countryResidence = currentUserInfo.value("countryResidence").toString();
        
        usersMap.insert(userId, userInfo);
    }
    
    return usersMap;
}

void AuthenticationService::updateUsers()
{
    QJsonDocument jsonDocument;
    QJsonArray  usersJsonArray;
    
    for(auto p = _users.begin(); p != _users.end(); ++p)
    {
        QVariantMap userInfo;
        QString userId = p.key();
        userInfo.insert("name", p.value().name);
        userInfo.insert("cityResidence", p.value().cityResidence);
        userInfo.insert("countryResidence", p.value().countryResidence);
        
        QMap<QString, QVariant> user;
        user.insert(userId, userInfo);
        usersJsonArray.push_back(QJsonValue::fromVariant(user));
    }
    
    jsonDocument.setArray(usersJsonArray);
    writeUsers(jsonDocument);
}

void AuthenticationService::writeUsers(QJsonDocument& jsonDocument)
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

void AuthenticationService::checkIfUserExists(const QString &email, const QString& password)
{
    QByteArray userId = QCryptographicHash::hash(email.toUtf8() + password.toUtf8(), QCryptographicHash::Sha256).toHex();
    if(_users.contains(userId))
        emit userExists(true);
    else 
        emit userExists(false);
}


