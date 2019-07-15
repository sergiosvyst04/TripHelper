import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.10
import "../Singletons"
import "../Components"

Button {
    id: root
    property alias color: back.color
    property alias fontColor: textItem.color
    property alias textAlignment: textItem.horizontalAlignment
    property alias back: back




    font: Fonts.openSansBold(16, Font.Mixed)
    background: Rectangle {
        id: back
        anchors.fill: parent
        radius: 28
    }

    layer.enabled: true
    layer.effect: DropShadow {
        id: shadow
        color: Colors.shadowColor
        horizontalOffset: 0
        verticalOffset: 5
        radius: 7
        samples: 10
    }


    contentItem: Text {
        id: textItem
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text: root.text
        font: root.font
    }
}
