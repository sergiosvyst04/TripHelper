#include "PackService.hpp"

PackService::PackService(QObject *parent) : QObject(parent)
{

}

//==============================================================================

void PackService::intialize(ApplicationController *applicationController)
{
    _waitingTrip = applicationController->getTripsManager().getUnCompletedTrip();
    _tripsManager = &applicationController->getTripsManager();
    QVector<BackPackItem> itemsList = applicationController->getTripsManager().getUnCompletedTrip()->backPackList;

    connect(this, &PackService::backpackChanged, _tripsManager, &TripsManager::updateUncompletedTrip);
}

//==============================================================================

void PackService::addItemToList(QString item)
{
    BackPackItem newItem {
        false,
        item
    };
    _waitingTrip->backPackList.push_back(newItem);
    backpackChanged();
}

//==============================================================================

void PackService::removeItem(QString item)
{
    int indexOfItemToBeRemoved = findItemIndex(item);
    _waitingTrip->backPackList.removeAt(indexOfItemToBeRemoved);
    backpackChanged();
}

//==============================================================================

void PackService::packItem(QString itemName)
{
    int indexOfIndexToBePacked = findItemIndex(itemName);
    _waitingTrip->backPackList[indexOfIndexToBePacked].isPacked = true;
    backpackChanged();
}

//==============================================================================

bool PackService::checkIfItemExists(QString itemName)
{
    for(int i = 0; i < _waitingTrip->backPackList.count(); i++)
        if(_waitingTrip->backPackList.at(i).name == itemName)
            return true;
    return false;
}

//==============================================================================

int PackService::findItemIndex(QString itemName)
{
    for( int i = 0; i < _waitingTrip->backPackList.size(); i++)
    {
        if(_waitingTrip->backPackList.at(i).name == itemName)
            return i;
    }
    return 0;
}

//==============================================================================

QVector<BackPackItem> PackService::getBackPackItems() {
    return _waitingTrip->backPackList;
}

