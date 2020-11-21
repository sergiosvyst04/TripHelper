import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12
import "../Singletons"

TextField {
    id: control
    property bool isPassword: false
    property var validator: undefined
    property bool validated: validator === undefined
    property bool __firstFocused: false


    signal hasNotValidated()

    onFocusChanged: {
        if(!focus && !textField.validated && text.length > 0)
            hasNotValidated()
    }

    Material.accent: "red"

    leftPadding: 20
    font: Fonts.openSans(14)
    color: Colors.descriptionTextColor
    width: parent.width
    height: 30
    echoMode: isPassword ? TextInput.Password : TextInput.Normal
    passwordMaskDelay: 100
    passwordCharacter: "*"

    background:  Rectangle {
        opacity: .7
        anchors.bottom: parent.bottom
        color: Colors.primaryColor
        height: 1
        width: parent.width

    }

    onTextChanged:  {
        if(validator !== undefined) {
            validated = validator(text);
        }
    }

    Item {
        id: icon
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 10
        width: 20
        height: 20

        Image {
            visible: isPassword
            opacity: 0.8
            source: echoMode === TextField.Normal ? "qrc:/images/assets/icons/eye-open-grey.png" : "qrc:/images/assets/icons/eye-closed-grey.png"
            sourceSize: Qt.size(25, 25)
            anchors.centerIn: parent
            MouseArea {
                anchors.fill: parent
                onClicked:  echoMode = echoMode == TextInput.Normal ? TextInput.Password : TextInput.Normal
            }

        }
    }


}
