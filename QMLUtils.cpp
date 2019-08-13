#include "QMLUtils.hpp"
#include <QDateTime>
#include <QDebug>

//==============================================================================

QMLUtils::QMLUtils(QObject *parent) : QObject(parent)
{

}

//==============================================================================

QMLUtils::~QMLUtils()
{

}

QVector<QString> QMLUtils::calculateRemainigTime(QVariant departureTime)
{
    QVector<QString> timeVector;
    QDateTime departure = departureTime.toDateTime();
    int secsPerDay = 86400;
    int secsPerHour = 3600;
    int secsPerMinute = 60;


    int fullDaysLeft = QDateTime::currentDateTime().daysTo(departure) - 1;
    int hoursLeft = 0;
    int minutesLeft = 0;
    qint64 secondsLeft = QDateTime::currentDateTime().msecsTo(departure) / 1000;;
    secondsLeft -= fullDaysLeft * secsPerDay;

    hoursLeft = secondsLeft / secsPerHour;
    secondsLeft -= hoursLeft * secsPerHour;

    minutesLeft = secondsLeft / secsPerMinute;
    secondsLeft -= minutesLeft * secsPerMinute;

    timeVector.push_back(QString::number(fullDaysLeft));
    timeVector.push_back(QString::number(hoursLeft));
    timeVector.push_back(QString::number(minutesLeft));
    timeVector.push_back(QString::number(secondsLeft));

    return timeVector;
}

//==============================================================================
