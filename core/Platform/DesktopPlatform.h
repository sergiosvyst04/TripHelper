#ifndef DESKTOPPLATFORM_H
#define DESKTOPPLATFORM_H

#include <QObject>
#include <core/Platform/Platform.h>

class DesktopPlatform : public Platform
{
    Q_OBJECT
public:
    explicit DesktopPlatform();
    QString platformName() const override;

signals:

};

#endif // DESKTOPPLATFORM_H
