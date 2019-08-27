#ifndef TRIPDAY_HPP
#define TRIPDAY_HPP
#include <QString>
#include <QVector>
#include "Photo.hpp"

struct TripDay {
    std::vector <Photo> photos;
    std::vector <std::string> notes;
    std::vector <std::string> ideas;
    std::vector <std::string> cities;
    std::vector <std::string> countries;
};

Q_DECLARE_METATYPE(TripDay);

#endif // TRIPDAY_HPP
