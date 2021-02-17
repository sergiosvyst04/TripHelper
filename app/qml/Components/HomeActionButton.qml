import QtQuick 2.10
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import "../Singletons"
import "../Components"

ColoredButton {
    id: btn
    property alias image: image.source
    property alias actionText: action.text
    layer.enabled: false

    background:  Rectangle {
        radius: 28
        gradient: Gradient {
            GradientStop {position: 0.0; color: Colors.blue }
            GradientStop { position: 1.0; color: btn.enabled ? Colors.lightBlue : Colors.blue}
        }
    }

    RowLayout {
        anchors {
            fill: parent
            leftMargin: 23
            topMargin: 27
            bottomMargin: 27
        }

        Image {
            id: image
            sourceSize: Qt.size(53, 53)
        }

        DescriptionText {
            id: action
            Layout.fillWidth: true
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font: Fonts.openSansBold(22, Font.MixedCase)
            color: Colors.white
        }
    }
}
