#ifndef BACKPACKFILTERMODEL_HPP
#define BACKPACKFILTERMODEL_HPP

#include <QSortFilterProxyModel>
#include "BackPackModel.hpp"


class BackpackFilterModel : public QSortFilterProxyModel
{
    Q_OBJECT
    Q_PROPERTY(bool packedVisible READ getFilterProperty WRITE setFilterProperty NOTIFY filterPropertyChanged)

public:
    explicit BackpackFilterModel(QObject *parent = nullptr);

    virtual bool filterAcceptsRow(int source_row, const QModelIndex &source_parent) const override;
    void setFilterProperty(bool isPacked);
    bool getFilterProperty();
signals:
    void filterPropertyChanged();
private:
    bool _isPacked;
};

#endif // BACKPACKFILTERMODEL_HPP
