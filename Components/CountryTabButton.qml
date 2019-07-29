import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import "../Singletons"
import "../Components"

TabButton {
    id: tabBtn
    clip: false
    contentItem: DescriptionText {
        font: parent.checked ? Fonts.openSansBold(10, Font.MixedCase)
                             : Fonts.openSans(10, Font.MixedCase)
        textFormat: Text.PlainText
        text: parent.text
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color: Colors.descriptionTextColor
        layer.enabled: true
        layer.effect: DropShadow {
            color: "lightgrey"
            horizontalOffset: 0
            verticalOffset: 5
            radius: 3
            samples: 7
        }
    }

    background: Rectangle {
        anchors.fill: parent
        color: "transparent"
        Rectangle {
            height: tabBtn.checked ? 3 : 2
            width: parent.width
            color: Colors.primaryColor
            opacity: tabBtn.checked ? 1 : 0.6
            anchors.bottom: parent.bottom
        }
    }
}
