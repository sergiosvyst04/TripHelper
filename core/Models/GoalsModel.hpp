#ifndef GOALSMODEL_HPP
#define GOALSMODEL_HPP

#include <QAbstractListModel>
#include <QVector>
#include "core/Storage/Goal.hpp"

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
    void addGoal(const QString &country, const QString &city, QDateTime depatureDate);

signals:
    void goalAdded();
private:
    QVector<Goal> _goals;
};

#endif // GOALSMODEL_HPP
