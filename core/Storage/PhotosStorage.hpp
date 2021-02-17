#ifndef PHOTOSSTORAGE_HPP
#define PHOTOSSTORAGE_HPP

#include <QObject>
#include <QVector>
#include "Photo.hpp"
#include "DataBaseStorage.hpp"
#include "Services/AuthenticationService.hpp"

class PhotosStorage : public QObject
{
    Q_OBJECT
public:
    explicit PhotosStorage(DataBaseStorage &databaseStorage, AuthenticationService &authService ,QObject *parent = nullptr);

signals:

public slots:
    QVector<Photo> getPhotosByLocation(const QString &location);
    void readPhotos();

private:
    AuthenticationService &_authService;
    DataBaseStorage &_dbStorage;
    QVector<Photo> _allPhotos;
};

#endif // PHOTOSSTORAGE_HPP
