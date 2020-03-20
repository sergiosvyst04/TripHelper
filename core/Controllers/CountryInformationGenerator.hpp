#ifndef COUNTRYINFORMATIONGENERATOR_HPP
#define COUNTRYINFORMATIONGENERATOR_HPP

#include <QObject>
#include <core/Storage/CountryInformation.hpp>
#include "QJsonDocument"
#include "QJsonArray"
#include "QJsonObject"
#include "QJsonValue"

class CountryInformationGenerator : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString generalInformation READ generalInformation NOTIFY neededCountryChanged)
    Q_PROPERTY(QString souvenirs READ souvenirs NOTIFY neededCountryChanged)
    Q_PROPERTY(QString interestingFacts READ interestingFacts NOTIFY neededCountryChanged)
    Q_PROPERTY(QString inventions READ inventions NOTIFY neededCountryChanged)
    Q_PROPERTY(QString kitchen READ kitchen NOTIFY neededCountryChanged)
public:
    explicit CountryInformationGenerator(QObject *parent = nullptr);
    std::map<QString, CountryInformation> readCountries();

    QString generalInformation();
    QString souvenirs();
    QString interestingFacts();
    QString inventions();
    QString kitchen();

signals:
    void neededCountryChanged();

public slots:
    void fetchNeededCountryInfo(QString country);

private:
    std::map<QString, CountryInformation> _countryInformationMap;
    CountryInformation _neededCountry;
};

#endif // COUNTRYINFORMATIONGENERATOR_HPP
