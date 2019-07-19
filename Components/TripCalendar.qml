import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.10
import "../Singletons"
import "../Components"

Calendar {
    id: calendar
    frameVisible: false
    style: CalendarStyle {
        gridVisible: false


        dayDelegate: Rectangle {
            id: dayRect
            radius: 14
            opacity: 0.9
            color: styleData.selected ? Colors.primaryColor : Colors.white

            onColorChanged: {
                if(styleData.selected)
                    anim.running = true
            }

            NumberAnimation {
                id: anim
                target: dayRect
                properties: "width"
                from: 0
                to: dayRect.width
                duration: 200
                running: false
            }

            Label {
                anchors.centerIn: parent
                text: styleData.date.getDate()
                color: styleData.selected ? Colors.white : Colors.descriptionTextColor
                font.weight: styleData.visibleMonth ? Font.Medium : Font.ExtraLight
                opacity: styleData.valid ? 1 : 0.4

            }
        }



        navigationBar: RoundedRect {
            height: 40
            width: parent.width
            corners.topLeftRadius: 28
            corners.topRightRadius: 28
            color: "#F2F2F2"

            RowLayout {
                anchors {
                    fill : parent
                    rightMargin: 40
                    leftMargin: 40
                }


                Image {
                    source : "qrc:/images/assets/icons/rightArrow.png"
                    sourceSize: Qt.size(30, 20)
                    rotation: 180
                    MouseArea {
                        anchors.centerIn: parent
                        height: parent.height * 2
                        width: parent.width * 4
                        onClicked: calendar.showPreviousMonth()
                    }
                }

                Item {
                    Layout.fillWidth: true
                }

                Label {
                    text: styleData.title
                    color: Colors.descriptionTextColor
                }

                Item {
                    Layout.fillWidth: true
                }


                Image {
                    source : "qrc:/images/assets/icons/rightArrow.png"
                    sourceSize: Qt.size(30, 20)

                    MouseArea {
                        anchors.centerIn: parent
                        height: parent.height * 2
                        width: parent.width * 4
                        onClicked: calendar.showNextMonth()
                    }
                }



            }

        }



            background: Rectangle {
                radius: 28
                layer.enabled: true
                layer.effect:  DropShadow {
                    color: "lightgrey"
                    horizontalOffset: 0
                    verticalOffset: 5
                    radius: 15
                    samples: 12
                }
            }

        }
    }
