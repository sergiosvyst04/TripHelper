#ifndef VISITEDLOCATIONSCONTROLLER_HPP
#define VISITEDLOCATIONSCONTROLLER_HPP

#include <QObject>
#include <core/Storage/DataBaseStorage.hpp>
#include <core/Services/AuthenticationService.hpp>
#include <core/Storage/Location.hpp>


class VisitedLocationsController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int amountOfVisitedCities READ getAmountOfVisitedCities NOTIFY newCityAdded)
    Q_PROPERTY(int amountOfVisitedCountries READ getAmountOfVisitedCountries NOTIFY newCountryAdded)
public:
    enum LocationsType { Countries, Citites};

    explicit VisitedLocationsController(DataBaseStorage &databaseStorage, AuthenticationService &authService,QObject *parent = nullptr);

signals:
    void locationAdded();
    void newLocationAdded(const Location &location);
    void newCountryAdded(const QString &country);
    void newCityAdded(const QString &city);

public slots:
    void readLocations();
    QVector<QString> getCities();
    QVector<QString> getCountries();
    int getAmountOfVisitedCities() const;
    int getAmountOfVisitedCountries() const;

    void addLocation(QString country, QString city);

private:
    AuthenticationService &_authService;
    DataBaseStorage &_dbStorage;
//    QVector<QString> _visitedCities;
//    QVector<QString> _visitedCountries;
    QVector<Location> _visitedLocations;
};

#endif // VISITEDLOCATIONSCONTROLLER_HPP
