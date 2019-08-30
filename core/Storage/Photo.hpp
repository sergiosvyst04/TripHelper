#ifndef PHOTO_HPP
#define PHOTO_HPP
#include <QString>
#include <QDateTime>
#include <QGeoAddress>

struct Photo {
    QString source;
    QDateTime timestamp;
    QGeoAddress location;
};

#endif // PHOTO_HPP
