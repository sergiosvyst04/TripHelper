#ifndef ENDTRIPSERVICE_HPP
#define ENDTRIPSERVICE_HPP

#include <QObject>
#include "core/Models/CompletedTripsModel.hpp"
#include "core/Storage/TripData.hpp"
#include "core/Controllers/ApplicationController.hpp"

class EndTripService : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVector<Photo> allPhotos READ getAllPhotos CONSTANT)
    Q_PROPERTY(QVector<QString> allCities READ getAllCities CONSTANT)
    Q_PROPERTY(QVector<QString> allCountries READ getAllCountries CONSTANT)

public:
    explicit EndTripService(QObject *parent = nullptr);
    Q_INVOKABLE void intialize(ApplicationController *applicationController);
    Q_INVOKABLE void endTrip();

    QVector<Photo> getAllPhotos();
    QVector<QString> getAllCities();
    QVector<QString> getAllCountries();


signals:

public slots:

private:
    CompletedTripsModel *_completedTripsModel;
    TripData *_activeTrip;
};

#endif // ENDTRIPSERVICE_HPP
