#include "CheckListModel.h"

#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonValue>
#include <Services/JsonHelperMethods.h>
#include <QJsonObject>

CheckListModel::CheckListModel(QObject *parent)
    : QAbstractListModel(parent)
{
    QJsonArray checkListJsonArray = JsonHelperMethods::readJsonFile(":/db/assets/CheckListModel.json");
    fillCheckListFromJsonArray(checkListJsonArray);
}

void CheckListModel::fillCheckListFromJsonArray(QJsonArray &jsonArray) {
    beginResetModel();
    for(auto checkListItem : jsonArray) {
        QJsonObject jsonObject = checkListItem.toObject();
        CheckListItem currentCheckListItem;
        currentCheckListItem.group = jsonObject.value("group").toString();
        currentCheckListItem.isPacked = jsonObject.value("isPack").toBool();
        for(auto currentThing : jsonObject.value("things").toArray())
            currentCheckListItem.things.push_back(currentThing.toString());
        _checkListItems.push_back(currentCheckListItem);
    }
    endResetModel();
}

int CheckListModel::rowCount(const QModelIndex &parent) const
{
    return _checkListItems.size();
}

QVariant CheckListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    const auto &checkListItem = _checkListItems.at(index.row());

    switch(role) {
    case IsPacked:
        return checkListItem.isPacked;
    case Group:
        return checkListItem.group;
    case Things:
        return QVariant::fromValue(checkListItem.things);
    }

    return QVariant();
}

QHash<int, QByteArray> CheckListModel::roleNames() const {
    static QHash<int, QByteArray> roleNames {
        {IsPacked, "isPacked"},
        {Group, "group"},
        {Things, "things"}
    };
    return roleNames;
}
