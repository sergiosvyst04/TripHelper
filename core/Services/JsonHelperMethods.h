#ifndef JSONHELPERMETHODS_H
#define JSONHELPERMETHODS_H

#include <QJsonArray>
#include <QJsonDocument>
#include <QFile>

namespace JsonHelperMethods {

inline QJsonArray readJsonFile(const QString &filePath) {
    QFile file(filePath.toUtf8());
    if(file.open(QFile::ReadOnly | QIODevice::Text)) {
        QString jsonData = file.readAll();
        QJsonDocument jsonDoc = QJsonDocument::fromJson(jsonData.toUtf8());

        file.close();
        return jsonDoc.array();
    }
    return QJsonArray();
}

}

#endif // JSONHELPERMETHODS_H

