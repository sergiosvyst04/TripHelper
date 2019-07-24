import QtQuick 2.10
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.10
import QtMultimedia 5.13
import "../Singletons"
import "../Components"

RowLayout {
    Layout.alignment: Qt.AlignHCenter

    spacing: 30
    anchors {
        leftMargin: 91
        rightMargin: 70
    }

    Image {
        source: "qrc:/images/assets/white icons/flash.png"
        sourceSize: Qt.size(32, 32)

        MouseArea {
          anchors.fill: parent
          onClicked: {

          }
        }
    }

    Item {

        Layout.preferredHeight: 60
        Layout.preferredWidth: 60
        Loader {
            id: loader
            anchors.fill: parent
            sourceComponent: pathView.currentIndex === 0 ? photoButton : videoButton

            Component {
                id: photoButton

                ColoredButton {
                    Layout.alignment: Qt.AlignVCenter
                    Layout.preferredHeight: 60
                    Layout.preferredWidth: 60

                    onClicked: {
                        anim.running = true
                        camera.imageCapture.capture()
                    }

                    SequentialAnimation {
                        id: anim
                        running: false
                        NumberAnimation {
                            target: whiteRect
                            properties: "width"
                            from: whiteRect.width
                            to: whiteRect.width - 8
                            duration: 100
                        }

                        NumberAnimation {
                            target: whiteRect
                            properties: "width"
                            from: whiteRect.width - 8
                            to: whiteRect.width
                            duration: 100
                        }
                    }

                    background: Rectangle {
                        anchors.fill: parent
                        color: "lightgrey"
                        radius: 30

                        Rectangle {
                            id: whiteRect
                            anchors.centerIn: parent
                            width: 45
                            height: width
                            radius: 22.5
                            color: Colors.white
                        }
                    }
                }

            }

            Component {
                id: videoButton

                ColoredButton {

                    Layout.alignment: Qt.AlignVCenter
                    Layout.preferredHeight: 60
                    Layout.preferredWidth: 60

                    NumberAnimation {
                        id: anim2
                        running: false
                        target: redRect
                        properties: "width"
                        from: 10
                        to: 30
                        duration: 150
                    }

//                    onClicked: {
//                        camera.videoRecorder.record()
//                    }
                    onPressed: {
                        console.log("pressed")
                        camera.videoRecorder.record()
                    }

                    onReleased: {
                        console.log("released")
                        camera.videoRecorder.stop()
                    }


                    background: Rectangle {
                        anchors.fill: parent
                        color: "lightgrey"
                        radius: 30

                        Rectangle {
                            anchors.centerIn: parent
                            width: 45
                            height: width
                            radius: 22.5
                            color: Colors.white

                            Rectangle {
                                id: redRect
                                anchors.centerIn: parent
                                width: 30
                                height: width
                                radius: 15
                                color: Colors.recColor
                            }
                        }
                    }

                    Component.onCompleted: {
                        anim2.running = true
                    }
                }

            }
        }
    }


    Image {
        Layout.leftMargin: 20
        source: "qrc:/images/assets/white icons/cameraarrows.png"
        sourceSize: Qt.size(35, 40)
    }
}
