#ifndef CHECKLISTMODEL_H
#define CHECKLISTMODEL_H

#include <QAbstractListModel>

struct CheckListItem {
    bool isPacked;
    QString group;
    QStringList things;
};

class CheckListModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum CheckListItemRole {
        IsPacked = Qt::UserRole + 1,
        Group,
        Things
    };

    explicit CheckListModel(QObject *parent = nullptr);
    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    void fillCheckListFromJsonArray(QJsonArray &jsonArray);

private:
    QVector<CheckListItem> _checkListItems;
};

#endif // CHECKLISTMODEL_H
