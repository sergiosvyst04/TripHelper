#ifndef PLATFORM_H
#define PLATFORM_H

#include <QObject>

class Platform : public QObject
{
    Q_OBJECT
public:

    static Platform &Instance();
    virtual QString platformName() const = 0;

signals:
      explicit Platform(QObject *parent = nullptr);
};

#endif // PLATFORM_H
