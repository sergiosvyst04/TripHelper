#include "PhotosStorage.hpp"

PhotosStorage::PhotosStorage(DataBaseStorage &dataBaseStorage, AuthenticationService &authenticationService, QObject *parent)
    : _dbStorage(dataBaseStorage),
      _authService(authenticationService),
      QObject(parent)
{
    if(_authService.isSignedIn())
        _allPhotos = _dbStorage.getAllPhotos();

    connect(&_authService, &AuthenticationService::signedIn, this, &PhotosStorage::readPhotos);
}

//==============================================================================

QVector<Photo> PhotosStorage::getPhotosByLocation(const QString &location)
{
    QVector<Photo> photosFromCurrentCity;

    auto checkIfFromNeededCity = [&](Photo &photo) {return photo.location.city() == location || photo.location.country() == location;};

    for(auto &photo : _allPhotos)
        if(checkIfFromNeededCity(photo))
            photosFromCurrentCity.push_back(photo);

    return photosFromCurrentCity;
}

//==============================================================================

void PhotosStorage::readPhotos()
{
    _allPhotos = _dbStorage.getAllPhotos();
}
