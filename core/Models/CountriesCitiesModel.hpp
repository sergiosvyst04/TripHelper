#ifndef COUNTRIESCITIESMODEL_HPP
#define COUNTRIESCITIESMODEL_HPP

#include <QAbstractListModel>
#include <QMap>
#include <QFile>


class CountriesCitiesModel : public QAbstractListModel
{
    Q_OBJECT

    enum LocationsRole {
        LocationRole = Qt::UserRole + 1
    };

public:
    explicit CountriesCitiesModel(QObject *parent = nullptr);

    // Basic functionality:
    QMap<QString, QVector<QString>> getData();
    Q_INVOKABLE  void getCountries();
    Q_INVOKABLE void getCities(QString country);

    Q_INVOKABLE void setCitiesWithTravelAgents(QVector<QString> citiesWithAgents);



    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

public slots:
    void getVisitedLocations(QVector<QString> visitedCountries);

private:
    QMap<QString, QVector<QString>> _dataMap;
    QVector<QString> _locations;
};

#endif // COUNTRIESCITIESMODEL_HPP
