#ifndef PLATFORMCONTROLLER_H
#define PLATFORMCONTROLLER_H

#include <QObject>
class Platform;

class PlatformController : public QObject
{
    Q_OBJECT
public:
    explicit PlatformController(const Platform &platform ,QObject *parent = nullptr);

signals:

private:
    const Platform &_platform;
};

#endif // PLATFORMCONTROLLER_H
