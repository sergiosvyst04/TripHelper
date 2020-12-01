import QtQuick 2.10
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import "../Singletons"
import "../Components"


ColumnLayout {
    spacing: 34
    anchors{
        fill: parent
        topMargin: 10
        rightMargin: 14
        leftMargin: 14
    }

    readonly property var gradientsList: [{begin:"#53A7D7", end: "#51F5FF"}, {begin:"#60FFE2", end: "#7EFF1A"}, {begin:"#FC0101", end: "#752424"}, {begin:"#EA6317", end: "#FFC000"}]

    ProfileAvatarAndDataItem {
        id: profileAvataerAndData
        Layout.fillWidth: true
        Layout.minimumHeight: 135 * ScreenProperties.scaleRatioHeight
    }

    GridLayout {
        Layout.alignment: Qt.AlignHCenter
        columns: 2
        columnSpacing: 24
        rowSpacing: 22

        Repeater {
            model: ListModel {
                ListElement {buttonText: qsTr("Waiting Trip"); destination: "qrc:/Pages/InWaitingTripPage.qml"; image: ""; enabled: function (){ return true /*tripsManager.waitingTripExists*/}}
                ListElement {buttonText: qsTr("Active Trip"); destination: "qrc:/Pages/ActiveTripPage.qml"; image: "qrc:/images/assets/white icons/active.png"; enabled: function() {return  tripsManager.activeTripExists} }
                ListElement {buttonText: qsTr("Completed Trips"); destination: "qrc:/Pages/CompletedTripsPage.qml"; image: "qrc:/images/assets/white icons/completed.png"; enabled: function() { return  true}}
                ListElement {buttonText: qsTr("My goals"); destination: "qrc:/Pages/PlansPage.qml"; image: "qrc:/images/assets/white icons/goal.png"; enabled: function() { return  true}}
            }

            ProfileButton {
                Layout.preferredHeight: 165 * ScreenProperties.scaleRatioHeight
                Layout.preferredWidth:  135 * ScreenProperties.scaleRatioWidth

                enabled: model.enabled()
                opacity: enabled ? 1 : 0.6
                buttonText: model.buttonText
                image: model.image

                background: Rectangle {
                    radius: 28
                    gradient: Gradient {
                        GradientStop {position: 0.0; color: gradientsList[index].begin }
                        GradientStop {position: 1.0; color: gradientsList[index].end }
                    }
                }
                onClicked: navigateToItem(model.destination)
            }
        }
    }
}
