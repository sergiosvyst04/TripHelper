#include "BackpackFilterModel.hpp"
#include <QDebug>

BackpackFilterModel::BackpackFilterModel(QObject *parent)
    : QSortFilterProxyModel(parent)
{

}

//==============================================================================

bool BackpackFilterModel::filterAcceptsRow(int source_row, const QModelIndex &source_parent) const
{
    auto originalModel = sourceModel();

    if(!originalModel && !source_parent.isValid())
        return false;

    auto originalModelIndex = originalModel->index(source_row, 0, source_parent);

    if(!originalModelIndex.isValid())
        return false;

    auto isPacked = originalModel->data(originalModelIndex, BackPackModel::IsPackedRole).toBool();
    return !isPacked;
}

//==============================================================================


