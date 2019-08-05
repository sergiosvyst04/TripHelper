#ifndef GOAL_HPP
#define GOAL_HPP
#include <QString>
#include <QDateTime>

struct Goal{
    std::string city;
    std::string country;
    QDateTime depatureDate;
};

#endif // GOAL_HPP
