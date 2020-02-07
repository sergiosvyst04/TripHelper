#ifndef VISITEDLOCATIONSCONTROLLER_HPP
#define VISITEDLOCATIONSCONTROLLER_HPP

#include <QObject>
#include <core/Storage/DataBaseStorage.hpp>


class VisitedLocationsController : public QObject
{
    Q_OBJECT
public:
    enum LocationsType { Countries, Citites};

    explicit VisitedLocationsController(DataBaseStorage &databaseStorage ,QObject *parent = nullptr);

signals:

public slots:
    QVector<QString> getCities();
    QVector<QString> getCountries();

private:
    DataBaseStorage &_dbStorage;
    QVector<QString> _visitedCities;
    QVector<QString> _visitedCountries;
};

#endif // VISITEDLOCATIONSCONTROLLER_HPP
