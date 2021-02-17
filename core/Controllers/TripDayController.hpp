#ifndef TRIPDAYCONTROLLER_HPP
#define TRIPDAYCONTROLLER_HPP

#include <QObject>
#include "Storage/TripData.hpp"
#include "Controllers/ActiveTripController.hpp"

class TripDayController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVector<Photo> photos READ getPhotosOfDay)
    Q_PROPERTY(QVector<QString> cities READ getCitiesOfDay)
    Q_PROPERTY(QVector<QString> ideas READ getIdeasOfDay)
    Q_PROPERTY(QVector<QString> notes READ getNotesOfDay)

public:
    explicit TripDayController(QObject *parent = nullptr);
    Q_INVOKABLE void intialize(int index, Trip *trip);

    QVector<Photo> getPhotosOfDay();
    QVector<QString> getCitiesOfDay();
    QVector<QString> getIdeasOfDay();
    QVector<QString> getNotesOfDay();

signals:

public slots:

private:
    TripDay *_tripDay;
};

#endif // TRIPDAYCONTROLLER_HPP
