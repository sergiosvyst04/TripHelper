#ifndef PACKSERVICE_HPP
#define PACKSERVICE_HPP

#include <QObject>
#include "core/Models/BackPackModel.hpp"
#include "core/Controllers/ApplicationController.hpp"

class PackService : public QObject
{
    Q_OBJECT
    Q_PROPERTY(BackPackModel* backpack READ getBackpackModel NOTIFY backpackChanged)
public:
    explicit PackService(QObject *parent = nullptr);
    Q_INVOKABLE void intialize(ApplicationController *applicationController);


signals:
     void backpackChanged();

public slots:
    BackPackModel* getBackpackModel();

    void addItemToList(QString item);
    void removeItem(QString item);
    void packItem(QString item);

    void updateModel();

    bool checkIfItemExists(QString itemName);

    int findItemIndex(QString itemName);



private:
    BackPackModel *_backpackModel;
    TripData *_waitingTrip;
    TripsManager *_tripsManager;
};

#endif // PACKSERVICE_HPP
