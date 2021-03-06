#include "BackPackModel.hpp"
#include <QDebug>
#include <core/Services/PackService.hpp>

BackPackModel::BackPackModel(QObject *parent)
    : QAbstractListModel(parent)
{

}

//==============================================================================

int BackPackModel::rowCount(const QModelIndex &parent) const
{
    return _itemsList.count();
}

//==============================================================================

QVariant BackPackModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    const auto &backPackItem = _itemsList.at(index.row());

    switch (role) {
    case NameRole:
        return backPackItem.name;
    case IsPackedRole:
        return backPackItem.isPacked;
    }

    return QVariant();
}

//==============================================================================

bool BackPackModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (!hasIndex(index.row(), index.column(), index.parent()) || !value.isValid())
        return false;

    BackPackItem &backPackItem = _itemsList[index.row()];

    if(role == NameRole)
        backPackItem.name = value.toString();
    else if(role == IsPackedRole)
        backPackItem.isPacked = value.toBool();
    else
        return false;

    emit dataChanged(index, index, { role } );

    return true ;
}

//==============================================================================

QHash<int, QByteArray> BackPackModel::roleNames() const
{
    static QHash<int, QByteArray> roleNames{
        { NameRole, "name"},
        { IsPackedRole, "isPacked"}
    };

    return roleNames;
}


//==============================================================================

bool BackPackModel::checkIfBackPackIsFullyPacked()
{
    for(int i = 0; i < _itemsList.count(); i++)
    {
        if(_itemsList.at(i).isPacked == false)
            return false;
    }
    return true;
}

//==============================================================================

void BackPackModel::setItemsList()
{
    beginResetModel();
    _itemsList = _packService->getBackPackItems();
    endResetModel();
}

//==============================================================================

void BackPackModel::intialize(PackService *packService) {
    qDebug() << "INTIALIZE : " << packService->getBackPackItems().size();
    if(!_packService.isNull())
        _packService.clear();
    _packService = packService;
    setItemsList();
    connect(packService, &PackService::backpackChanged, this, &BackPackModel::setItemsList);
}

