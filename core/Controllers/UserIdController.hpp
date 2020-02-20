#ifndef USERIDCONTROLLER_HPP
#define USERIDCONTROLLER_HPP

#include <QObject>
#include <QSettings>

class UserIdController : public QObject
{
    Q_OBJECT
public:
    static UserIdController& Instance();
    QString userId();
    void setUserId(QString &newId);

protected:
    explicit UserIdController(QObject *parent = nullptr);
signals:

public slots:

private:
    QSettings _id;
};

#endif // USERIDCONTROLLER_HPP
