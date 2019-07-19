import QtQuick 2.10
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import "../Singletons"
import "../Components"

//BasePage {
//    footer: Item{height: 80}
//    header: Item{}

    ColumnLayout {
        spacing: 15
        anchors {
            fill: parent
            leftMargin: 40
            rightMargin: 40
        }

        Image {
            Layout.alignment: Qt.AlignHCenter
            source: "qrc:/images/assets/emblem.png"
            sourceSize: Qt.size(200, 165)
        }

        Flickable {
            id: flickable

            boundsBehavior: Flickable.StopAtBounds
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            contentHeight: column.height
            contentWidth: column.width
            bottomMargin: 10

            ColumnLayout {
                id: column
                spacing: 15
                width: flickable.width

                HomeActionButton {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.minimumWidth: column.width - 10
                    Layout.minimumHeight: 105
                    image: "qrc:/images/assets/white icons/startbtn.png"
                    actionText: qsTr("Start trip")
                    onClicked: navigateToItem("qrc:/Pages/StartTripPage.qml")
                }

                HomeActionButton {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.minimumWidth: column.width - 10
                    Layout.minimumHeight: 105
                    image: "qrc:/images/assets/white icons/goals.png"
                    actionText: qsTr("Add goal")
                    onClicked: navigateToItem("qrc:/Pages/AddGoalPage.qml")
                }

                HomeActionButton {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.minimumWidth: column.width - 10
                    Layout.fillWidth: true
                    Layout.minimumHeight: 105
                    image: "qrc:/images/assets/white icons/organizat help.png"
                    actionText: qsTr("Organization<br>help")
                }

                HomeActionButton {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.minimumWidth: column.width - 10
                    Layout.minimumHeight: 105
                    image: "qrc:/images/assets/white icons/settings.png"
                    actionText: qsTr("Settings")
                }
            }
        }
    }
//}
