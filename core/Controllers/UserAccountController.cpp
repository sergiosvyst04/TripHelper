#include "UserAccountController.hpp"
#include "QSettings"
#include "QDebug"

extern QSettings settings;

UserAccountController::UserAccountController(DataBaseStorage &dbStorage ,QObject *parent)
    : QObject(parent),
      _dbStorage(dbStorage)
{
    if(settings.value("userId") != "")
        getUserInfo();
}

void UserAccountController::saveUserInfo(const QString &fullName, const QString &cityResidence, const QString &countryResidence)
{
    _userInfo.name = fullName;
    _userInfo.cityResidence = cityResidence;
    _userInfo.countryResidence = countryResidence;

     _dbStorage.saveUserInfo(_userInfo);
}

QString UserAccountController::name() const
{
    return _userInfo.name;
}

QString UserAccountController::cityResidence() const
{
    return _userInfo.cityResidence;
}

QString UserAccountController::countryResidence() const
{
    return _userInfo.countryResidence;
}

void UserAccountController::getUserInfo()
{
    QString userId = settings.value("userId").toString();
    _userInfo = _dbStorage.getUsersDb()->at(userId);
}

void UserAccountController::setName(const QString &newName)
{
    _userInfo.name = newName;
    emit nameChanged();
}

void UserAccountController::setCity(const QString &newCity)
{
    _userInfo.cityResidence = newCity;
    emit cityChanged();
}

void UserAccountController::setCountry(const QString &newCountry)
{
    _userInfo.countryResidence = newCountry;
    emit countryChanged();
}
