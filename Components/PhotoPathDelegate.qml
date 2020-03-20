import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import "../Singletons"

Item {
    id: photoDelegate

    states: [
        State {
            name: "holded"
            PropertyChanges {
                target: photoDelegate
                width: PathView.isCurrentItem ? 250 : 85
                height: PathView.isCurrentItem ? 250 : 75
                z : PathView.isCurrentItem ? 100 : 0
            }
        }
    ]

    Image {
        anchors.fill: parent
        source:  model.source
        fillMode: Image.PreserveAspectCrop
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onPressAndHold: photoDelegate.state = "holded"
        onReleased: photoDelegate.state = ""
    }
}
