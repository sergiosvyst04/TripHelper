#ifndef AUTHENTICATIONSERVICE_HPP
#define AUTHENTICATIONSERVICE_HPP

#include <QObject>
#include <QMap>
#include <Storage/UserInfo.hpp>
#include <Storage/DataBaseStorage.hpp>
#include <Services/AuthenticationProvider.h>

class AuthenticationService : public AuthenticationProvider
{
    Q_OBJECT
public:
    explicit AuthenticationService(DataBaseStorage &db ,QObject *parent = nullptr);

    QString userId() const override;

signals:


public slots:
    void saveUser(const QString &email, const QString& password) override;
    void checkIfUserExists(const QString &email) override;

    void signIn(const QString &email, const QString &password) override;
    void signOut() override;
    bool isSignedIn() override;

private:
    DataBaseStorage &_dbStorage;
};

#endif // AUTHENTICATIONSERVICE_HPP
