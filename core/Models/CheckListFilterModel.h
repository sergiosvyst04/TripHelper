#ifndef CHECKLISTFILTERMODEL_H
#define CHECKLISTFILTERMODEL_H

#include <QSortFilterProxyModel>

class CheckListFilterModel : public QSortFilterProxyModel
{
    Q_OBJECT
    Q_PROPERTY(bool searchPattern READ getSearchPattern WRITE setSearchPattern)

public:
    explicit CheckListFilterModel(QObject *parent = nullptr);

    void setSearchPattern(bool searchPattern);
    bool getSearchPattern();

private:
    bool filterAcceptsRow(int source_row, const QModelIndex &source_parent) const override;
    bool _searchPattern;
};

#endif // CHECKLISTFILTERMODEL_H
