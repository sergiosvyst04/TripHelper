import QtQuick 2.13
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import EndTripService 1.0
import PhotosModel 1.0
import Trip 1.0
import "../Singletons"
import "../Components"

BasePage {
    id: basePage
    nextButtonVisible: true
    nextButtonText: qsTr("Thanks")
    onNextButtonClicked: {
        endTripService.endTrip()
        navigateToItem("qrc:/Pages/MainPage.qml")
    }

    function setModel(list, model){
        for(var i = 0; i < list.length; i++)
        {
            model.append({name : list[i]})
        }
    }

    function setCountriesModel(list, model)
    {
        for(var i = 0; i < list.length; i++)
        {
            model.append({country : list[i], flag: "qrc:/images/assets/icons/Flags/" + list[i] + ".png"})
        }
    }

    PhotosModel {
        id: photosModel

        Component.onCompleted: {
            getPhotos(endTripService.allPhotos)
        }
    }


    EndTripService {
        id: endTripService

        Component.onCompleted: {
            intialize(appController)
            setModel(endTripService.allCities, citiesModel)
            setCountriesModel(endTripService.allCountries, countriesModel)
        }
    }

    ListModel {
        id: countriesModel
    }

    ListModel{
        id: citiesModel
    }

    ColumnLayout {

        spacing: 10
        anchors {
            fill: parent
            topMargin: -35
            rightMargin: 17
            leftMargin: 17
            bottomMargin: 35
        }

        Image{
            Layout.alignment: Qt.AlignHCenter
            source: "qrc:/images/assets/icons/pyro.png"
            sourceSize: Qt.size(195 * ScreenProperties.scaleRatioWidth, 125 * ScreenProperties.scaleRatioHeight)
        }

        ColumnLayout {
            spacing: 20
            DescriptionText {
                Layout.alignment: Qt.AlignHCenter
                font: Fonts.openSansBold(15, Font.pixelSize)
                text: qsTr("Visited countries :")
            }

            FlagsList {
                id: listView
                Layout.alignment: Qt.AlignHCenter
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                model: countriesModel
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
                Layout.preferredHeight: 40 * ScreenProperties.scaleRatioHeight
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
                        font: index === citiesListView.currentIndex ? Fonts.openSansBold(17, Font.MixedCase) : Fonts.openSans(14)
                        text: model.name
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


                delegate: PhotoPathDelegate {
                    height: PathView.isCurrentItem ? 100 : 75
                    width: PathView.isCurrentItem ? 125 : 85
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
        }

        ColoredButton {
            Layout.alignment: Qt.AlignRight
            Layout.topMargin: -20
            Layout.preferredHeight: 40 * ScreenProperties.scaleRatioHeight
            Layout.preferredWidth: 100 * ScreenProperties.scaleRatioWidth
            layer.enabled: false
            color: "transparent"
            fontColor: Colors.primaryColor
            font: Fonts.openSansBold(15, Font.MixedCase)
            text: qsTr("Go to gallery")
            onClicked: navigateToItem("qrc:/Pages/GalleryPage.qml", {photosModel : photosModel})
        }

    }

}
