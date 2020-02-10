#include "PhotosStorage.hpp"

PhotosStorage::PhotosStorage(DataBaseStorage &dataBaseStorage, QObject *parent)
    : _dbStorage(dataBaseStorage),
      QObject(parent)
{
    _allPhotos = _dbStorage.getAllPhotos();
}

QVector<Photo> PhotosStorage::getPhotosByLocation(const QString &location)
{
    QVector<Photo> photosFromCurrentCity;

    auto checkIfFromNeededCity = [&](Photo &photo) {return photo.location.city() == location || photo.location.country() == location;};

    for(auto &photo : _allPhotos)
        if(checkIfFromNeededCity(photo))
            photosFromCurrentCity.push_back(photo);

    return photosFromCurrentCity;
}
