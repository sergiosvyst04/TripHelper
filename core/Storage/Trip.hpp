#ifndef TRIP_HPP
#define TRIP_HPP

#include <QObject>
#include <QVector>
#include <QString>
#include <QDateTime>
#include "TripDay.hpp"
#include <QGeoLocation>
#include "core/Models/BackPackModel.hpp"

class Trip : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name READ getName CONSTANT)
    Q_PROPERTY(QDateTime depatureDate READ getDepatureDate)
    Q_PROPERTY(int state READ getState)
    Q_PROPERTY(QList<TripDay> days READ getDays)
    Q_PROPERTY(BackPackModel* backPack READ getBackPack CONSTANT)         //memory leak??
    enum State {
        InWaiting = 0,
        Active,
        Completed
    };

public:
    explicit Trip(const QString &name, QDateTime depatureDate,QObject *parent = nullptr);
    Trip();
    Trip (const Trip &trip);
    Trip& operator=(const Trip &trip);

    QString getName() const;
    QDateTime getDepatureDate() const;
    int getState() const;
    QList<TripDay> getDays() const;
    QGeoAddress getCurrentLocation() const;
    BackPackModel *getBackPack();

    QList<QString> getAllCountries() const;
    QList<QString> getAllCities() const;
    QList<Photo> getAllPhotos() const;
    QList<QString> getAllIdeas() const;

    void setDepatureDate(QDateTime depatureDate);
    void setName(const QString &name);
    void setDays(QList<TripDay> days);
    void setBackPackList(QList<BackPackItem> &itemslist);


signals:
    void currentCountryChanged();
    void stateChanged();
    void forgotToPackItems();


public slots:
    void addNewDay();
    void addNote(const QString &note);
    void makeCheckIn();
    void addPhoto(const QString &path);
    void checkTime();
    void checkLocation();
private:
    QString _name;
    QDateTime _depatureDate;
    //    QDateTime _arrivalDate;
    int _state = State::InWaiting;
    QList <TripDay> _days;
    BackPackModel *_backPack;
    QGeoLocation _locationController;
    QGeoAddress _currentLocation;
};

Q_DECLARE_METATYPE(Trip);

#endif // TRIP_HPP
