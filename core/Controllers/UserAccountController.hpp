#ifndef USERACCOUNTCONTROLLER_HPP
#define USERACCOUNTCONTROLLER_HPP

#include <QObject>
#include <core/Storage/DataBaseStorage.hpp>
#include <core/Storage/UserInfo.hpp>

class UserAccountController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY userInfoChanged)
    Q_PROPERTY(QString city READ cityResidence WRITE setCity NOTIFY userInfoChanged)
    Q_PROPERTY(QString country READ countryResidence WRITE setCountry NOTIFY userInfoChanged)
public:
    explicit UserAccountController(DataBaseStorage &dbStorage, QObject *parent = nullptr);

    void setName(const QString &newName);
    void setCountry(const QString &newCountry);
    void setCity(const QString &newCity);
    
signals:
    void userInfoChanged();
    void userInfoUpdated();

public slots:
    void saveUserInfo(const QString &fullName, const QString &cityResidence, const QString &countryResidence);

    void updateUserInfo();
    void getUserInfo();

    QString name() const;
    QString cityResidence() const;
    QString countryResidence() const;
    
private:
    DataBaseStorage &_dbStorage;
    UserInfo _userInfo;   
};

#endif // USERACCOUNTCONTROLLER_HPP
