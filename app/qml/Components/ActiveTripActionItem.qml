import QtQuick 2.10
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import "../Singletons"
import "../Components"

ColoredButton {
    property alias image: image.source
    property alias text1: action
    property alias actionText: action.text
    layer.enabled: false
    background: Rectangle {
        radius: 28
        gradient: Gradient {
            GradientStop { position: 0.0; color: Colors.blue }
            GradientStop { position: 1.0; color: Colors.lightBlue }
        }
    }

    RowLayout {
        anchors {
            fill: parent
            leftMargin: 25
            topMargin: 10
            bottomMargin: 10
            rightMargin: 15
        }

        Image {
            id: image
            sourceSize: Qt.size(33, 33)
        }

        Item {
            Layout.fillWidth: true
        }

        DescriptionText {
            id: action
            font: Fonts.openSansBold(13, Font.MixedCase)
            color: Colors.white
        }

        Item {
            Layout.fillWidth: true
        }
    }
}
