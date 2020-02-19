#ifndef GALLERYSERVICE_HPP
#define GALLERYSERVICE_HPP

#include <QObject>
#include "core/Controllers/ApplicationController.hpp"
#include "core/Models/PhotosModel.hpp"
#include "core/Storage/TripData.hpp"
#include <core/Storage/PhotosStorage.hpp>

class GalleryService : public QObject
{
    Q_OBJECT
    Q_PROPERTY(PhotosModel* photosModel READ getModelWithPhotos NOTIFY photosModelChanged)
public:
    explicit GalleryService(QObject *parent = nullptr);

    Q_INVOKABLE void intialize(PhotosStorage *photosStorage, TripsManager *tripsManager);
    Q_INVOKABLE void removePhoto(int index, QString path);
    PhotosModel* getModelWithPhotos();

signals:
    void photosModelChanged();

public slots:
    void getPhotos(QString location);
    void setAllPhotosForModel();

private:
    PhotosModel *_photosModel;
    PhotosStorage *_photosStorage;
    TripData *_viewedTrip;
};

#endif // GALLERYSERVICE_HPP
