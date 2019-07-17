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

    rightPadding: 40
    font: Fonts.openSans(14)
    width: parent.width
    height: 30
    echoMode: isPassword ? TextInput.Password : TextInput.Normal
    passwordMaskDelay: 100
    passwordCharacter: "*"

    background:  Rectangle {
        opacity: .7
        anchors.bottom: parent.bottom
        color: __firstFocused ? Colors.primaryColor : Colors.descriptionTextColor
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
            visible: extraTextStack.currentIndex === 2
            source: "qrc:/images/assets/icons/519791-101_Warning-512.png"
            sourceSize: Qt.size(26, 23)
            anchors.centerIn: parent
        }
    }


}
