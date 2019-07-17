import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5
import "../Singletons"
import "../Components"

BasePage {
    nextButtonVisible: true
    nextButtonEnabled: email.validated && password.validated && confirmPassword.validated && fullName.text.length > 3
    onNextButtonClicked: navigateToItem("qrc:/Pages/CreateAccountNextPage.qml")

    ColumnLayout {
        spacing: 61
        anchors {
            fill: parent
            topMargin: 5
            leftMargin: 30
            rightMargin: 35
            bottomMargin: 88
        }

        PrimaryLabel {
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("Create Account")
        }


        ColumnLayout {
            Layout.fillWidth: true
            LabeledTextEdit {
                id: fullName
                Layout.fillWidth: true
                label: qsTr("Full name")
                warningText: qsTr("Use at least 3 characters")
                validated: fullName.text.length > 2
            }

            LabeledTextEdit {
                id: email
                Layout.fillWidth: true
                label: qsTr("Email")
                validator: Utils.validateEmail
                approveText: qsTr("Looks great!")
                warningText: qsTr("please enter a valid email (e.g johndoe@gmail.com)")
                stackIndex: 0
            }

            LabeledTextEdit {
                id: password
                Layout.fillWidth: true
                label: qsTr("Password")
                validator: Utils.validatePassword
                usePasswordMask: true
                approveText: qsTr("Very good!")
                warningText: qsTr("Use at least 8 characters")
                stackIndex:  0
            }

            LabeledTextEdit {
                id: confirmPassword
                usePasswordMask: true
                Layout.fillWidth: true
                label: qsTr("Confirm Password")
                approveText: qsTr("Excellent!")
                warningText: qsTr("Confirmation does not match")
                stackIndex: 0
                validated: false

                onTextChanged: {
                    if(password.text === confirmPassword.text) {
                        validated = true
                    }
                    else{
                        validated = false
                    }
                }
            }
        }


    }

}
