import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import "../Singletons"
import "../Components"

ColumnLayout {
    property alias modelForPhotos: pathView.model
    property alias modelForCities: citiesList.model
    property alias modelForNotes: notesList.model

    spacing: 30

    PathView {
        id: pathView
        Layout.topMargin: 20
        Layout.fillWidth: true
        Layout.preferredHeight: 110
        pathItemCount: 9


        delegate: Item {
            height: PathView.isCurrentItem ? 100 : 75
            width: PathView.isCurrentItem ? 125 : 85
            opacity: PathView.isCurrentItem ? 1.0 : 0.5
            z: PathView.isCurrentItem ? 1 : 0
            //                scale: PathView.iconScale
            Image {
                anchors.fill: parent
                source:  model.source
                fillMode: Image.PreserveAspectCrop
            }
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
