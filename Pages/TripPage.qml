import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import CompletedTripController 1.0
import TripDayController 1.0
import PhotosModel 1.0
import TripDaysModel 1.0
import "../Components"
import "../Singletons"

BasePage {
    property int tripIndex
    footer: Item{}

    function setCountriesModel(list, model)
    {
        console.log("set countries model called")
        for(var i = 0; i < list.length; i++)
        {
            model.append({country : list[i], flag: "qrc:/images/assets/icons/Flags/" + list[i] + ".png"})
        }
    }

    function setModel(list, model){
        model.clear()
        for(var i = 0; i < list.length; i++)
        {
            model.append({name : list[i]})
        }
    }

    function intializeDay(index)
    {
        dayController.intialize(index, controller.trip)
        setModel(dayController.cities, citiesListModel)
        setModel(dayController.notes, notesListModel)
        photosModel.getPhotos(dayController.photos)
    }

    PhotosModel {
        id: photosModel
        Component.onCompleted: getPhotos(dayController.photos)
    }
    
    ListModel {
        id: countriesModel
    }

    ListModel {
        id: citiesListModel
    }

    ListModel {
        id: notesListModel
    }

    TripDayController {
        id: dayController
        Component.onCompleted:{
            intialize(0, controller.trip)
            setModel(dayController.cities, citiesListModel)
            setModel(dayController.notes, notesListModel)
        }
    }

    TripDaysModel {
        id: daysModel
        Component.onCompleted:{
            getDays(controller.trip.days)
        }
    }

    CompletedTripController {
        id: controller

        Component.onCompleted:{
            intialize(tripIndex, appController)
            tripName.text = controller.trip.name
            setCountriesModel(controller.trip.allCountries ,countriesModel)
        }
    }

    //=======================================================================================================================


    ColumnLayout {
        anchors {
            fill: parent
            leftMargin: 15
            rightMargin: 15
        }

        DescriptionText {
            id: tripName
            Layout.alignment: Qt.AlignHCenter
            color: Colors.grey
            font: Fonts.openSansBold(15)

        }


        FlagsList {
            Layout.topMargin: 10
            Layout.alignment: Qt.AlignHCenter
            Layout.fillWidth: true
            Layout.preferredHeight: 50
            model: countriesModel
        }


        ListView {
            id: daysListView
            Layout.fillWidth: true
            Layout.leftMargin: 13
            Layout.preferredHeight: 130

            model: daysModel
            spacing: 12
            orientation: ListView.Horizontal
            onCurrentIndexChanged: console.log("current index : ", currentIndex)

            delegate: DayDelegate {
                gradColor: ListView.isCurrentItem ? "#9bc200" : "#DEFF5C"
                width: 95
                height: 115
                dayNumber: qsTr("Day %1").arg(index + 1)
                date: Qt.formatDate(new Date(), "d MMM \n yyyy")
                countOfPhotos: model.photos
                countOfCities: model.cities
                onClicked: {
                    daysListView.currentIndex = index
                    intializeDay(index)
                }
            }
        }

        Rectangle {
            Layout.preferredHeight: 1
            Layout.fillWidth: true
            color: Colors.lightgrey
        }

        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true

            TripDayViewer {
                anchors {
                    fill: parent
                    topMargin: 25
                    leftMargin: 17
                    rightMargin: 17
                }
                modelForPhotos: photosModel
                modelForCities: citiesListModel
                modelForNotes: notesListModel
            }
        }
    }


}
