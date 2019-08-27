#ifndef BACKPACKFILTERMODEL_HPP
#define BACKPACKFILTERMODEL_HPP

#include <QSortFilterProxyModel>
#include "BackPackModel.hpp"

class BackpackFilterModel : public QSortFilterProxyModel
{
    Q_OBJECT

public:
    explicit BackpackFilterModel(QObject *parent = nullptr);
    virtual bool filterAcceptsRow(int source_row, const QModelIndex &source_parent) const override;

private:
};

#endif // BACKPACKFILTERMODEL_HPP
