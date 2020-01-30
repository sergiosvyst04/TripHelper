#ifndef USERACCOUNTCONTROLLER_HPP
#define USERACCOUNTCONTROLLER_HPP

#include <QObject>

class UserAccountController : public QObject
{
    Q_OBJECT
public:
    explicit UserAccountController(QObject *parent = nullptr);

signals:

public slots:
};

#endif // USERACCOUNTCONTROLLER_HPP
