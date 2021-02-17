import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import "../Singletons"
import "../Components"

Popup {
    default property alias contents: popupContent.data
    property var popupColor
    property alias title: title

    visible: true
    modal: true
    parent: Overlay.overlay
    anchors.centerIn: parent


    onClosed: unloadFromMainLoader()

    background: Rectangle {
        radius: 28
        gradient: Gradient {
            GradientStop { position: 0.0; color: popupColor}
            GradientStop { position: 1.0; color: Colors.white }
        }
    }

    contentItem: ColumnLayout {
        id: popupContent
        anchors {
            fill: parent
            topMargin: 20
            leftMargin: 30
            rightMargin: 30
            bottomMargin: 30
        }

        DescriptionText {
            id: title
            Layout.fillWidth: true
            textFormat: Text.PlainText
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        }
    }
}
