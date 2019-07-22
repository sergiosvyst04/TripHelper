import QtQuick 2.10
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import "../Components"
import "../Singletons"


ColoredButton {
    id: btn
    property alias buttonText: buttonText1.text

    layer.enabled: false
    RowLayout {
        anchors {
            fill: parent
            rightMargin: 20
        }
        DescriptionText {
            id: buttonText1
            font: Fonts.openSans(14, Font.MixedCase)
            opacity: checked ? 1 : 0.5
        }

        Item {
            Layout.fillWidth: true
        }

        Rectangle {
            Layout.preferredHeight: 23
            Layout.preferredWidth: 23
            radius: 11.5
            color: Colors.checkboxColor

            Image {
                id: checkMark
                anchors.centerIn: parent
                visible: btn.checked ? true : false
                source: "qrc:/images/assets/icons/checkmark-blue.svg"
                sourceSize: Qt.size(30, 30)
            }
        }
    }
}
