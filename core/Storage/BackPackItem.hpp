#ifndef BACKPACKITEM_HPP
#define BACKPACKITEM_HPP
#include <QString>

struct BackPackItem {
    bool isPacked;
    QString name;

    BackPackItem& operator=(const BackPackItem &item) {
        isPacked = item.isPacked;
        name = item.name;
        return *this;
    }
};

Q_DECLARE_METATYPE(BackPackItem);


#endif // BACKPACKITEM_HPP
