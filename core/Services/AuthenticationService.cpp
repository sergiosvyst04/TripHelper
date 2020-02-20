#include "AuthenticationService.hpp"
#include "QCryptographicHash"
#include "QDebug"
#include "QFile"
#include "QJsonDocument"
#include "QJsonObject"
#include "QJsonArray"
#include <QVector>
#include <QSettings>
#include <core/Controllers/UserIdController.hpp>


AuthenticationService::AuthenticationService(DataBaseStorage &db ,QObject *parent)
    : QObject(parent),
      _dbStorage(db)
{

}

void AuthenticationService::saveUser(const QString &email, const QString& password)
{
    _dbStorage.saveUser(email, password);

    emit userSaved();
}


void AuthenticationService::checkIfUserExists(const QString &email, const QString& password)
{
    QByteArray userId = QCryptographicHash::hash(email.toUtf8() + password.toUtf8(), QCryptographicHash::Sha256).toHex();
    if(_dbStorage.getUsersDb()->find(userId) != _dbStorage.getUsersDb()->end())
        emit userExists(true);
    else 
        emit userExists(false);
}

bool AuthenticationService::isSignedIn()
{
    return UserIdController::Instance().userId() != "";
}

void AuthenticationService::signOut()
{
    QString id = "";
    UserIdController::Instance().setUserId(id);
}

void AuthenticationService::signIn(const QString &email, const QString &password)
{
   QString userId = QCryptographicHash::hash(email.toUtf8() + password.toUtf8(), QCryptographicHash::Sha256).toHex();

    UserIdController::Instance().setUserId(userId);
    emit signedIn();
}

QString AuthenticationService::userId() const
{
    return UserIdController::Instance().userId();
}


