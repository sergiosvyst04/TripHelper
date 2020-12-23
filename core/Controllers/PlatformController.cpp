#include "PlatformController.h"
#include <core/Platform/Platform.h>

PlatformController::PlatformController(const Platform &platform, QObject *parent)
    : _platform(platform),
      QObject(parent)
{

}
