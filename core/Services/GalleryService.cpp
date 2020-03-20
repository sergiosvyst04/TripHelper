#include "GalleryService.hpp"
#include "QDebug"

GalleryService::GalleryService(QObject *parent) : QObject(parent)
{
    _photosModel = new PhotosModel();
}

//==============================================================================

void GalleryService::intialize(PhotosModel *photosModel, PhotosStorage *photosStorage, TripsManager *tripsManager)
{
    if(photosModel != nullptr) {
        _photosModel = photosModel;
        emit photosModelChanged();
    }
    _photosStorage = photosStorage;
    _viewedTrip = tripsManager->getUnCompletedTrip();
    connect(this, &GalleryService::photoRemoved, tripsManager, &TripsManager::updateUncompletedTrip);
}

//==============================================================================

void GalleryService::setAllPhotosForModel()
{
    QVector<Photo> allPhotosList;
    for(int i = 0; i < _viewedTrip->days.size(); i++)
    {
        for(int j = 0; j < _viewedTrip->days.at(i).photos.size(); j++)
        {
            Photo photo =  _viewedTrip->days.at(i).photos.at(j);
            allPhotosList.push_back(photo);
        }
    }
    _photosModel->getPhotos(allPhotosList);
}

//==============================================================================

PhotosModel* GalleryService::getModelWithPhotos()
{
    return _photosModel;
}

//==============================================================================

void GalleryService::removePhoto(int index, QString path)
{
    _photosModel->removePhoto(index);
    _viewedTrip->removePhotoByPath(path);
    emit photosModelChanged();
    emit photoRemoved();
}

//==============================================================================

void GalleryService::getPhotos(QString location)
{
    _photosModel->getPhotos(_photosStorage->getPhotosByLocation(location));
}

//==============================================================================

