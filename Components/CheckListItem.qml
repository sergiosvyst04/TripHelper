import QtQuick 2.10
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import "../Singletons"
import "../Components"

ColumnLayout {
    property alias group: questionText.text
    property alias things: repeater.model
    property bool isPackItem: false

    spacing: 0
    ColoredButton {
        id: btn
        Layout.fillWidth: true
        implicitHeight: 55
        checkable: true
        layer.enabled: false

        color: Colors.lightgrey


        RowLayout {
            anchors {
                fill: parent
                leftMargin: 20
                rightMargin: 15
            }
            Text {
                id: questionText
                font: Fonts.openSans(14, Font.MixedCase)
            }
            Item {
                Layout.fillWidth: true
            }

            PrimaryLabel {
                text: btn.checked ? "—" : "+"
                font: Fonts.openSans(25)
            }
        }
    }


    Rectangle {
        id: answerText
        Layout.fillWidth: true
        Layout.preferredHeight: col.height
        visible: btn.checked ? true : false
        radius: 32

        color: Colors.checkboxColor

        ColumnLayout {
            id: col
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right

                topMargin: 10
                leftMargin: 20
                rightMargin: 20
            }

            spacing: 10

            Component {
                id: toPackDelegate

                RowLayout {
                    DescriptionText {
                        id: thing
                        text: modelData
                    }

                    Item {
                        Layout.fillWidth: true
                    }

                    Loader {
                        id: loader
                        sourceComponent: addBtn

                        Component {
                            id: addBtn
                            ColoredButton {
                                id: btn
                                implicitHeight: 30
                                checkable: true
                                color: Colors.addToListButtonColor
                                layer.enabled: false
                                text: qsTr("Add to list")
                                fontColor: Colors.white
                                font: Fonts.openSansBold(11, Fonts.Mixed)
                                onClicked : {
                                    packer.addItemToList(thing.text)
                                    amin.running = true
                                }


                                NumberAnimation {
                                    id: amin
                                    target: btn
                                    property: "opacity"
                                    duration: 300
                                    from: 1.0
                                    to: 0
                                    running: false
                                    onStopped: loader.sourceComponent = removebtn
                                }
                            }
                        }


                        Component {
                            id: removebtn
                            ColoredButton {
                                implicitHeight: 30
                                checkable: true
                                color: Colors.redButtonColor
                                layer.enabled: false
                                text: qsTr("Remove from list")
                                fontColor: Colors.white
                                font: Fonts.openSansBold(10, Fonts.Mixed)

                                onClicked : {
                                    packer.removeItem(thing.text)
                                    loader.sourceComponent = addBtn
                                }
                            }
                        }
                    }
                }
            }


            Component {
                id: toDoDelegate

                RowLayout {
                    spacing: 10
                    Image {
                        sourceSize: Qt.size(20, 20)
                        source: "qrc:/images/assets/icons/apply.png"
                    }

                    DescriptionText {
                        text: modelData
                    }
                }
            }

            Repeater {
                id: repeater
                delegate: isPackItem ? toPackDelegate : toDoDelegate

            }
        }
    }

    Item {
        Layout.fillHeight: true
    }

}
