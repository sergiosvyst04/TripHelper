import QtQuick 2.10
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5
import "../Singletons"
import "../Components"

BasePage {
    id: root
    nextButtonVisible: true
    nextButtonText: qsTr("Get")
    nextButtonEnabled: buttonsGroup.checkState !== Qt.Unchecked
    nextButton.onClicked:{
        loader.active = true
        fillModel(buttonsGroup.buttons, ticketsModel)
    }
    function fillModel(buttons, model) {
        for(var i = 0; i < buttons.length; i++)
        {
            if(buttons[i].checked)
                model.append({text : buttons[i].text1, destination: buttons[i].destination})
        }
        console.log(model.length)
    }

    ColumnLayout {
        spacing: 30
        anchors{
            fill: parent
            topMargin: 5
            bottomMargin: 120
            leftMargin: 30
            rightMargin: 30
        }

        PrimaryLabel {
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("What do you need?")
        }

        Image {
            Layout.alignment: Qt.AlignHCenter
            source: "qrc:/images/assets/icons/reserve.png"
            sourceSize: Qt.size(160, 145)
            opacity: 0.3
        }

        ButtonGroup {
            id: buttonsGroup
            buttons: buttonsColumn.children
            exclusive: false
        }

        ColumnLayout {
            id: buttonsColumn

            spacing: 25
            Layout.topMargin: 10

            CheckButton {
                Layout.fillWidth: true
                checkable: true
                buttonText: qsTr("I need tickets on plane")
                property string text1: qsTr("get tickets on plane")
                property string destination: "qrc:/Pages/MainPage.qml"
            }

            CheckButton {
                Layout.fillWidth: true
                checkable: true
                buttonText: qsTr("I need tickets on bus")
                property string text1: qsTr("get tickets on bus")
                property string destination: "qrc:/Pages/CreateAccountPage.qml"
            }

            CheckButton {
                Layout.fillWidth: true
                checkable: true
                buttonText: qsTr("I need book a hotel")
                property string text1: qsTr("book hotel")
                property string destination: "qrc:/Pages/MainPage.qml"
            }
        }

        ListModel {
            id: ticketsModel
        }

        Loader {
            id: loader
            active: false

            sourceComponent:  Popup {
                visible: true
                modal: true
                implicitWidth: 250
                implicitHeight: 270
                bottomPadding: 150
                parent: Overlay.overlay
                anchors.centerIn: parent

                background: Rectangle {
                    anchors.fill: parent
                    radius: 28
                    gradient: Gradient {
                        GradientStop {position: 0.0; color: Colors.primaryColor }
                        GradientStop {position: 0.3; color: Colors.white  }
                    }


                        DescriptionText {
                            anchors {
                                top: parent.top
                                topMargin: 20
                                horizontalCenter: parent.horizontalCenter
                            }
                            font: Fonts.openSansBold(14, Font.MixedCase)
                            textFormat: Text.PlainText
                            text: qsTr("We found several options\n for you")
                        }

                }

                contentItem: Item {
                    anchors.topMargin: 90
                    anchors.top: parent.top
                    width: 180
                    height: 80

                    ListView {
                        id: listView
                        anchors.fill: parent
                        model: ticketsModel
                        spacing: 10

                        delegate: ColoredButton {
                            id: btn
                            width: parent.width
                            checkable: true
                            checked: false
                            layer.enabled: false
                            height: 42

                            onClicked: navigateToItem(model.destination)


                            background: Rectangle {
                                anchors.fill: parent
                                radius: 4
                                color: btn.checked ? Colors.checkedDelegateColor : Colors.white
                                opacity: btn.checked ? 0.3 : 1
                                Rectangle {
                                    anchors {
                                        topMargin: 5
                                        top:  parent.bottom
                                    }
                                    width: parent.width
                                    height: 1
                                    color: Colors.lightgrey
                                    visible: index === listView.count - 1 ? false : true
                                }
                            }

                            RowLayout {
                                anchors {
                                    fill: parent
                                    leftMargin: 10
                                    rightMargin: 10
                                    topMargin: 10
                                    bottomMargin: 10
                                }

                                DescriptionText {
                                    font: Fonts.openSans(14)
                                    text: model.text
                                }

                                Item {
                                    Layout.fillWidth: true
                                }

                                Item {
                                    Layout.fillHeight: true
                                    Layout.preferredWidth: 39

                                    Image {
                                        anchors.centerIn: parent
                                        visible: btn.checked ? true : false
                                        source: "qrc:/images/assets/icons/checkmark-blue.svg"
                                        sourceSize: Qt.size(40, 40)
                                    }
                                }
                            }
                        }
                    }

                }
            }
        }


    }

}
