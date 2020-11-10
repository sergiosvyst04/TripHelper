import QtQuick 2.13
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5
import "../Singletons"
import "../Components"
import Trip 1.0
import BackPackModel 1.0
import WaitingTripController 1.0
import com.plm.utils 1.0

BasePage {
    backButtonVisible: true
    footer: Item{}


    Timer {
        interval: 500;
        running: true
        repeat: true
        onTriggered: {
            repeater.itemAt(0).timeLeft = Utils.calculateRemainigTime(waitingController.trip.depatureDate)[0];
            repeater.itemAt(1).timeLeft = Utils.calculateRemainigTime(waitingController.trip.depatureDate)[1];
            repeater.itemAt(2).timeLeft = Utils.calculateRemainigTime(waitingController.trip.depatureDate)[2];
            repeater.itemAt(3).timeLeft = Utils.calculateRemainigTime(waitingController.trip.depatureDate )[3];
        }
    }

    WaitingTripController {
        id: waitingController

        Component.onCompleted: {
            intialize(appController)
            tripName.text = waitingController.trip.name
        }
    }

    ColumnLayout {
        id: waiting
        anchors {
            fill: parent
        }

        spacing: 50

        PrimaryLabel {
            id: tripName
            Layout.alignment: Qt.AlignHCenter
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter
            spacing: 15
            Repeater {
                id: repeater
                model: ["Dayss", "Hours", "Minutes", "Seconds"]

                delegate: ColumnLayout {
                    property alias timeLeft: left.text
                    DescriptionText {
                        id: left
                        Layout.alignment: Qt.AlignHCenter
                        font: Fonts.openSans(18, Font.MixedCase)
                    }

                    DescriptionText {
                        font: Fonts.openSans(18, Font.MixedCase)
                        text: modelData
                    }
                }
            }
        }



        ColoredButton {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 250 * ScreenProperties.scaleRatioWidth
            Layout.preferredHeight: 90 * ScreenProperties.scaleRatioHeight
            text: qsTr("Pack Bag")
            color: Colors.primaryColor
            font: Fonts.openSansBold(18)
            fontColor: Colors.white
            onClicked: navigateToItem("qrc:/Pages/MakeListPage.qml")
        }

        Item {
            Layout.fillHeight: true
        }

    }
}
