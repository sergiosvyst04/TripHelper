import QtQuick 2.13
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.10
import "../Singletons"
import "../Components"
import ActiveTripController 1.0
import TripDaysModel 1.0


BasePage {
    backButtonVisible: true
    footer: Item{}

    property string newCountry: ""

    TripDaysModel {
        id: tripDaysModel

        Component.onCompleted: {
            getDays(activeTripController.trip.days)
        }
    }

    Connections {
        target: visitedLocationsController
        onNewCountryAdded: {
            newCountry = country
            loadToMainLoader(newCountryPopup)
        }
    }


    ColumnLayout {
        id: activeTrip
        spacing: 40 * ScreenProperties.scaleRatioHeight

        anchors {
            fill: parent
        }

        PrimaryLabel {
            Layout.alignment: Qt.AlignHCenter
            Component.onCompleted: text = activeTripController.trip.name
        }

        ListView {
            id: daysListView
            Layout.fillWidth: true
            Layout.leftMargin: 13
            Layout.preferredHeight: 130 * ScreenProperties.scaleRatioHeight

            model: tripDaysModel
            spacing: 12
            orientation: ListView.Horizontal
            delegate: DayDelegate {
                width: 95 * ScreenProperties.scaleRatioWidth
                height: parent.height
                dayNumber: qsTr("Day %1").arg(index + 1)
                date: Qt.formatDate(new Date(), "d MMM \n yyyy")
                countOfPhotos: model.photos
                countOfCities: model.cities
                onClicked: navigateToItem("qrc:/Pages/TripDayPage.qml", {activeController: activeTripController, dayIndex: index})
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.rightMargin: 73
            Layout.leftMargin: 73
            spacing: 11

            Repeater {
                model: ListModel {
                    ListElement {actionText: qsTr("Add note"); actionImage: "qrc:/images/assets/white icons/note.png"; action: function(){navigateToItem("qrc:/Pages/AddNotePage.qml", {activeTrip: activeTripController})}}
                    ListElement {actionText: qsTr("Add new idea"); actionImage: "qrc:/images/assets/white icons/idea.png"; action: function(){loadToMainLoader(addIdeaPopup)}}
                    ListElement {actionText: qsTr("Add favourite place"); actionImage: "qrc:/images/assets/white icons/place.png"; action: function(){console.log("add favourite place")}}
                }

                ActiveTripActionItem {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 50 * ScreenProperties.scaleRatioHeight
                    actionText: model.actionText
                    image: model.actionImage
                    onClicked: model.action()
                }
            }

            ColoredButton {
                Layout.fillWidth: true
                Layout.preferredHeight: 50 * ScreenProperties.scaleRatioHeight
                text: qsTr("Check-In")
                font: Fonts.openSansBold(13, Font.MixedCase)
                fontColor: Colors.grey
                onClicked: {
                    activeTripController.makeCheckIn()
                    //                    visitedLocationsController.addLocation(countryField.text, cityField.text)  // TODO: make 2 test text fields to test if feature
                    loadToMainLoader(checkInPopup)
                }
                layer.enabled: false

                background: Rectangle {
                    radius: 28
                    gradient: Gradient {
                        GradientStop {position: 0.0; color: Colors.checkInColor}
                        GradientStop {position: 1.0; color: Colors.orange}
                    }
                }
            }

            ColoredButton {
                Layout.fillWidth: true
                Layout.topMargin: 20
                Layout.preferredHeight: 50 * ScreenProperties.scaleRatioHeight
                text: qsTr("End of trip")
                fontColor: Colors.white
                font: Fonts.openSansBold(13, Font.MixedCase)
                layer.enabled: false

                onClicked: navigateToItem("qrc:/Pages/EndTripPage.qml")
                background: Rectangle {
                    radius: 28
                    gradient: Gradient{
                        GradientStop {position: 0.0; color: Colors.redButtonColor}
                        GradientStop {position: 1.0; color: Colors.darkRed}
                    }
                }
            }
        }
    }


    Component {
        id: checkInPopup
        GeneralPopup {
            popupColor: Colors.checkInColor
            title.text: qsTr("Welcome to %1\n %2").arg(activeTripController.currentCity).arg(userAccountController.name)
            title.font: Fonts.openSansBold(16, Font.MixedCase)

            height: 435
            width: 295

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 160
                radius: 4
                color: Colors.lightgrey
            }

            ColumnLayout {
                Layout.leftMargin: 36
                Layout.rightMargin: 36
                spacing: 9
                ColoredButton {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredHeight: 45
                    Layout.fillWidth: true
                    color: Colors.primaryColor
                    font: Fonts.openSansBold(13, Font.MixedCase)
                    fontColor: Colors.white
                    text: qsTr("Touristic Attrations")
                    layer.enabled: false
                }

                ColoredButton {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredHeight: 45
                    Layout.fillWidth: true
                    color: Colors.primaryColor
                    font: Fonts.openSansBold(13, Font.MixedCase)
                    fontColor: Colors.white
                    text: qsTr("Favourite places")
                    layer.enabled: false
                }

                ColoredButton {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredHeight: 45
                    Layout.fillWidth: true
                    color: Colors.primaryColor
                    font: Fonts.openSansBold(13, Font.MixedCase)
                    fontColor: Colors.white
                    text: qsTr("Thanks")
                    layer.enabled: false
                }

            }
        }
    }

    Component {
        id: addIdeaPopup
        GeneralPopup {
            popupColor: Colors.primaryColor
            title.text: qsTr("Add new idea")
            title.font: Fonts.openSansBold(16, Font.MixedCase)
            title.color: Colors.grey

            height: 315
            width: 232

            DescriptionText {
                Layout.alignment: Qt.AlignHCenter
                textFormat: Text.PlainText
                color: Colors.grey
                text: qsTr("Don't let your inspiration \n to die on the rest")
                font: Fonts.openSans(13, Font.MixedCase)
            }

            ScrollView {
                Layout.fillWidth: true
                Layout.preferredHeight: 95
                ScrollBar.vertical.policy: ScrollBar.AlwaysOff

                TextArea {
                    id: textArea
                    height: parent.height
                    width: parent.width
                    clip: true

                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    color: Colors.grey
                    font: Fonts.openSans(13, Font.MixedCase)
                    padding: 10
                    placeholderText: qsTr("I want to...")

                    background: Rectangle {
                        anchors.fill: parent
                        radius: 10
                        color: Colors.textAreaColor
                        opacity: 0.4
                    }
                }
            }


            ColoredButton {
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredHeight: 36
                Layout.preferredWidth: 86
                color: Colors.primaryColor
                layer.enabled: false
                text: qsTr("Add")
                fontColor: Colors.white
                font: Fonts.openSansBold(13, Font.MixedCase)
                onClicked:{
                    activeTripController.addNewIdea(textArea.text)
                    loader.active = false
                }
            }
        }
    }

    Component {
        id: newCountryPopup

        GeneralPopup {
            popupColor: Colors.primaryColor
            height: 280
            width: 232
            title.visible: false

            Image {
                id: addedCountryFlag
                Layout.alignment: Qt.AlignHCenter
                sourceSize: Qt.size(60, 60)
                source: "qrc:/images/assets/icons/Flags/%1.png".arg(newCountry)
            }

            DescriptionText {
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: parent.width
                font: Fonts.openSansBold(15)
                text: newCountry
            }

            DescriptionText {
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: parent.width
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                textFormat: Text.RichText
                text: qsTr("Congratulations
it's new country for you!
<br>
Amount of visited countries increased to <br> <b>%1</b>").arg(visitedLocationsController.amountOfVisitedCountries)
            }

            ColoredButton {
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredHeight: 36
                Layout.preferredWidth: 86
                color: Colors.primaryColor
                layer.enabled: false
                text: qsTr("Ok")
                fontColor: Colors.white
                font: Fonts.openSansBold(13, Font.MixedCase)
                onClicked: {
                    loader.sourceComponent = checkInPopup
                }
            }
        }
    }

}


