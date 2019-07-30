import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.10
import "../Singletons"
import "../Components"

BasePage {
    backButtonVisible: true
    footer: Item{}

    ColoredButton {
        height: 80
        width: 60
        color: Colors.checkboxColor
        anchors {
            horizontalCenter: parent.left
            verticalCenter: parent.verticalCenter
        }

        Image {
            anchors {
                right: parent.right
                rightMargin: 3
                verticalCenter: parent.verticalCenter
            }

            source: "qrc:/images/assets/icons/front.png"
            sourceSize: Qt.size(25, 25)
            rotation: 90
            opacity: 0.6
        }
        onClicked: swipeView.currentIndex = 0
    }

    ColumnLayout{
        anchors {
            fill: parent
        }

        PrimaryLabel {
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("Trip Name")
        }

        ListView {
            Layout.fillWidth: true
            Layout.leftMargin: 13
            Layout.preferredHeight: 130

            model: 5
            spacing: 12
            orientation: ListView.Horizontal
            delegate: DayDelegate {
                width: 95
                height: parent.height
                dayNumber: qsTr("Day %1").arg(index + 1)
                date: Qt.formatDate(new Date(), "d MMM \n yyyy")
            }
        }


        ColumnLayout {

            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.rightMargin: 73
            Layout.leftMargin: 73
            spacing: 11

            ActiveTripActionItem {
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                image: "qrc:/images/assets/white icons/note.png"
                actionText: qsTr("Add note")
                onClicked: navigateToItem("qrc:/Pages/AddNotePage.qml")
            }

            ActiveTripActionItem {
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                image: "qrc:/images/assets/white icons/idea.png"
                actionText: qsTr("Add new idea")
            }

            ActiveTripActionItem {
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                image: "qrc:/images/assets/white icons/place.png"
                actionText: qsTr("Add favourite place")
            }

            ColoredButton {
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                color: Colors.checkInColor
                text: qsTr("Check-In")
                font: Fonts.openSansBold(13, Font.MixedCase)
                fontColor: Colors.shadowColor
                layer.effect: DropShadow {
                    color: Colors.checkInColor
                    horizontalOffset: 0
                    verticalOffset: 5
                    radius: 7
                    samples: 10
                }
            }

            ColoredButton {
                Layout.fillWidth: true
                Layout.topMargin: 20
                Layout.preferredHeight: 50
                color: Colors.redButtonColor
                text: qsTr("End of trip")
                fontColor: Colors.white
                font: Fonts.openSansBold(13, Font.MixedCase)

                onClicked: navigateToItem("qrc:/Pages/EndTripPage.qml")

                layer.effect: DropShadow {
                    color: Colors.redButtonColor
                    horizontalOffset: 0
                    verticalOffset: 5
                    radius: 7
                    samples: 10
                }
            }
        }
    }
}
