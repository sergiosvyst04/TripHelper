#ifndef AUTHENTICATIONSERVICE_HPP
#define AUTHENTICATIONSERVICE_HPP

#include <QObject>
#include <QMap>
#include <Storage/UserInfo.hpp>
#include <Storage/DataBaseStorage.hpp>

namespace firebase {
template<class T>
class Future;
class App;

namespace auth {
class Auth;
class User;
class AuthStateListener;
}

namespace database {
class Database;
class DatabaseReference;
}
}

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

    firebase::auth::Auth *_authService = nullptr;
};

#endif // AUTHENTICATIONSERVICE_HPP
