#include "GalleryService.hpp"
#include "QDebug"

GalleryService::GalleryService(QObject *parent) : QObject(parent)
{
    _photosModel = new PhotosModel();
}

//==============================================================================

void GalleryService::intialize(ApplicationController *applicationController)
{
    _viewedTrip = applicationController->getTripsManager().getActiveTrip();
    QVector<Photo> tripPhotos = getAllPhotos();
    _photosModel->getPhotos(tripPhotos);
}

//==============================================================================

QVector<Photo> GalleryService::getAllPhotos()
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
    return allPhotosList;
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
}

