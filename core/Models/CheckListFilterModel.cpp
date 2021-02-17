#include "CheckListFilterModel.h"
#include "QDebug"
#include "Models/CheckListModel.h"

CheckListFilterModel::CheckListFilterModel(QObject *parent)
    : QSortFilterProxyModel(parent)
{
}


void CheckListFilterModel::setSearchPattern(bool searchPattern) {
    _searchPattern = searchPattern;
    invalidate();
}

bool CheckListFilterModel::getSearchPattern() {
    return _searchPattern;
}

bool CheckListFilterModel::filterAcceptsRow(int source_row, const QModelIndex &source_parent) const {
    auto originalModel = sourceModel();
    if (!originalModel && !source_parent.isValid())
        return false;

    auto originalModelIndex = originalModel->index(source_row, 0, source_parent);

    if(!originalModelIndex.isValid())
        return false;
    auto isPackItem = originalModel->data(originalModelIndex, CheckListModel::IsPacked).toBool();
    return _searchPattern == isPackItem;
}
