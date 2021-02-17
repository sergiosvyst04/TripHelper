import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import "../Singletons"
import "../Components"

BasePage {
    nextButtonVisible: true
//    nextButtonEnabled:  this line will written after login will be done
    nextButtonText: qsTr("Reset Password")


    ColumnLayout {
        spacing: 35
        anchors {
            fill: parent
            topMargin: 5
            leftMargin: 32
            rightMargin: 32
            bottomMargin: 230
        }

        PrimaryLabel {
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("Forgot Password")
        }

        DescriptionText {
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("We just need your registeredemail to send you\n passwrod reset instructions ")
        }

        Item {
            Layout.fillHeight: true
        }

        LabeledTextEdit {
            Layout.fillWidth: true
            Layout.topMargin: 50
            label: qsTr("Email")
            validator: Utils.validateEmail
            warningText: qsTr("please enter a valid email (e.g johndoe@gmail.com)")
        }
    }

}
