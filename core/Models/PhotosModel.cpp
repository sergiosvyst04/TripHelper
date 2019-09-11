#include "PhotosModel.hpp"
#include "QDebug"

PhotosModel::PhotosModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

int PhotosModel::rowCount(const QModelIndex &parent) const
{
    _photos.size();
}

QVariant PhotosModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    const auto &photo = _photos.at(index.row());

    switch(role){
    case SourceRole:
        return photo.source;
    case LocationRole:
        return QVariant::fromValue(photo.location);
    case DateRole:
        return photo.timestamp;
    }

    return QVariant();
}

QHash<int, QByteArray> PhotosModel::roleNames() const
{
    QHash<int, QByteArray> roleNames {
        {SourceRole, "source"},
        {LocationRole, "location"},
        {DateRole, "date"}
    };

    return roleNames;
}

//==============================================================================

void PhotosModel::getPhotos(QVector<Photo> photos)
{
    beginResetModel();
    _photos = photos;
    endResetModel();
}

//==============================================================================

void PhotosModel::removePhoto(int index)
{
    beginRemoveRows(QModelIndex(), index, index);
    _photos.removeAt(index);
    endRemoveRows();
}
