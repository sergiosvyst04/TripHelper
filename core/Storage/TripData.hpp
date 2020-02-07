#ifndef TRIPDATA_HPP
#define TRIPDATA_HPP
#include "QString"
#include "QDateTime"
#include "TripDay.hpp"
#include "core/Models/BackPackModel.hpp"


struct TripData {
    QString name;
    QDateTime depatureDate;
    QVector<TripDay> days;
    QVector<BackPackItem> backPackList;

    void removePhotoByPath(QString path) {
        for(int i = 0; i < days.size(); i++)
        {
            for(int j = 0; j < days.at(i).photos.size(); j++)
            {
                Photo currentPhoto = days.at(i).photos.at(j);
                if(currentPhoto.source == path)
                {
                    days[i].photos.removeAt(j);
                    return;
                }
            }
        }
    }
};

Q_DECLARE_METATYPE(TripData);

#endif // TRIPDATA_HPP
