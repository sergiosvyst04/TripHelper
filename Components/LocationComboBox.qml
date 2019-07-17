import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.10
import "../Singletons"
import "../Components"

ComboBox {
    id: root
    width: parent.width

    model: ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten"]

    delegate: ColoredButton {
        width: parent.width
        layer.enabled: false
        height: 42
        color: index === root.currentIndex ? Colors.checkedDelegateColor : Colors.white

        background: Rectangle {
            anchors.fill: parent
            radius: 4
            color: index === root.currentIndex ? Colors.checkedDelegateColor : Colors.white
            opacity: index === root.currentIndex ? 0.3 : 0
        }

        onClicked: {
            activated(index)
        }

        RowLayout {
            anchors {
                fill: parent
                leftMargin: 22
                topMargin: 10
                bottomMargin: 10
            }

            DescriptionText {
                font: Fonts.openSans(16)
                text: modelData
            }

            Item {
                Layout.fillWidth: true
            }

            Item {
                Layout.fillHeight: true
                Layout.preferredWidth: 39

                Image {
                    anchors.centerIn: parent
                    visible: index == root.currentIndex
                    source: "qrc:/images/assets/icons/checkmark-blue.svg"
                    sourceSize: Qt.size(40, 40)
                }
            }
        }
    }

    background: Rectangle {
        implicitHeight: 200
        implicitWidth: 300
        color: Colors.white

        Rectangle {
            anchors.bottom: parent.bottom
            width: parent.width
            height: 1
            color: Colors.primaryColor
        }
    }

    contentItem: Item {
        anchors.fill: parent
        Text {
            anchors{
                fill: parent
                leftMargin: 20
            }
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            text: root.displayText
            font: Fonts.openSans(14)
            color: Colors.descriptionTextColor
        }
    }

    indicator: Item {}

    popup: Popup {
        width: parent.width
        height: 200
        y: contentItem.y
        leftPadding: 10
        rightPadding: 10
        topPadding: 8
        bottomPadding: 8
        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: root.popup.visible ? root.delegateModel : null
            currentIndex: root.highlightedIndex
        }

        background: Rectangle {
           layer.enabled: true
           layer.effect: DropShadow {
               color: "lightgrey"
               horizontalOffset: 0
               verticalOffset: 5
               radius: 15
               samples: 12
           }
        }
    }

}
