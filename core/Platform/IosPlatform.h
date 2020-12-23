#ifndef IOSPLATFORM_H
#define IOSPLATFORM_H

#include <QObject>
#include <core/Platform/Platform.h>

class IosPlatform : public Platform
{
    Q_OBJECT
public:
    explicit IosPlatform();
    QString platformName() const override;


signals:

};

#endif // IOSPLATFORM_H
