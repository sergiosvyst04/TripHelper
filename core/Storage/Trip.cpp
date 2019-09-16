#include "Trip.hpp"
#include "QTimer"
#include "QDateTime"
#include <QGeoLocation>
#include "TripDay.hpp"
#include <QDebug>


Trip::Trip(TripData *tripData, QObject *parent)
    : QObject(parent)
{
    _name = tripData->name;
    tripData->depatureDate.setTime(QTime(0,0));
    _depatureDate = tripData->depatureDate;
    _backPack = tripData->backPackList;
    _days = tripData->days;
}

//==============================================================================

Trip::Trip()
{

}

//==============================================================================

//void Trip::checkTime()
//{
//    if(QDateTime::currentDateTime().secsTo(_depatureDate) == 0)
//    {
//        _state = State::Active;
//        if(!_backPack->checkIfBackPackIsFullyPacked())
//            emit forgotToPackItems();
//        emit stateChanged();
//    }

//    if(QDateTime::currentDateTime().time() == QTime(0,0))
//    {
//        addNewDay();
//    }
//}

//==============================================================================

//void Trip::checkLocation()
//{
//    QGeoAddress currentAddress = _locationController.address();
//    if(_currentLocation.country() != currentAddress.country())
//    {
//        emit currentCountryChanged();
//    }

//    _currentLocation = currentAddress;
//}

//==============================================================================

//void Trip::addNewDay()
//{
//    TripDay newTripDay;
//    _days.push_back(newTripDay);
//}

//==============================================================================

//void Trip::addNote(const QString &note)
//{
//    TripDay currentTripDay = _days.last();
//    currentTripDay.notes.push_back(note);
//}

//==============================================================================

//void Trip::addNewIdea(const QString &idea)
//{
//    TripDay currentTripDay = _days.last();
//    currentTripDay.ideas.push_back(idea);
//}

//==============================================================================

//void Trip::makeCheckIn()
//{
//    TripDay currentTripDay = _days.last();
//    QString city = _currentLocation.city();
//    currentTripDay.cities.push_back(city);
//    // checkIfSuchCityISVisited
//}

//==============================================================================

//void Trip::addPhoto(const QString &path)
//{
//    TripDay currentTripDay = _days.last();
//    QGeoAddress location = _locationController.address();
//    QDateTime timestamp = QDateTime::currentDateTime();

//    Photo newPhoto {
//        path,
//        timestamp,
//        location
//    };

//    currentTripDay.photos.push_back(newPhoto);
//}

//==============================================================================

QString Trip::getName() const
{
    return _name;
}

//==============================================================================

QDateTime Trip::getDepatureDate() const
{
    return _depatureDate;
}

//==============================================================================

int Trip::getState() const
{
    return _state;
}

//==============================================================================

QList<TripDay> Trip::getDays() const
{
    return _days;
}

//==============================================================================

QList<BackPackItem>& Trip::getBackPack()
{

    return _backPack;
}

//==============================================================================

QList<QString> Trip::getAllCountries() const
{
    QList<QString> countriesList;
    for(int i = 0; i < _days.size(); i++)
    {
        for(unsigned int j = 0; j < _days.at(i).countries.size(); j++)
        {
            QString country = _days.at(i).countries.at(j);
            if(!countriesList.contains(country))
                countriesList.push_back(country);
        }
    }
    return countriesList;
}

//==============================================================================

QList<QString> Trip::getAllCities() const
{
    QList<QString> citiesList;

    for(int i = 0; i < _days.size(); i++)
    {
        for(unsigned int j = 0; j < _days.at(i).cities.size(); j++)
        {
            QString city = _days.at(i).cities.at(j);
            if(!citiesList.contains(city))
                citiesList.push_back(city);
        }
    }
    return citiesList;
}

//==============================================================================

QList<Photo> Trip::getAllPhotos() const
{
    QList<Photo> photosList;
    for(int i = 0; i < _days.size(); i++)
    {
        for(unsigned int j = 0; j < _days.at(i).photos.size(); j++)
        {
            Photo photo = _days.at(i).photos.at(j);
            photosList.push_back(photo);
        }
    }
    return photosList;

}

//==============================================================================

QList<QString> Trip::getAllIdeas() const
{
    QList<QString> ideasList;
    for(int i = 0; i < _days.size(); i++)
    {
        for(unsigned int j = 0; j < _days.at(i).ideas.size(); j++)
        {
            QString idea = _days.at(i).ideas.at(j);
            ideasList.push_back(idea);
        }
    }
    return ideasList;
}

//==============================================================================

void Trip::setDepatureDate(QDateTime depatureDate)
{
    _depatureDate = depatureDate;
}

//==============================================================================

void Trip::setName(const QString &name)
{
    _name = name;
}

//==============================================================================

void Trip::setDays(QList<TripDay> days)
{
    _days = days;
}

//==============================================================================

void Trip::setBackPackList(QList<BackPackItem> &itemslist)
{
    _backPack = itemslist;
}

//==============================================================================

TripDay& Trip::getCurrentTripDay()
{
    return _days.last();
}
