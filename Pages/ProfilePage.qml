import QtQuick 2.10
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import "../Singletons"
import "../Components"

//BasePage {
//    footer: Item{}
//    header: Item {}

    ColumnLayout {
        spacing: 34
        anchors{
            fill: parent
            topMargin: 10
            rightMargin: 14
            leftMargin: 14
        }

        ProfileAvatarAndDataItem {
            Layout.fillWidth: true
            Layout.minimumHeight: 135
        }

        GridLayout {

            Layout.alignment: Qt.AlignHCenter
            columns: 2
            columnSpacing: 24
            rowSpacing: 22
            ProfileButton {
                Layout.minimumWidth: 138
                Layout.minimumHeight: 168
                color: Colors.primaryColor
                background.opacity: 0.8
            }

            ProfileButton {
                Layout.minimumWidth: 138
                Layout.minimumHeight: 168
                color: Colors.greenButtonColor
                image: "qrc:/images/assets/white icons/active.png"
                buttonText: qsTr("Active trip")
                onClicked: navigateToItem("qrc:/Pages/ActiveTripPage.qml")
            }

            ProfileButton {
                Layout.minimumWidth: 138
                Layout.minimumHeight: 168
                color: Colors.redButtonColor
                background.opacity: 0.75
                image: "qrc:/images/assets/white icons/completed.png"
                buttonText: qsTr("Completed trips")
            }

            ProfileButton {
                Layout.minimumWidth: 138
                Layout.minimumHeight: 168
                color: Colors.yellowButtonColor
                background.opacity: 0.8
                image: "qrc:/images/assets/white icons/goal.png"
                buttonText: qsTr("My goals")
            }
        }

        Item {
            Layout.fillHeight: true
        }
    }
//}
