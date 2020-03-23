#ifndef TRAVELAGENTSMODEL_HPP
#define TRAVELAGENTSMODEL_HPP

#include <QAbstractListModel>
#include <core/Storage/TravelAgentInfo.hpp>

class TravelAgentsModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(QVector<QString> citiesWithAgents READ getCitiesWithTravelAgents CONSTANT)
    
    enum TravelAgentRoles {
        NameRole = Qt::UserRole + 1,
        AddressRole,
        PhoneNumberRole
    };

public:
    explicit TravelAgentsModel(QObject *parent = nullptr);

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;
    
    std::map<QString, QVector<TravelAgentInfo>> readTravelAgents();
    Q_INVOKABLE void getTravelAgentsOfNeededCity(QString city);
    QVector<QString> getCitiesWithTravelAgents();
    

private:
    std::map<QString, QVector<TravelAgentInfo>> _allTravelAgents;
    QVector<TravelAgentInfo> _travelAgentsOfNeededCity;
};

#endif // TRAVELAGENTSMODEL_HPP
