#include "Trip.hpp"
#include "QTimer"
#include "QDateTime"
#include <QGeoLocation>
#include "TripDay.hpp"
#include <QDebug>


Trip::Trip(const QString &name, QDateTime depatureDate, QObject *parent)
    : _name(name),
      _depatureDate(depatureDate),
      QObject(parent)
{
    QTimer timer;
    timer.start(1000);
    connect(&timer, &QTimer::timeout, [this](){
        checkTime();
        checkLocation();
    });

}

//==============================================================================

Trip::Trip()
{

}

//==============================================================================

Trip::Trip(const Trip &trip)
{
    this->_name = trip._name;
    this->_depatureDate = trip._depatureDate;
    this->_days = trip._days;
    this->_state = trip._state;
    this->_list = trip._list;
    this->_backPack = trip._backPack;
}

//==============================================================================

Trip& Trip::operator=(const Trip &trip)
{
    _name = trip._name;
    _depatureDate = trip._depatureDate;
    _days = trip._days;
    _state = trip._state;
    _list = trip._list;
    _backPack = trip._backPack;

    return *this;
}

//==============================================================================

void Trip::checkTime()
{
    if(QDateTime::currentDateTime() == _depatureDate)
    {
        _state = State::Active;
    }

    if(QDateTime::currentDateTime().time() == QTime(0,0))
    {
        addNewDay();
    }
}

//==============================================================================

void Trip::checkLocation()
{
    QGeoAddress currentAddress = _locationController.address();
    if(_currentLocation.country() != currentAddress.country())
    {
        emit currentCountryChanged();
    }

    _currentLocation = currentAddress;
}

//==============================================================================

void Trip::addNewDay()
{
    TripDay newTripDay;
    _days.push_back(newTripDay);
}

//==============================================================================

void Trip::addItemToList(const QString &item)
{
    _list.push_back(item);
}

//==============================================================================

void Trip::packItem(const QString &item)
{
    _backPack.push_back(item);
}

//==============================================================================

void Trip::addNote(const QString &note)
{
    TripDay currentTripDay = _days.last();
    currentTripDay.notes.push_back(note.toStdString());
}

//==============================================================================

void Trip::makeCheckIn()
{
    TripDay currentTripDay = _days.last();
    QString city = _currentLocation.city();
    currentTripDay.cities.push_back(city.toStdString());
    // checkIfSuchCityISVisited
}

//==============================================================================

void Trip::addPhoto(const QString &path)
{
    TripDay currentTripDay = _days.last();
    QGeoAddress location = _locationController.address();
    QDateTime timestamp = QDateTime::currentDateTime();

    Photo newPhoto {
        path.toStdString(),
                timestamp,
                location
    };

    currentTripDay.photos.push_back(newPhoto);
}

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

QList<QString> Trip::getList() const
{
    return _list;
}

//==============================================================================

QList<QString> Trip::getBackPack() const
{
    return _backPack;
}

//==============================================================================

QGeoAddress Trip::getCurrentLocation() const
{
    return _currentLocation;
}
