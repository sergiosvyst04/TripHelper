import QtQuick 2.13
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.10
import QtMultimedia 5.13
import "../Singletons"
import "../Components"

BasePage {
    id: bp
    footer: Item {}
    header: Item {}
    property string photoPath

    VideoOutput {
        anchors.fill: parent
        source: camera
        fillMode: VideoOutput.PreserveAspectCrop
    }

    Camera {
        id: camera
        captureMode: pathView.currentIndex == 0 ? Camera.CaptureStillImage : Camera.CaptureVideo
        videoRecorder.onRecorderStatusChanged:  {
            console.log("status changed to : ", camera.videoRecorder.recorderStatus)
        }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 15
        Item {
            Layout.fillHeight: true
        }

        CameraButtonsBar {

        }


        ListView {
            id: pathView
            Layout.alignment: Qt.AlignHCenter
            Layout.bottomMargin: 10
            Layout.preferredHeight: 20
            Layout.fillWidth: true

            highlightRangeMode: ListView.StrictlyEnforceRange
            preferredHighlightBegin: 160 - 15
            preferredHighlightEnd: 160 + 15

            displayMarginEnd: 50
            displayMarginBeginning: 50


            orientation: ListView.Horizontal
            spacing: 30
            clip: false



            model: ListModel {
                ListElement {text: qsTr("Photo")}
                ListElement {text: qsTr("Video")}
            }

            delegate:  Text {
                id: delegate
                text: model.text
                color: Colors.white
                font: Fonts.openSansBold(15, Font.MixedCase)
                opacity: ListView.isCurrentItem ? 1 : 0.75
            }

        }



    }

    Connections {
        target: camera.imageCapture

        onImageSaved: {
            photoPath = path
            loader2.active = true
        }
    }

    Loader {
        id: loader2
        active: false

        sourceComponent:  Popup {
            id: popup
            visible: true
            modal: true
            implicitWidth: 325
            implicitHeight: 530
            parent: Overlay.overlay
            anchors.centerIn: parent

            onAboutToHide: {
                loader2.active = false
            }

            Component.onCompleted:  {
                animOnCompleted.running = true
            }



            ParallelAnimation {
                id: animOnCompleted
                running: false
                NumberAnimation {
                    target: popup
                    properties: "width"
                    from: 0
                    to: 325
                    duration: 150
                }

                NumberAnimation {
                    target: popup
                    properties: "height"
                    from: 0
                    to: 530
                    duration: 150
                }

            }

            SequentialAnimation {
                id: animOnDestructionAplly

                ParallelAnimation {
                    NumberAnimation {
                        target: checkMark
                        properties: "opacity"
                        from: 0
                        to: 0.5
                        duration: 300
                    }

                    NumberAnimation {
                        target: checkMark
                        properties: "opacity"
                        from: 0.5
                        to: 0
                        duration: 300
                    }


                }

                ParallelAnimation {
                    id: animOnDesctructionReject
                    running: false

                    NumberAnimation {
                        target: popup
                        properties: "width"
                        from: 325
                        to: 0
                        duration: 150
                    }

                    NumberAnimation {
                        target: popup
                        properties: "height"
                        from: 530
                        to: 0
                        duration: 150
                    }
                    onStopped: loader2.active = false
                }
                onStopped: loader2.active = false

            }



            background: Rectangle {
                id: back
                anchors.fill: parent
                color: Colors.white
                radius: 28

                layer.enabled: true
                layer.effect: DropShadow {
                    color: "black"
                    horizontalOffset: 0
                    verticalOffset: 5
                    radius: 15
                }

                RoundedRect {
                    anchors.top: parent.top
                    corners.topLeftRadius: 28
                    corners.topRightRadius: 28
                    width: parent.width
                    height: 70
                    color: Colors.lightgrey

                    DescriptionText {
                        anchors.centerIn: parent
                        font: Fonts.openSansBold(14, Font.MixedCase)
                        color: Colors.descriptionTextColor
                        textFormat: Text.PlainText
                        text: qsTr("Do you want to add this photo\n to your trip?")
                    }
                }
            }

            contentItem: Image {
                id: takenPhoto
                property bool rounded: true
                property bool adapt: true
                anchors {
                    fill: parent
                    topMargin: 70
                }
                source: "file://" + photoPath
                layer.enabled: rounded
                layer.effect: OpacityMask {
                    maskSource: Item {
                        width: takenPhoto.width
                        height: takenPhoto.height

                        RoundedRect {
                            anchors.centerIn: parent
                            width: takenPhoto.adapt ? takenPhoto.width : Math.min(takenPhoto.width, takenPhoto.height)
                            height: takenPhoto.adapt ? takenPhoto.height : takenPhoto.width
                            corners.bottomLeftRadius: 28
                            corners.bottomRightRadius: 28
                        }
                    }
                }

                Image {
                    id: checkMark
                    anchors.centerIn: parent
                    source: "qrc:/images/assets/icons/apply.png"
                    sourceSize: Qt.size(200, 200)
                    opacity: 0
                }

                RowLayout {
                    anchors{
                        bottom: takenPhoto.bottom
                        left: takenPhoto.left
                        leftMargin: 47
                        rightMargin: 47
                        bottomMargin: 25
                    }
                    spacing: 70


                    ChoosePhotoButton {
                        border.color: Colors.approveTextColor
                        image: "qrc:/images/assets/icons/apply.png"
                        onClicked:  {
                            animOnDestructionAplly.running = true
                            activeTripController.addNewPhoto("file://" + photoPath)
                        }

                    }

                    ChoosePhotoButton {
                        border.color: Colors.warningTextColor
                        image: "qrc:/images/assets/icons/redcross.png"
                        onClicked:  {
                            loader2.active = false
                        }
                    }
                }
            }

        }
    }
}

