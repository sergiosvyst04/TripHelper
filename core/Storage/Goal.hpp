#ifndef GOAL_HPP
#define GOAL_HPP
#include <QString>
#include <QDateTime>
#include <QTimer>
#include <QDebug>

struct Goal{
    std::string city;
    std::string country;
    QDateTime depatureDate;
};

Q_DECLARE_METATYPE(Goal);

#endif // GOAL_HPP
