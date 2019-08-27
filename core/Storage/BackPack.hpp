#ifndef BACKPACK_HPP
#define BACKPACK_HPP

#include <QObject>
#include "core/Models/ListItemsModel.hpp"

class BackPack : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QList<QString> list READ getList NOTIFY itemAdded)
    Q_PROPERTY(QList<QString> backPack READ getBackPack)
    Q_PROPERTY(ListItemsModel* listItemsModel READ getListItemsModel)
public:
    explicit BackPack(QObject *parent = nullptr);
    BackPack(const BackPack &backPack);
    BackPack& operator=(const BackPack &backPack);


    QList<QString> getList() const;
    QList<QString> getBackPack() const;
    ListItemsModel* getListItemsModel();

signals:
    void itemAdded(const QString &item);

public slots:
    void addItemToList(const QString &item);
    void packItem(const QString &item);
    void removeItemFromList(const QString &item);
    bool checkIfItemExists(const QString &item);

private:
    QList<QString> _list;
    QList<QString> _backPack;
    ListItemsModel *_listItemsModel;
};

#endif // BACKPACK_HPP
