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

Q_DECLARE_METATYPE(Photo)
#endif // PHOTO_HPP
