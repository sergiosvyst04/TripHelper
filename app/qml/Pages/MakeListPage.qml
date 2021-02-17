import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import Trip 1.0
import BackpackFilterModel 1.0
import BackPackModel 1.0
import PackService 1.0
import "../Singletons"
import "../Components"

BasePage {
    footer: Item{}
    property bool warning: false

    PackService {
        id: packer

        Component.onCompleted:{
            intialize(appController)
            backPackModel.intialize(packer)
        }
    }

    BackPackModel {
        id: backPackModel
    }

    BackpackFilterModel {
        id: backpackFilterModel
        sourceModel: backPackModel
        packedVisible: false
    }

    ColumnLayout {
        spacing: 20
        anchors {
            fill: parent
            rightMargin: 20
            leftMargin: 20
            bottomMargin: 20
        }

        RowLayout {

            Image {
                id: image
                Layout.alignment: Qt.AlignHCenter
                opacity: 0.5
                source: "qrc:/images/assets/icons/list.png"
                sourceSize: Qt.size(140 * ScreenProperties.scaleRatioWidth, 140 * ScreenProperties.scaleRatioHeight)
            }

            Item {
                Layout.fillWidth: true
            }

            ColoredButton {
                Layout.preferredHeight: (image.height / 2) * ScreenProperties.scaleRatioHeight
                Layout.preferredWidth: (image.width) * ScreenProperties.scaleRatioWidth
                color: Colors.primaryColor
                text: qsTr("Go to checklist")
                layer.enabled: false
                fontColor: Colors.white
                font.pixelSize: 12
                background: Rectangle {
                    radius: 28
                    gradient: Gradient {
                        GradientStop {position: 0.0; color: Colors.primaryColor }
                        GradientStop { position: 1.0; color: Colors.checkboxColor}
                    }
                }
                onClicked: navigateToItem("qrc:/Pages/CheckListPage.qml", {packer : packer})
            }

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
                onClicked: {
                    if(addItemField.text !== "") {
                        if(packer.checkIfItemExists(addItemField.text))
                        {
                            loadToMainLoader(warningPopup)
                            addItemField.text = ""
                        }
                        else {
                            packer.addItemToList(addItemField.text)
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
            id: unPackedItemsList
            Layout.topMargin: -30
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            model: backpackFilterModel
            spacing: 15

            delegate: BackPackItem {
                width: unPackedItemsList.width
                height: 40
                color: Colors.secondaryColor
                name: model.name

                rejectButton.onClicked: {
                    deleteItem()
                }
                applyButton.onClicked: {
                    packItem()
                }
            }
        }

        Image {
            Layout.alignment: Qt.AlignRight
            opacity: 0.6
            source: "qrc:/images/assets/icons/backpack.png"
            sourceSize: Qt.size(75 * ScreenProperties.scaleRatioWidth , 85 * ScreenProperties.scaleRatioWidth)
            MouseArea {
                anchors.fill: parent
                onClicked: loadToMainLoader(backPackPopup)
            }
        }
    }

    Component {
        id: warningPopup
        GeneralPopup {
            popupColor: Colors.white
            title.text: qsTr("Such item has been\n already in your backpack")
            title.font: Fonts.openSans(16, Font.MixedCase)
            width: 250
            height: 150

            Item {
                Layout.fillHeight: true
            }

            ColoredButton {
                Layout.alignment: Qt.AlignHCenter
                color: "transparent"
                font: Fonts.openSansBold(22, Font.Mixed)
                fontColor: Colors.primaryColor
                text: qsTr("Ok")
                layer.enabled: false
                onClicked: unloadFromMainLoader()
            }
        }

    }

    Component {
        id: backPackPopup

        GeneralPopup {
            title.text: qsTr("Your backpack")
            title.font: Fonts.openSans(18, Font.MixedCase)
            popupColor: Colors.primaryColor
            width: 285
            height: 480
            onOpenedChanged: backpackFilterModel.packedVisible = opened

            ListView {
                id: packedItemsList
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.rightMargin: 25
                model: backpackFilterModel

                clip: true
                spacing: 8
                delegate: BackPackItem {
                    color: Colors.secondaryColor
                    height: 33
                    width: packedItemsList.width
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
                onClicked: {
                    backpackFilterModel.packedVisible = false
                    unloadFromMainLoader()
                }
            }
        }
    }
}
