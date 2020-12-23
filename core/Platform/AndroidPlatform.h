#ifndef ANDROIDPLATFORM_H
#define ANDROIDPLATFORM_H

#include <QObject>
#include <core/Platform/Platform.h>

class AndroidPlatform : public Platform
{
    Q_OBJECT
public:
    QString platformName() const override;

signals:

private:
    explicit AndroidPlatform();

};

#endif // ANDROIDPLATFORM_H
