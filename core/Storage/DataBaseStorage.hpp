#ifndef DATABASESTORAGE_HPP
#define DATABASESTORAGE_HPP

#include <QObject>
#include <map>
#include <core/Storage/UserInfo.hpp>
#include <QJsonDocument>

class DataBaseStorage : public QObject
{
    Q_OBJECT
public:
    explicit DataBaseStorage(QObject *parent = nullptr);
    void readUsers();
    void updateUsers();
    void writeUsers(QJsonDocument &jsonDocument);
    void saveUser(const QString &email, const QString& password);

    std::map<QString, UserInfo>* getUsersDb() const;
    std::map<QString, UserInfo> parseUsersJsonArray(QJsonArray &jsonArray);

signals:

public slots:

private:
    std::map<QString, UserInfo> *_usersDB;
};

#endif // DATABASESTORAGE_HPP
