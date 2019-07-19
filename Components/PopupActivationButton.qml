import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5
import "../Components"
import "../Singletons"

ColumnLayout {
    spacing: 10
    property alias labelText: label.text
    property alias popupContentItem: popup.contentItem
    property alias popupItem: popup
    property alias fieldText: btn.text
    property alias button: btn


    DescriptionText {
        id: label
        width: parent.width
        font: Fonts.openSans(12, Font.MixedCase)
    }

    ColoredButton {
        id: btn
        Layout.fillWidth: true
        Layout.preferredHeight: 26
        font: Fonts.openSans(14)
        fontColor: Colors.descriptionTextColor

        background:  Rectangle {
            opacity: .7
            anchors.bottom: parent.bottom
            color: Colors.primaryColor
            height: 1
            width: parent.width
        }

        textAlignment: Text.AlignLeft
        leftPadding: 20
        layer.enabled: false

        onClicked: popup.visible = !popup.visible


        Popup {
            id: popup
            background: Item {}
            y: parent.height - 250
            width: parent.width
            height: 300
        }

    }

}
