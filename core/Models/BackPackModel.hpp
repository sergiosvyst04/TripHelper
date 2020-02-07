#ifndef BACKPACKMODEL_HPP
#define BACKPACKMODEL_HPP

#include <QAbstractListModel>
#include "core/Storage/BackPackItem.hpp"

class BackPackModel : public QAbstractListModel
{
    Q_OBJECT

public:
    explicit BackPackModel(QObject *parent = nullptr);

    enum BackPackItemRole {
        NameRole = Qt::UserRole + 1,
        IsPackedRole
    };

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    bool setData(const QModelIndex &index, const QVariant &value, int role = Qt::DisplayRole) override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    void setItemsList(const QVector<BackPackItem>& itemsList);

public slots:
    bool checkIfBackPackIsFullyPacked();

private:
    QVector<BackPackItem> _itemsList;
};

#endif // BACKPACKMODEL_HPP
