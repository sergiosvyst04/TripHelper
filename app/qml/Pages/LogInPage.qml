import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import "../Singletons"
import "../Components"

BasePage {
    nextButtonVisible: true
    nextButtonText: qsTr("Log In");
    nextButtonEnabled: email.validated && password.validated

    onNextButtonClicked: {
        authService.checkIfUserExists(email.text, password.text)
    }

    Connections {
        target: authService

        onUserExists: {
            if(exists)
            {
                authService.signIn(email.text, password.text)
            }
        }
    }

    Connections {
        target: authService

        onSignedIn: {
            userAccountController.getUserInfo()
            loadingImage.visible = true
            loadingEffect.running = true
        }

    }

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
            sourceSize: Qt.size(250 * ScreenProperties.scaleRatioWidth, 200 * ScreenProperties.scaleRatioHeight)
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

    Image {
        id: loadingImage
        anchors.centerIn: parent
        visible: false
        sourceSize: Qt.size(80 * ScreenProperties.scaleRatioWidth, 80 * ScreenProperties.scaleRatioHeight)
        source: "qrc:/images/assets/icons/loading.png"
    }

    NumberAnimation {
        id: loadingEffect
        target: loadingImage
        property: "rotation"
        from: 0
        to: 99
        duration: 500
        running: false
        onStopped: {
            navigateToFirst()
            replaceView("qrc:/Pages/MainPage.qml")
        }
    }


}
