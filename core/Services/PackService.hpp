#ifndef PACKSERVICE_HPP
#define PACKSERVICE_HPP

#include <QObject>
#include "core/Controllers/ApplicationController.hpp"

class PackService : public QObject
{
    Q_OBJECT
public:
    explicit PackService(QObject *parent = nullptr);
    Q_INVOKABLE void intialize(ApplicationController *applicationController);

public slots:
    void addItemToList(QString item);
    void removeItem(QString item);
    void packItem(QString item);
    bool checkIfItemExists(QString itemName);
    QVector<BackPackItem> getBackPackItems();

    int findItemIndex(QString itemName);

signals:
    void backpackChanged();

private:
    TripData *_waitingTrip;
    TripsManager *_tripsManager;
};

#endif // PACKSERVICE_HPP
