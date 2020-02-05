#ifndef DATABASESTORAGE_HPP
#define DATABASESTORAGE_HPP

#include <QObject>
#include <map>
#include <core/Storage/UserInfo.hpp>
#include <QJsonDocument>
#include <core/Storage/TripData.hpp>

class DataBaseStorage : public QObject
{
    Q_OBJECT
public:
    explicit DataBaseStorage(QObject *parent = nullptr);
    void readUsers();
    void updateUsers();

    void readUsersData();
    void updateUsersData();

    void writeDataToJsonFile(QJsonDocument &jsonDocument, const QString &path);
    
    void saveUser(const QString &email, const QString& password);
    void saveUserInfo(UserInfo &userInfo);

    std::map<QString, UserInfo>* getUsersDb() const;
    std::map<QString, UserInfo> parseUsersJsonArray(QJsonArray &jsonArray);
    std::map<QString, std::map<QString, QVariant>> parseUsersDataJsonArray(QJsonArray &jsonArray);

    QList<QVariant> getCompletedTrips(const QString &uid);
signals:

public slots:

private:
    std::map<QString, UserInfo> *_usersDB;
    std::map<QString, std::map<QString, QVariant>> *_usersDataDB;
};

#endif // DATABASESTORAGE_HPP
