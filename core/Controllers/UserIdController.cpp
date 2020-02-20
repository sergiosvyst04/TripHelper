#include "UserIdController.hpp"
#include "QDebug"

UserIdController::UserIdController(QObject *parent) : QObject(parent)
{

}

//==============================================================================

UserIdController& UserIdController::Instance()
{
    static UserIdController instance;
    return instance;
}

//==============================================================================

QString UserIdController::userId()
{
    return _id.value("userId").toString();
}

//==============================================================================

void UserIdController::setUserId(QString &newId)
{
    _id.setValue("userId", newId);
}


