#ifndef PHOTOSMODEL_HPP
#define PHOTOSMODEL_HPP

#include <QAbstractListModel>
#include <core/Storage/Photo.hpp>

class PhotosModel : public QAbstractListModel
{
    Q_OBJECT

    enum PhotosRole {
        SourceRole = Qt::UserRole + 1,
        LocationRole,
        DateRole
    };

public:
    explicit PhotosModel(QObject *parent = nullptr);
    Q_INVOKABLE void getPhotos(QVector<Photo> photos);
    Q_INVOKABLE  void removePhoto(int index);

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;
private:
    QVector<Photo> _photos;
};

#endif // PHOTOSMODEL_HPP
