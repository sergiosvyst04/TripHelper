import QtQuick 2.10
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import "../Components"
import "../Singletons"

ColoredButton {
    property alias image: buttonImage.source
    property alias buttonText: buttonText.text

    ColumnLayout {
        spacing: 25
        anchors {
            fill: parent
            topMargin: 27
            bottomMargin: 40
        }

        Image {
            id: buttonImage
            Layout.leftMargin: 34
            Layout.rightMargin: 34
            sourceSize: Qt.size(68, 68)
        }

        DescriptionText {
            id: buttonText
            Layout.alignment: Qt.AlignHCenter
            color: Colors.white
            font: Fonts.openSans(15, Font.MixedCase)
        }

    }

}
