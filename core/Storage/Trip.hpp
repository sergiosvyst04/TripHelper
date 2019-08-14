#ifndef TRIP_HPP
#define TRIP_HPP

#include <QObject>
#include <QVector>
#include <QString>
#include <QDateTime>
#include "TripDay.hpp"
#include <QGeoLocation>

class Trip : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name READ getName CONSTANT)
    Q_PROPERTY(QDateTime depatureDate READ getDepatureDate)
    Q_PROPERTY(int state READ getState)
    Q_PROPERTY(QList<TripDay> days READ getDays)
    Q_PROPERTY(QList<QString> list READ getList)
    Q_PROPERTY(QList<QString> backPack READ getBackPack)

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
    QList <QString> getList() const;
    QList <QString> getBackPack() const;
    QGeoAddress getCurrentLocation() const;

signals:
    void currentCountryChanged();
    void stateChanged();


public slots:
    void addItemToList(const QString &item);
    void packItem(const QString &item);
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
    QList<TripDay> _days;
    QList <QString> _list;
    QList<QString> _backPack;
    QGeoLocation _locationController;
    QGeoAddress _currentLocation;
};

Q_DECLARE_METATYPE(Trip);

#endif // TRIP_HPP
