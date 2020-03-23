#include "TravelAgentsModel.hpp"
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>
#include <QFile>
#include <QDebug>


TravelAgentsModel::TravelAgentsModel(QObject *parent)
    : QAbstractListModel(parent)
{
    _allTravelAgents = readTravelAgents();
}

std::map<QString, QVector<TravelAgentInfo>> TravelAgentsModel::readTravelAgents()
{
    QFile file(":/db/assets/TravelAgentsDB.json");
    file.open(QFile::ReadOnly | QIODevice::Text);

    std::map<QString, QVector<TravelAgentInfo>> allAgentsMap;

    QString allAgents = file.readAll();
    QJsonDocument jsonDoc = QJsonDocument::fromJson(allAgents.toUtf8());
    QVariantMap allAgentsVariantMap = jsonDoc.object().toVariantMap();

    for(auto p = allAgentsVariantMap.begin(); p != allAgentsVariantMap.end(); ++p)
    {
        QString currentCity = p.key();
        QVector<TravelAgentInfo> currentCityAgents;

        QVariantList currentCityAgentsVariantList = p.value().toList();
        for(auto &agent : currentCityAgentsVariantList)
        {
            TravelAgentInfo currentAgent;
            QVariantMap agentMap = agent.toMap();

            currentAgent.name = agentMap.value("name").toString();
            currentAgent.address = agentMap.value("address").toString();
            currentAgent.phoneNumber = agentMap.value("phoneNumber").toString();
            currentCityAgents.push_back(currentAgent);
        }
        allAgentsMap.insert(std::pair<QString, QVector<TravelAgentInfo>>(currentCity, currentCityAgents));
    }
    return allAgentsMap;
}

void TravelAgentsModel::getTravelAgentsOfNeededCity(QString city)
{
    beginResetModel();
    _travelAgentsOfNeededCity = _allTravelAgents.at(city.toLower());
    endResetModel();
}

int TravelAgentsModel::rowCount(const QModelIndex &parent) const
{
    return _travelAgentsOfNeededCity.size();
}

QVariant TravelAgentsModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    auto travelAgent = _travelAgentsOfNeededCity.at(index.row());
    
    switch(role)
    {
    case NameRole :
        return travelAgent.name;
    case AddressRole :
        return travelAgent.address;
    case PhoneNumberRole:
        return travelAgent.phoneNumber;
    }
    
    return QVariant();
}

QHash<int, QByteArray> TravelAgentsModel::roleNames() const 
{
    QHash<int, QByteArray> roleNames {
        {NameRole, "name"},
        {AddressRole, "address"},
        {PhoneNumberRole, "phoneNumber"}
    };
    
    return roleNames;
}

QVector<QString> TravelAgentsModel::getCitiesWithTravelAgents()
{
    QVector<QString> cities;

    for(auto p = _allTravelAgents.begin(); p != _allTravelAgents.end(); ++p)
        cities.push_back(p->first);
    return cities;
}
