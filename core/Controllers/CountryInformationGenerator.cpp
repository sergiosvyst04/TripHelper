#include "CountryInformationGenerator.hpp"
#include "QFile"
#include "QDebug"

CountryInformationGenerator::CountryInformationGenerator(QObject *parent) : QObject(parent)
{
    _countryInformationMap = readCountries();
}

std::map<QString, CountryInformation> CountryInformationGenerator::readCountries()
{
    QFile file(":/db/assets/CountryInformation.json");
    file.open(QFile::ReadOnly | QIODevice::Text);

    std::map<QString, CountryInformation> countriesInformation;

    QString informationAbountCountries = file.readAll();
    QJsonDocument jsonDoc = QJsonDocument::fromJson(informationAbountCountries.toUtf8());
    QJsonObject jsonObj = jsonDoc.object();
    QVariantMap countriesInfoVariantMap = jsonObj.toVariantMap();

    for(auto p = countriesInfoVariantMap.begin(); p != countriesInfoVariantMap.end(); ++p)
    {
        QString currentCountry = p.key();
        CountryInformation currentCountryInfo;
        QVariantMap informationMap = p.value().toMap();
        currentCountryInfo.generalInformation = informationMap.value("generalInformation").toString();
        currentCountryInfo.souvenirs = informationMap.value("souvenirs").toString();
        currentCountryInfo.kitchen = informationMap.value("kitchen").toString();
        currentCountryInfo.inventions = informationMap.value("inventions").toString();
        currentCountryInfo.interestingFacts = informationMap.value("interestingFacts").toString();

        countriesInformation.insert(std::pair<QString, CountryInformation>(currentCountry, currentCountryInfo));
    }

    return countriesInformation;
}

void CountryInformationGenerator::fetchNeededCountryInfo(QString country)
{
    _neededCountry = _countryInformationMap.at(country);
    emit neededCountryChanged();
}

QString CountryInformationGenerator::generalInformation()
{
   return _neededCountry.generalInformation;
}

QString CountryInformationGenerator::souvenirs()
{
    return  _neededCountry.souvenirs;
}

QString CountryInformationGenerator::interestingFacts()
{
    return _neededCountry.interestingFacts;
}

QString CountryInformationGenerator::kitchen()
{
    return _neededCountry.kitchen;
}

QString CountryInformationGenerator::inventions()
{
    return _neededCountry.inventions;
}
