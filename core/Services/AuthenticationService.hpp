#ifndef AUTHENTICATIONSERVICE_HPP
#define AUTHENTICATIONSERVICE_HPP

#include <QObject>
#include <QMap>
#include <core/Storage/UserInfo.hpp>
#include <core/Storage/DataBaseStorage.hpp>

class AuthenticationService : public QObject
{
    Q_OBJECT
public:
    explicit AuthenticationService(DataBaseStorage &db ,QObject *parent = nullptr);

    QString userId() const;

signals:
    void userExists(bool exists);
    void userSaved();
    void signedIn();

public slots:
    void saveUser(const QString &email, const QString& password);
    void checkIfUserExists(const QString &email, const QString& password);

    void signIn(const QString &email, const QString &password);
    void signOut();
    bool isSignedIn();

private:
    DataBaseStorage &_dbStorage;
};

#endif // AUTHENTICATIONSERVICE_HPP
