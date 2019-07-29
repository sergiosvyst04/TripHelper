import QtQuick 2.13
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import "../Singletons"
import "../Components"

BasePage {
    id: basePage
    header: Item{}
    nextButtonVisible: true
    nextButtonText: qsTr("Thanks")

    ListModel {
        id: countriesModel

        ListElement { country : "Chile"; flag : "qrc:/images/assets/icons/Flags/Chile.png"}
        ListElement { country : "Argentina"; flag : "qrc:/images/assets/icons/Flags/Chile.png"}
        ListElement { country : "Brazil"; flag : "qrc:/images/assets/icons/Flags/Chile.png"}
        ListElement { country : "Switzerland"; flag : "qrc:/images/assets/icons/Flags/Chile.png"}
        ListElement { country : "Chile"; flag : "qrc:/images/assets/icons/Flags/Chile.png"}
    }

    ListModel {
        id: photosModel

        ListElement { source: "file:///home/sergio/Desktop/Images/photos/anfield.jpg"}
        ListElement { source: "file:///home/sergio/Desktop/Images/photos/road1.jpg"}
        ListElement { source: "file:///home/sergio/Desktop/Images/photos/road2.jpg"}
        ListElement { source: "file:///home/sergio/Desktop/Images/photos/road3.jpg"}
        ListElement { source: "file:///home/sergio/Desktop/Images/photos/road4.jpg"}
        ListElement { source: "file:///home/sergio/Desktop/Images/photos/road5.jpg"}
        ListElement { source: "file:///home/sergio/Desktop/Images/photos/road6.jpg"}
        ListElement { source: "file:///home/sergio/Desktop/Images/photos/road7.jpg"}
        ListElement { source: "file:///home/sergio/Desktop/Images/photos/set.jpg"}
        ListElement { source: "file:///home/sergio/Desktop/Images/photos/set2.jpg"}
        ListElement { source: "file:///home/sergio/Desktop/Images/photos/set3.jpg"}
        ListElement { source: "file:///home/sergio/Desktop/Images/photos/set4.jpg"}
        ListElement { source: "file:///home/sergio/Desktop/Images/photos/set5.jpg"}
        ListElement { source: "file:///home/sergio/Desktop/Images/photos/set6.jpg"}

    }

    ListModel{
        id: citiesModel

        ListElement {city : "Madrid" }
        ListElement {city : "Barcelona" }
        ListElement {city : "Mayorca" }
        ListElement {city : "Paris" }
        ListElement {city : "Canne" }
        ListElement {city : "Nica" }
        ListElement {city : "Sent Trope" }
        ListElement {city : "Madrid" }
        ListElement {city : "Barcelona" }
        ListElement {city : "Mayorca" }
        ListElement {city : "Paris" }
        ListElement {city : "Canne" }
        ListElement {city : "Nica" }
        ListElement {city : "Sent Trope" }
    }

    ColumnLayout {

        spacing: 10
        anchors {
            fill: parent
            rightMargin: 17
            leftMargin: 17
            bottomMargin: 35
        }

        Image{
            Layout.alignment: Qt.AlignHCenter
            source: "qrc:/images/assets/icons/pyro.png"
            sourceSize: Qt.size(195, 125)
        }

        ColumnLayout {
            spacing: 20
            DescriptionText {
                Layout.alignment: Qt.AlignHCenter
                font: Fonts.openSansBold(15, Font.pixelSize)
                text: qsTr("Visited countries :")
            }

            ListView {
                id: listView
                Layout.alignment: Qt.AlignHCenter
                Layout.fillWidth: true
                Layout.preferredHeight: 50

                model: countriesModel
                spacing: 30

                highlightRangeMode: ListView.StrictlyEnforceRange
                preferredHighlightBegin: width / 2 - 20
                preferredHighlightEnd: width / 2 + 20

                currentIndex: count / 2

                orientation: ListView.Horizontal
                delegate: Item {
                    width: countryName.width
                    height: 40
                    ColumnLayout {
                        id: countryItem
                        spacing: 1
                        Image {
                            Layout.alignment: Qt.AlignHCenter
                            source: model.flag
                            sourceSize: Qt.size(30, 22)
                        }

                        DescriptionText {
                            id: countryName
                            Layout.alignment: Qt.AlignHCenter
                            text: model.country
                        }
                    }

                    DescriptionText {
                        anchors {
                            left: countryItem.right
                            leftMargin: 10
                            verticalCenter: countryItem.verticalCenter
                        }
                        visible: index === listView.count - 1 ? false : true
                        font: Fonts.openSansBold(22)
                        text: "-"
                    }
                }

            }

        }

        ColumnLayout {
            spacing: 20
            DescriptionText {
                Layout.alignment: Qt.AlignHCenter
                font: Fonts.openSansBold(15, Font.pixelSize)
                text: qsTr("Visited cities :")
            }


            ListView {
                id: citiesListView
                Layout.fillWidth: true
                Layout.preferredHeight: 40
                highlightRangeMode: ListView.StrictlyEnforceRange
                preferredHighlightBegin: width / 2 - 20
                preferredHighlightEnd: width / 2 + 20
                currentIndex: count / 2

                model: citiesModel
                spacing: 30
                orientation: ListView.Horizontal
                delegate: Item {
                    width: city.width
                    DescriptionText {
                        id: city
                        font: Fonts.openSans(14, Font.MixedCase)
                        text: model.city
                    }

                    DescriptionText {
                        anchors{
                            left: city.right
                            leftMargin: 10
                        }
                        visible: index === citiesListView.count - 1 ? false : true
                        font: Fonts.openSans(14, Font.MixedCase)
                        text: "-"
                    }
                }
            }

        }

        ColumnLayout {

            spacing: 20

            DescriptionText {
                Layout.alignment: Qt.AlignHCenter
                font: Fonts.openSansBold(15, Font.pixelSize)
                text: qsTr("Photos from trip :")
            }

            PathView {
                id: pathView
                Layout.topMargin: 20
                Layout.fillWidth: true
                Layout.preferredHeight: 110
                model: photosModel
                pathItemCount: 9


                delegate: Item {
                    height: PathView.isCurrentItem ? 100 : 75
                    width: PathView.isCurrentItem ? 125 : 85
                    opacity: PathView.isCurrentItem ? 1.0 : 0.5
                    z: PathView.isCurrentItem ? 1 : 0
                    //                scale: PathView.iconScale
                    Image {
                        anchors.fill: parent
                        source: model.source
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
            onClicked: navigateToItem("qrc:/Pages/GalleryPage.qml", {modelWithPhotos : photosModel})
        }

    }

}
