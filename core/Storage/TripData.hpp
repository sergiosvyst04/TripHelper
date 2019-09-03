#ifndef TRIPDATA_HPP
#define TRIPDATA_HPP
#include "QString"
#include "QDateTime"
#include "TripDay.hpp"
#include "core/Models/BackPackModel.hpp"


struct TripData {
    QString name;
    QDateTime depatureDate;
    QList<TripDay> days;
    BackPackModel *backpack = new BackPackModel();
};

#endif // TRIPDATA_HPP
