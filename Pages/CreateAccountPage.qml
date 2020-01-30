import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5
import "../Singletons"
import "../Components"

BasePage {
    nextButtonVisible: true
    nextButtonEnabled: emailField.validated && passwordField.validated && confirmPassword.validated && fullName.text.length > 3
    onNextButtonClicked: {
        authService.checkIfUserExists(emailField.text, passwordField.text)
    }
    
    
    Connections {
        target: authService
        onUserExists: {
            if(exists)
            {
                loader.active = true
            } else {
                navigateToItem("qrc:/Pages/CreateAccountNextPage.qml", { userData : {email : emailField.text, password : passwordField.text} })
            }
        }
    }


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
                id: emailField
                Layout.fillWidth: true
                label: qsTr("Email")
                validator: Utils.validateEmail
                approveText: qsTr("Looks great!")
                warningText: qsTr("please enter a valid email (e.g johndoe@gmail.com)")
                stackIndex: 0
            }

            LabeledTextEdit {
                id: passwordField
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
                    if(passwordField.text === confirmPassword.text) {
                        validated = true
                    }
                    else{
                        validated = false
                    }
                }
            }
        }
    }

    Loader {
        id: loader
        active: true

        sourceComponent: Component {
            id: userExistsPopup

            Popup {
                anchors.centerIn: parent

                implicitHeight: 210
                implicitWidth: 232

                padding: 0

                parent: Overlay.overlay
                modal: true
                visible: true

                background: Rectangle {
                    radius: 28
                    gradient: Gradient {
                        GradientStop {position: 0.0; color: Colors.primaryColor }
                        GradientStop {position: 0.45; color: Colors.white }
                    }
                }

                onAboutToHide: loader.active = false

                ColumnLayout {
                    spacing: 20
                    anchors {
                        fill: parent
                        topMargin: 15
                        leftMargin: 24
                        rightMargin: 24
                        bottomMargin: 24
                    }

                    DescriptionText {
                        Layout.alignment: Qt.AlignHCenter
                        Layout.preferredWidth: parent.width
                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                        text: qsTr("Such user already exists.\n Try to login with another data")
                        color: Colors.grey
                        font: Fonts.openSansBold(13, Font.MixedCase)
                    }


                    Item {
                        Layout.fillHeight: true
                    }

                    ColoredButton {
                        Layout.alignment: Qt.AlignHCenter
                        Layout.preferredHeight: 36
                        Layout.preferredWidth: 86
                        color: Colors.primaryColor
                        layer.enabled: false
                        text: qsTr("Go to login")
                        fontColor: Colors.white
                        font: Fonts.openSansBold(13, Font.MixedCase)
                        onClicked: {
                            loader.active = false
                            navigateToItem("qrc:/Pages/CreateAccountNextPage.qml")
                        }
                    }

                    ColoredButton {
                        Layout.alignment: Qt.AlignHCenter
                        Layout.preferredHeight: 36
                        Layout.preferredWidth: 86
                        color: Colors.primaryColor
                        layer.enabled: false
                        text: qsTr("Try again")
                        fontColor: Colors.white
                        font: Fonts.openSansBold(13, Font.MixedCase)
                        onClicked:{
                            loader.active = false
                            passwordField.text = ""
                            emailField.text = ""
                            confirmPassword.text = ""
                        }
                    }
                }
            }
        }
    }

}
