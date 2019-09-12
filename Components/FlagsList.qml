import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import "../Singletons"
import "../Components"

ListView {
    id: listView
    spacing: 30

    highlightRangeMode: ListView.StrictlyEnforceRange
    preferredHighlightBegin: width / 2 - 20
    preferredHighlightEnd: width / 2 + 20

    currentIndex: count / 2

    orientation: ListView.Horizontal
    delegate: Item {
        width: countryName.width
        height: 40
        ColumnLayout {
            id: countryItem
            spacing: 1
            Image {
                Layout.alignment: Qt.AlignHCenter
                source: model.flag
                sourceSize: Qt.size(30, 22)
            }

            DescriptionText {
                id: countryName
                Layout.alignment: Qt.AlignHCenter
                text: model.country
            }
        }

        DescriptionText {
            anchors {
                left: countryItem.right
                leftMargin: 10
                verticalCenter: countryItem.verticalCenter
            }
            visible: index === listView.count - 1 ? false : true
            font: Fonts.openSansBold(22)
            text: "-"
        }
    }
}
