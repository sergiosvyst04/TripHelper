import QtQuick 2.13
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.10
import QtMultimedia 5.13
import PhotosModel 1.0
import TripDayController 1.0

import "../Components"
import "../Singletons"

BasePage {
    footer: Item {}

    property var activeController
    property int dayIndex

    ListModel {
        id: citiesListModel
    }

    ListModel {
        id: notesListModel
    }

    function setModel(list, model){
        for(var i = 0; i < list.length; i++)
        {
            model.append({name : list[i]})
        }
    }

    PhotosModel {
        id: photosModel

        Component.onCompleted:{
            getPhotos(tripDayController.photos)
        }
    }

    TripDayController {
        id: tripDayController

        Component.onCompleted:{
            intialize(dayIndex, activeController.trip)
            setModel(tripDayController.cities, citiesListModel)
            setModel(tripDayController.notes, notesListModel)
        }
    }

    //===========================================================================================================================

    ColumnLayout {
        spacing: 30
        anchors {
            fill: parent
            topMargin: 25
            leftMargin: 17
            rightMargin: 17
        }

        PathView {
            id: pathView
            Layout.topMargin: 20
            Layout.fillWidth: true
            Layout.preferredHeight: 110
            model: photosModel
            pathItemCount: 9

            delegate: PhotoPathDelegate {
                height: PathView.isCurrentItem ? 120 : 75
                width: PathView.isCurrentItem ? 135 : 85
                opacity: PathView.isCurrentItem ? 1.0 : 0.5
                z: PathView.isCurrentItem ? 1 : 0
            }


            path: Path {
                id:flowViewPath

                startX: pathView.width / 2
                startY:  pathView.height / 2

                PathCurve {
                    x: pathView.width - 40
                    y: (pathView.height / 2) - 15
                }

                PathCurve {
                    x: pathView.width / 2
                    y: 15
                }

                PathCurve {
                    x: 40
                    y: (pathView.height / 2) - 15
                }

                PathCurve {
                    x: pathView.width / 2
                    y: pathView.height / 2
                }
            }
        }

        ColoredButton {
            Layout.alignment: Qt.AlignRight
            Layout.topMargin: -20
            Layout.preferredHeight: 40
            Layout.preferredWidth: 100
            layer.enabled: false
            color: "transparent"
            fontColor: Colors.primaryColor
            font: Fonts.openSansBold(15, Font.MixedCase)
            text: qsTr("Go to gallery")
            onClicked: navigateToItem("qrc:/Pages/GalleryPage.qml", {photosModel : photosModel})
        }

        RowLayout {
            Image {
                sourceSize: Qt.size(27, 27)
                source: "qrc:/images/assets/icons/location3.png"
            }

            ListView {
                id: citiesList
                spacing: 7
                Layout.fillWidth: true
                Layout.preferredHeight: 20


                clip: true
                orientation: ListView.Horizontal
                model: citiesListModel

                delegate: DescriptionText {
                    Layout.alignment: Qt.AlignVCenter
                    text: model.name
                    font: Fonts.openSansBold(15, Font.MixedCase)
                    color: Colors.descriptionTextColor
                }
            }

            ColoredButton {
                Layout.minimumHeight: 39
                Layout.minimumWidth: 61
                color: Colors.primaryColor
                fontColor: Colors.white
                font: Fonts.openSansBold(13)
                text: qsTr("Ideas")
                layer.enabled: false
            }
        }

        ListView {
            id: notesList
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 15
            clip: true

            model: notesListModel

            delegate: DescriptionText {
                width: notesList.width
                horizontalAlignment: Text.AlignLeft
                font: Fonts.openSans(13, Font.MixedCase)
                text: modelData
                textFormat: Text.PlainText
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            }
        }
    }
}
