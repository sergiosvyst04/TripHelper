#ifndef GOALSMODEL_HPP
#define GOALSMODEL_HPP

#include <QAbstractListModel>
#include <QVector>
#include "core/Storage/Goal.hpp"
#include <core/Storage/DataBaseStorage.hpp>
#include <core/Controllers/ApplicationController.hpp>

class GoalsModel : public QAbstractListModel
{
    Q_OBJECT

    enum GoalRoles {
        CountryRole = Qt::UserRole + 1,
        CityRole,
        DepatureDate,
    };

public:
    explicit GoalsModel(QObject *parent = nullptr);

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

public slots:
    void intialize(ApplicationController *applicationController);
    void readGoals();


signals:

private:
    DataBaseStorage *_dbStorage;
    QVector<Goal> _goals;
};

#endif // GOALSMODEL_HPP
