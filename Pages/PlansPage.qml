import QtQuick 2.13
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import "../Singletons"
import "../Components"

BasePage {
    footer: Item{}

    ColumnLayout {
        anchors {
            fill: parent
            rightMargin: 26
            leftMargin: 26
        }

        PrimaryLabel {
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("My plans")
        }

        Image {
            Layout.alignment: Qt.AlignHCenter
            sourceSize: Qt.size(180, 160)
            source: "qrc:/images/assets/icons/Humans-11-11-512.png"
            opacity: 0.4
        }

        ListView {
            id: listView
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            spacing: 20
            model: goalsModel

            delegate:  PlanItem {
                width: parent.width
                height: 100
                countryAndCity: qsTr("%1, %2").arg(model.country).arg(model.city)
                depatureDate: model.depatureDate
//                timeLeft: goalsModel.calculateTimeLeft()
            }
        }
    }
}
