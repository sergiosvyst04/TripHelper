import QtQuick 2.13
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import CompletedTripsModel 1.0
import "../Singletons"
import "../Components"

BasePage {
    backButtonVisible: true

    footer: Item{}

    CompletedTripsModel {
        id: completedTripsModel
        Component.onCompleted: getCompletedTrips(appController)
    }

    ColumnLayout {
        spacing: 32
        anchors {
            fill: parent
            leftMargin: 39
            rightMargin: 39
        }


        PrimaryLabel {
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("My trips")
        }


        ListView {
            Layout.fillHeight: true
            Layout.fillWidth: true

            clip: true
            model: completedTripsModel
            spacing: 15

            delegate:  TripItem {
                width: parent.width
                height: 165

                tripName: model.name
                dates: qsTr("%1 - %2").arg(Qt.formatDate(model.depatureDate ,"d/M/yyyy")).arg(Qt.formatDate(new Date() ,"d/M/yyyy"))
                citiesCount: model.visitedCities
                photoCount: model.takenPhotos
                ideasCount: model.ideas
                Component.onCompleted: setFlags(model.visitedCountries)
                onClicked:{
                    navigateToItem("qrc:/Pages/TripPage.qml", {tripIndex: index})
                }
            }
        }
    }

    Rectangle {
        id: gradientSource
        anchors.bottom: parent.bottom
        width: parent.width
        height: 70
        gradient: Gradient {
            GradientStop { position: 0.0; color: Qt.rgba(46, 157, 255, 0) }
            GradientStop { position: 0.3; color: Qt.rgba(46, 157, 255, .6) }
            GradientStop { position: 1.0; color: Qt.rgba(46, 157, 255, 1) }
        }
    }

}
