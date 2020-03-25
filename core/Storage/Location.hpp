#ifndef LOCATION_HPP
#define LOCATION_HPP
#include "QString"

struct Location {
    QString country;
    QString city;

    bool operator== (const Location &a) const {return this->country == a.country && this->city == a.city;}
};

#endif // LOCATION_HPP
