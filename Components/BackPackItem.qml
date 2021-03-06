import QtQuick 2.10
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import "../Singletons"
import "../Components"

Rectangle {
    id: root
    property alias name: itemName.text
    property alias applyButton: apply
    property alias rejectButton: reject


    function deleteItem() {
        deleteAnim.running = true
    }

    function packItem() {
        packAnim.running = true
    }

    radius: 28


    NumberAnimation {
        id: packAnim
        target: root
        properties: "opacity"
        from: 1
        to: 0
        duration: 300
        running: false

        onStopped: {
            packer.packItem(name)
        }
    }

    NumberAnimation {
        id: deleteAnim
        target: root
        properties: "x"
        from: root.x
        to: -400
        duration: 200
        running: false

        onStopped:{
            packer.removeItem(name)
        }
    }


    NumberAnimation on width {
        id: anim
        target: root
        from: 0
        to: root.width
        duration: 700
        running: false
    }

    RowLayout {
        spacing: 10
        anchors {
            fill: parent
            leftMargin: 20
            rightMargin: 15
        }

        DescriptionText {
            id: itemName
            font: Fonts.openSans(17, Font.MixedCase)
        }

        Item {
            Layout.fillWidth: true
        }

        ColoredButton {
            id: apply
            layer.enabled: false
            color: "transparent"
            Layout.alignment: Qt.AlignVCenter
            Layout.preferredHeight: 40
            Layout.preferredWidth: 40
            Image {
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/images/assets/icons/apply.png"
                sourceSize: Qt.size(30, 30)
            }

        }

        ColoredButton {
            id: reject
            layer.enabled: false
            color: "transparent"
            Layout.preferredHeight: 35
            Layout.preferredWidth: 35
            Image {
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/images/assets/icons/minus.png"
                sourceSize: Qt.size(35, 30)
            }
        }
    }
}
