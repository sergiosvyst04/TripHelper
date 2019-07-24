import QtQuick 2.10
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import "../Singletons"
import "../Components"

Rectangle {
    id: rect
    property alias name: itemName.text
    property alias applyButton: apply
    property alias rejectButton: reject


    function deleteItem(ind) {
        deleteAnim.running = true
    }

    function packItem(ind) {
        packAnim.running = true
    }

    radius: 28


    NumberAnimation {
        id: packAnim
        target: rect
        properties: "opacity"
        from: 1
        to: 0
        duration: 300
        running: false

        onStopped: {
            backPackItemsModel.append(listItemsModel.get(index))
            listItemsModel.remove(index)
        }
    }

    NumberAnimation {
        id: deleteAnim
        target: rect
        properties: "x"
        from: parent.x
        to: -400
        duration: 200
        running: false

        onStopped:{
            listItemsModel.remove(index)
        }
    }


    NumberAnimation on width {
        id: anim
        target: rect
        from: 0
        to: parent.width
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
