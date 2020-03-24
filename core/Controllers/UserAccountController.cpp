#include "UserAccountController.hpp"
#include "QSettings"
#include "QDebug"
#include "UserIdController.hpp"

extern QSettings settings;

UserAccountController::UserAccountController(DataBaseStorage &dbStorage ,QObject *parent)
    : QObject(parent),
      _dbStorage(dbStorage)
{
    if(UserIdController::Instance().userId() != "")
        getUserInfo();

   connect(this, &UserAccountController::userInfoChanged, this, &UserAccountController::updateUserInfo);


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
    _userInfo = _dbStorage.getUsersDb()->at(UserIdController::Instance().userId());
}

void UserAccountController::setName(const QString &newName)
{
    _userInfo.name = newName;
    emit userInfoChanged();
}

void UserAccountController::setCity(const QString &newCity)
{
    _userInfo.cityResidence = newCity;
    emit userInfoChanged();
}

void UserAccountController::setCountry(const QString &newCountry)
{
    _userInfo.countryResidence = newCountry;
    emit userInfoChanged();
}

void UserAccountController::updateUserInfo()
{
    _dbStorage.updateUserInfo(_userInfo);
    emit userInfoUpdated();
}
