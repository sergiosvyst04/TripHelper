#ifndef TRIP_HPP
#define TRIP_HPP

#include <QObject>
#include <QVector>
#include <QString>
#include <QDateTime>
#include "TripDay.hpp"
#include <QGeoLocation>
#include "core/Models/BackPackModel.hpp"
#include "core/Storage/TripData.hpp"

class Trip : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVector<TripDay> days READ getDays)
    Q_PROPERTY(QString name READ getName CONSTANT)
    Q_PROPERTY(QDateTime depatureDate READ getDepatureDate CONSTANT)
    Q_PROPERTY(QVector<QString> allCountries READ getAllCountries CONSTANT)
    enum State {
        InWaiting = 0,
        Active,
        Completed
    };

public:
    explicit Trip(TripData *tripData, QObject *parent = nullptr);
    Trip();

    QString getName() const;
    QDateTime getDepatureDate() const;
    int getState() const;
    QVector<TripDay> getDays() const;
    TripDay& getCurrentTripDay();
    QVector<BackPackItem>& getBackPack();

    QVector<QString> getAllCountries() const;
    QVector<QString> getAllCities() const;
    QVector<Photo> getAllPhotos() const;
    QVector<QString> getAllIdeas() const;

    void setDepatureDate(QDateTime depatureDate);
    void setName(const QString &name);
    void setDays(QVector<TripDay> days);
    void setBackPackList(QVector<BackPackItem> &itemslist);


signals:
    void currentCountryChanged();
    void stateChanged();
    void forgotToPackItems();


public slots:
private:
    QString _name;
    QDateTime _depatureDate;
    //    QDateTime _arrivalDate;
    int _state = State::InWaiting;
    QVector <TripDay> _days;
    QVector<BackPackItem> _backPack;
};

//Q_DECLARE_METATYPE(Trip);

#endif // TRIP_HPP
