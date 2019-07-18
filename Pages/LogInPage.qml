import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import "../Singletons"
import "../Components"

BasePage {
nextButtonVisible: true
nextButtonText: qsTr("Log In");
nextButtonEnabled: email.validated && password.validated

ColumnLayout {
    anchors {
        fill: parent
        leftMargin: 32
        rightMargin: 32
        bottomMargin: 81
    }

    Image {
        Layout.alignment: Qt.AlignHCenter
        source: "qrc:/images/assets/emblem.png"
        sourceSize: Qt.size(250, 200)
    }

    LabeledTextEdit {
        id: email
        Layout.fillWidth: true
        label: qsTr("Email")
        validator: Utils.validateEmail
        warningText: qsTr("please enter a valid email (e.g johndoe@gmail.com)")
        stackIndex: 0
    }

    LabeledTextEdit {
        id: password
        Layout.fillWidth: true
        label: qsTr("Password")
        states: [
            State {
                name: "wrongPasswordStatt"
                PropertyChanges {
                    target: password
                    validated: false
                }
            }
        ]
        onTextChanged: {
            if(state == "wrongPasswordState"){
                state = ""
            }
        }

        usePasswordMask: true
        validator: Utils.validatePassword
    }

    DescriptionText {
        Layout.alignment: Qt.AlignHCenter
        text: qsTr("Forgot password?")
        font: Fonts.openSansBold(13, Font.MixedCase)
        MouseArea {
            anchors.centerIn: parent
            width: parent.width * 2
            height: parent.height * 2

            onClicked:  {
               navigateToItem("qrc:/Pages/ResetPasswordPage.qml")
            }
        }
    }
}


}
