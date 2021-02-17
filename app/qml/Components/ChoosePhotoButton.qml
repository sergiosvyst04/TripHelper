import QtQuick 2.10
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import "../Singletons"
import "../Components"

ColoredButton {
    property alias border: backgr.border
    property alias image: image.source

    Layout.preferredHeight: 80
    Layout.preferredWidth: 80


    background:  Rectangle {
        id: backgr
        anchors.fill: parent
        radius: 40
        color: Colors.choiceButtonColor
        border.width: 3
    }

    Image {
        id: image
        anchors.centerIn: parent
        sourceSize: Qt.size(50, 45)
    }
}
