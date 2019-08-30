#ifndef TRIPDAY_HPP
#define TRIPDAY_HPP
#include <QString>
#include <QVector>
#include "Photo.hpp"

struct TripDay {
    QVector <Photo> photos;
    QVector <QString> notes;
    QVector <QString> ideas;
    QVector <QString> cities;
    QVector <QString> countries;
};

Q_DECLARE_METATYPE(TripDay);

#endif // TRIPDAY_HPP
