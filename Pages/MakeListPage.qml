import QtQuick 2.10
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import Trip 1.0
import "../Singletons"
import "../Components"

BasePage {
    footer: Item{}

    property Trip trip
    property bool warning: false


    function checkIfItemExist(item){
        for(var i = 0; i < listItemsModel.count; i++)
        {
            if(item === listItemsModel.get(i).name)
            {
                return true;
            }
        }
        return false;
    }

    ColumnLayout {
        spacing: 20
        anchors {
            fill: parent
            rightMargin: 20
            leftMargin: 20
            bottomMargin: 20
        }

        Image {
            Layout.alignment: Qt.AlignHCenter
            opacity: 0.5
            source: "qrc:/images/assets/icons/list.png"
            sourceSize: Qt.size(140, 140)
        }

        RowLayout {
            spacing: 30
            LabeledTextEdit {
                id: addItemField
                Layout.fillWidth: true
                label: qsTr("Add new item")
            }

            ColoredButton {
                fontColor: Colors.descriptionTextColor
                font: Fonts.openSansBold(17, Font.MixedCase)
                color: "transparent"
                text: qsTr("Add")
                onClicked:{
                    if(addItemField.text !== "") {
                        if(checkIfItemExist(addItemField.text))
                        {
                            warning = true
                            loader.active = true
                            addItemField.text = ""
                        }
                        else {
                            //                            listItemsModel.append({"name" : addItemField.text})
                            trip.addItemToList(addItemField.text)
                            addItemField.text = ""
                        }
                    }
                    else {
                        console.log("you can't add empty item")
                    }
                }
            }
        }

        ListView {
            Layout.topMargin: -30
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            //            model: ListModel {
            //                id: listItemsModel
            //            }

            model: trip.list

            spacing: 15

            delegate: BackPackItem {
                width: parent.width
                height: 40
                color: Colors.secondaryColor
                name: model
                rejectButton.onClicked: {
                    if(typeof deleteItem === "function")
                        deleteItem(index)
                }
                applyButton.onClicked: {
                    if(typeof packItem === "function")
                        packItem(index)
                }

            }
        }

        Image {
            Layout.alignment: Qt.AlignRight
            opacity: 0.6
            source: "qrc:/images/assets/icons/backpack.png"
            sourceSize: Qt.size(75, 85)
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    warning = false
                    loader.active = true
                }
            }
        }
    }

    ListModel {
        id: backPackItemsModel
    }


    Loader {
        id: loader
        active: false

        sourceComponent: warning ? warningPopup : backPackPopup

        Component {
            id: warningPopup
            Popup {
                id: pop

                visible: true
                anchors.centerIn: parent
                parent: Overlay.overlay
                implicitWidth: 250
                implicitHeight: 120
                modal: true

                onAboutToHide: loader.active = false
                background: Rectangle {
                    radius: 28
                }

                ColumnLayout {
                    spacing: 10
                    anchors {
                        fill: parent
                        rightMargin: 10
                        leftMargin: 10
                        bottomMargin: 25
                    }

                    DescriptionText {
                        Layout.alignment: Qt.AlignHCenter
                        textFormat: Text.PlainText
                        text: qsTr("Such item has been\n already in your backpack")
                        font: Fonts.openSans(16, Font.MixedCase)
                    }



                    ColoredButton {
                        Layout.alignment: Qt.AlignHCenter
                        color: "transparent"
                        font: Fonts.openSansBold(22, Font.Mixed)
                        fontColor: Colors.primaryColor
                        text: qsTr("Ok")
                        layer.enabled: false
                        onClicked: loader.active = false
                    }


                }

            }

        }

        Component {
            id: backPackPopup

            Popup {
                visible: true
                anchors.centerIn: parent
                parent: Overlay.overlay
                implicitWidth: 285
                implicitHeight: 480
                modal: true

                onAboutToHide: loader.active = true

                background: Rectangle {
                    radius: 28
                }

                ColumnLayout {
                    spacing: 20
                    anchors {
                        fill: parent
                        topMargin: 15
                        bottomMargin: 20
                    }

                    DescriptionText {
                        Layout.alignment: Qt.AlignHCenter
                        text: qsTr("Your backpack")
                        font: Fonts.openSans(18, Font.MixedCase)
                    }

                    ListView {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.rightMargin: 25
                        model: backPackItemsModel

                        clip: true
                        spacing: 8
                        delegate: BackPackItem {
                            color: Colors.secondaryColor
                            height: 33
                            width: parent.width
                            name: model.name
                            applyButton.visible: false
                            rejectButton.visible: false
                        }
                    }

                    ColoredButton {
                        Layout.alignment: Qt.AlignHCenter
                        color: "transparent"
                        font: Fonts.openSansBold(22, Font.Mixed)
                        fontColor: Colors.primaryColor
                        text: qsTr("Ok")
                        layer.enabled: false
                        onClicked: loader.active = false
                    }
                }

            }
        }



    }
}
