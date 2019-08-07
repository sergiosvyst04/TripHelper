#ifndef QMLUTILS_HPP
#define QMLUTILS_HPP

#include <QObject>
#include <QVariant>


class QMLUtils : public QObject
{
    Q_OBJECT
public:
    explicit QMLUtils(QObject *parent = nullptr);
    virtual ~QMLUtils();

signals:

public slots:
    QVector<QString> calculateRemainigTime(QVariant departureTime);
};

#endif // QMLUTILS_HPP
