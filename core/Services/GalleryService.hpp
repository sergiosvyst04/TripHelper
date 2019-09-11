#ifndef GALLERYSERVICE_HPP
#define GALLERYSERVICE_HPP

#include <QObject>
#include "core/Controllers/ApplicationController.hpp"
#include "core/Models/PhotosModel.hpp"
#include "core/Storage/TripData.hpp"

class GalleryService : public QObject
{
    Q_OBJECT
    Q_PROPERTY(PhotosModel* photosModel READ getModelWithPhotos NOTIFY photosModelChanged)
public:
    explicit GalleryService(QObject *parent = nullptr);

    Q_INVOKABLE void intialize(ApplicationController *applicationController);
    Q_INVOKABLE void removePhoto(int index, QString path);
    QVector<Photo> getAllPhotos();
    PhotosModel* getModelWithPhotos();
signals:
    void photosModelChanged();

public slots:

private:
    PhotosModel *_photosModel;
    TripData *_viewedTrip;
};

#endif // GALLERYSERVICE_HPP
