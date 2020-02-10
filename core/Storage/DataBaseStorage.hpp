#ifndef DATABASESTORAGE_HPP
#define DATABASESTORAGE_HPP

#include <QObject>
#include <map>
#include <core/Storage/UserInfo.hpp>
#include <QJsonDocument>
#include <core/Storage/TripData.hpp>
#include <core/Storage/Goal.hpp>

class VisitedLocationsController;

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

    void addGoal(Goal &goal);

    std::map<QString, UserInfo>* getUsersDb() const;
    std::map<QString, UserInfo> parseUsersJsonArray(QJsonArray &jsonArray);
    std::map<QString, std::map<QString, QVariant>> parseUsersDataJsonArray(QJsonArray &jsonArray);

    QVector<QVariant> getCompletedTrips(const QString &uid);
    QVector<QVariant> getGoals();
    QVector<QString> getLocations(const QString &locationsType);
    QVector<Photo> getAllPhotos();

signals:
    void goalAddedToDb();

public slots:

private:
    std::map<QString, UserInfo> *_usersDB;
    std::map<QString, std::map<QString, QVariant>> *_usersDataDB;
};

#endif // DATABASESTORAGE_HPP
