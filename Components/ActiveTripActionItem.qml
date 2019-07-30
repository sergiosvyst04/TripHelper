import QtQuick 2.10
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import "../Singletons"
import "../Components"

ColoredButton {
    property alias image: image.source
    property alias text1: action
    property alias actionText: action.text
    color: Colors.primaryColor

    RowLayout {
        anchors {
            fill: parent
            leftMargin: 25
            topMargin: 10
            bottomMargin: 10
        }

        Image {
            id: image
            sourceSize: Qt.size(33, 33)
        }

        DescriptionText {
            id: action
            font: Fonts.openSansBold(13, Font.MixedCase)
            color: Colors.white
        }
    }
}
