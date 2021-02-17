import QtQuick 2.10
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5
import "../Singletons"
import "../Components"

RowLayout {
    width: 275
    property alias name: agentName.text
    property alias address: address.text

    spacing: 30

    Image {
        source: "qrc:/images/assets/icons/travelagent.png"
        sourceSize: Qt.size(40 * ScreenProperties.scaleRatioWidth, 40 * ScreenProperties.scaleRatioHeight)
        opacity: 0.7
    }


    ColumnLayout {
//        Layout.minimumWidth: 110
        DescriptionText {
            id: agentName
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignLeft
            textFormat: Text.PlainText
            font: Fonts.openSans(14, Font.MixedCase)
            wrapMode: Text.WrapAnywhere
        }

        DescriptionText {
            id: address
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignLeft
            color: Colors.primaryColor
            opacity: 0.7
            textFormat: Text.PlainText
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        }
    }

    Item {
        Layout.fillWidth: true
    }

    Image {
        source: "qrc:/images/assets/icons/call.png"
        sourceSize: Qt.size(30 * ScreenProperties.scaleRatioHeight, 30 * ScreenProperties.scaleRatioHeight)
        MouseArea {
            anchors.fill: parent
            onClicked: console.log("call")
        }
    }
}
