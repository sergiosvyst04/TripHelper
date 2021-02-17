import QtQuick 2.13
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5
import QtQml 2.12
import QtGraphicalEffects 1.10
import GalleryService 1.0
import PhotosModel 1.0
import "../Components"
import "../Singletons"

BasePage {
    header : Item{}
    footer: Item{}
    property bool editState: false
    property bool deleteMultiplePhotos: false
    property int amountOfSelectedImages: 0
    property string location: ""
    property PhotosModel photosModel

    Component.onCompleted: {
        galleryService.intialize(photosModel, photosStorage, tripsManager)
        if(location !== "") {
            galleryService.getPhotos(location)
        }
    }

    function deleteSelectedPhotos() {
        var count = galleryService.photosModel.rowCount();
        var j = 0;
        for(var i = 0; i < count - 1; i++)
        {
            if(gridView.itemAtIndex(i).checked)
            {
                galleryService.removePhoto(i - j, gridView.itemAtIndex(i).photoSource)
                j++;
            }
        }
    }

    ListModel {
        id: menuModel
    }

    GalleryService {
        id: galleryService
    }


    StackLayout {
        id: stack
        anchors.fill: parent

        currentIndex: 0

        ColumnLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 5
            Rectangle {
                height: 50
                Layout.fillWidth: true
                color: Colors.white
                layer.enabled: true
                layer.effect: DropShadow{
                    color: "lightgrey"
                    horizontalOffset: 0
                    verticalOffset: 1
                    radius: 12
                    samples: 25
                }

                RowLayout {
                    anchors {
                        fill: parent
                        leftMargin: 20
                        rightMargin: 20
                    }

                    ColoredButton {
                        color: "transparent"
                        fontColor: Colors.primaryColor
                        Layout.preferredHeight: 30
                        Layout.preferredWidth: 40
                        layer.enabled: false
                        onClicked: navigateBack()

                        Image {
                            anchors.centerIn: parent
                            source: "qrc:/images/assets/icons/backButton.png"
                            sourceSize: Qt.size(40, 30)
                        }
                    }

                    Item {
                        Layout.fillWidth: true
                    }

                    DescriptionText {
                        Layout.rightMargin: 30
                        Layout.alignment: Qt.AlignHCenter
                        text: qsTr("Gallery")
                        font: Fonts.openSans(17, Font.Mixed)
                    }

                    Item {
                        Layout.fillWidth: true
                    }

                    ColoredButton {
                        id: editBtn
                        Layout.preferredHeight: 40
                        Layout.preferredWidth: 40
                        color: "transparent"
                        layer.enabled: false

                        onClicked: {
                            if(editState) {
                                menuModel.append({text : qsTr("Delete")})
                                menu.open()
                            }
                            else
                            {
                                menuModel.append({text: qsTr("Edit")})
                                menu.open()
                            }
                        }

                        Image {
                            anchors.centerIn: parent
                            source: "qrc:/images/assets/icons/threepoints.jpg"
                            sourceSize: Qt.size(40, 40)
                        }

                        Menu {
                            id: menu
                            y: editBtn.height

                            onAboutToHide:  menuModel.remove(0)

                            Instantiator {
                                model: menuModel

                                MenuItem {
                                    text: model.text
                                    onTriggered:  {
                                        if(text === "Edit")
                                        {
                                            editState = true
                                        }
                                        else
                                        {

                                            deleteMultiplePhotos = true
                                            loadToMainLoader(deletePhotoPopup)
                                        }
                                    }
                                    background: Rectangle {
                                        implicitWidth: 100
                                        color: Colors.white
                                        radius: 8
                                    }
                                }
                                onObjectAdded: menu.insertItem(index, object)
                                onObjectRemoved: menu.removeItem(object)
                            }

                            background: Rectangle {
                                implicitWidth: 100
                                color: Colors.white
                                radius: 8
                            }
                        }
                    }
                }
            }


            GridView {
                id: gridView
                Layout.fillHeight: true
                Layout.fillWidth: true

                cellWidth: (width / 4) * ScreenProperties.scaleRatioHeight
                cellHeight: cellWidth

                model: galleryService.photosModel

                delegate: Item {
                    property string photoSource: gridDelegate.source1
                    property bool checked: gridDelegate.checked
                    width: gridView.cellWidth
                    height: gridView.cellHeight
                    GalleryDelegate {
                        id: gridDelegate
                        width: parent.width - 5
                        height: parent.height - 5
                        anchors.centerIn: parent
                    }

                }
            }
        }

        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true


            SwipeView {
                id: swipeView
                anchors.fill: parent

                interactive: !editState

                onCurrentIndexChanged: {
                    if(currentIndex === -1)
                    {
                        currentIndex = 0
                    }
                }

                Repeater {
                    id: swipeViewRepeater
                    model: galleryService.photosModel

                    delegate: Item {
                        property string source1: img.source
                        width: swipeView.width
                        height: swipeView.height
                        Image {
                            id: img
                            anchors.fill: parent
                            source: model.source
                        }
                    }
                }
            }

            Rectangle {
                anchors.top: parent.top
                height: 50
                width: parent.width
                opacity: 0.9

                ColoredButton {
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.verticalCenter: parent.verticalCenter
                    width: 40
                    height: 20
                    layer.enabled: false

                    Image {
                        anchors.centerIn: parent
                        source: "qrc:/images/assets/icons/backButton.png"
                        sourceSize: Qt.size(40, 30)
                    }
                    onClicked: stack.currentIndex = 0

                }
            }

            Rectangle {
                anchors.bottom: parent.bottom
                height: 50
                width: parent.width
                visible: !editState
                opacity: 0.7
                ColoredButton
                {
                    width: 100
                    height: 40
                    anchors.centerIn: parent
                    text: qsTr("Delete")
                    font: Fonts.openSans(17, Font.MixedCase)
                    fontColor: Colors.redButtonColor
                    color: "transparent"
                    layer.enabled: false
                    onClicked: {
                        deleteMultiplePhotos = false
                        loadToMainLoader(deletePhotoPopup)
                    }
                }
            }
        }
    }

    Component {
        id: deletePhotoPopup
        GeneralPopup {
            popupColor: Colors.white
            title.text: deleteMultiplePhotos ? qsTr("Do you want to delete\n photo (%1)?").arg(amountOfSelectedImages)
                                             : qsTr("Do you want to delete\n photo?")
            title.font: Fonts.openSans(16)

            width: 250
            height: 120


            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 50
                ColoredButton {
                    Layout.preferredHeight: 30
                    Layout.preferredWidth: 40
                    font: Fonts.openSansBold(16, Font.MixedCase)
                    fontColor: Colors.descriptionTextColor
                    text: qsTr("Yes")
                    layer.enabled: false
                    onClicked: {
                        if(deleteMultiplePhotos)
                        {
                            deleteSelectedPhotos()
                            unloadFromMainLoader()
                            editState = false
                            amountOfSelectedImages = 0
                        }
                        else {
                            galleryService.removePhoto(swipeView.currentIndex, swipeView.currentItem.source1)
                            unloadFromMainLoader()
                        }
                    }
                }

                ColoredButton {
                    Layout.preferredHeight: 30
                    Layout.preferredWidth: 40
                    font: Fonts.openSansBold(16, Font.MixedCase)
                    fontColor: Colors.redButtonColor
                    opacity: 0.8
                    text: qsTr("Cancel")
                    layer.enabled: false
                    onClicked: {
                        editState = false
                        unloadFromMainLoader()
                    }
                }
            }
        }
    }
}


