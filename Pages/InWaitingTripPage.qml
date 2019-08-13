import QtQuick 2.13
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5
import "../Singletons"
import "../Components"
import Trip1 1.0
import com.plm.utils 1.0

BasePage {
    backButtonVisible: true
    footer: Item{}


    Timer {
        interval: 500; running: true; repeat: true
        onTriggered: {
            repeater.itemAt(0).timeLeft = Utils.calculateRemainigTime(waiting.trip.depatureDate)[0];
            repeater.itemAt(1).timeLeft = Utils.calculateRemainigTime(waiting.trip.depatureDate)[1];
            repeater.itemAt(2).timeLeft = Utils.calculateRemainigTime(waiting.trip.depatureDate)[2];
            repeater.itemAt(3).timeLeft = Utils.calculateRemainigTime(waiting.trip.depatureDate)[3];
        }
    }


    StackLayout {
        id: stackView
        anchors.fill: parent
        currentIndex: currentIndex = tripsModel.checkIfWaitingTripexists() ? 1 : 0

        DescriptionText {
            id: noWaitingTrips
            Layout.alignment: Qt.AlignCenter
            text: qsTr("There are no waiting trips...")
        }

        ColumnLayout {
            id: waiting
            Layout.fillHeight: true
            Layout.rightMargin: 45
            Layout.leftMargin: 45

            property Trip trip: tripsModel.getWaitingTrip()

            PrimaryLabel {
                id: tripName
                Layout.alignment: Qt.AlignHCenter
                text: waiting.trip.name
            }

            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 15
                Repeater {
                    id: repeater
                    model: ["Days", "Hours", "Minutes", "Seconds"]

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

            Item {
                Layout.fillHeight: true
            }

            ColoredButton {
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: 250
                Layout.preferredHeight: 90
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

}
