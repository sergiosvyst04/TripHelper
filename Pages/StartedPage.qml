import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.10
import "../Singletons"
import "../Components"

BasePage {
    header: Item{}
    footer: Item {}

    ColumnLayout {
        spacing: 31
        anchors {
            fill: parent
            topMargin: 36
            leftMargin: 56
            rightMargin: 56
            bottomMargin: 44
        }

        Image {
            Layout.alignment: Qt.AlignHCenter
            source: "qrc:/images/assets/emblem.png"
            sourceSize: Qt.size(280, 200)
        }

        PrimaryLabel {
            Layout.topMargin: 50
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("Make your \n trips \n unforgetable")
        }

        Item {
            Layout.fillHeight: true
        }

        ColoredButton {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 240
            Layout.preferredHeight: 44
            color: Colors.white
            text: qsTr("Sign up")
            fontColor: Colors.primaryColor
            back.border.width: 2
            back.border.color: Colors.primaryColor
            onClicked: navigateToItem("qrc:/Pages/CreateAccountPage.qml")
        }

        ColoredButton {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 240
            Layout.preferredHeight: 44
            color: Colors.primaryColor
            text: qsTr("Log in")
            fontColor: Colors.white
        }

    }

}
