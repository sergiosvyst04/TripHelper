#ifndef AUTHENTICATIONSERVICE_HPP
#define AUTHENTICATIONSERVICE_HPP

#include <QObject>
#include <QMap>
#include <core/Storage/UserInfo.hpp>

class AuthenticationService : public QObject
{
    Q_OBJECT
public:
    explicit AuthenticationService(QObject *parent = nullptr);

signals:
    void userExists(bool exists);

public slots:
    void createUser(const QString &email, const QString& password);
    void readUsers();
    void updateUsers();
    void checkIfUserExists(const QString &email, const QString& password);

    void writeUsers(QJsonDocument &jsonDocument);

    QMap<QString, UserInfo> parseUsersJsonArray(const QJsonArray& usersArray);


private:
    QMap<QString, UserInfo> _users;
};

#endif // AUTHENTICATIONSERVICE_HPP
