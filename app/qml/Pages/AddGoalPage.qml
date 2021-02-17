import QtQuick 2.10
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.12
import QtQml 2.13
import "../Singletons"
import "../Components"
import CountriesCitiesModel 1.0

BasePage {
    nextButtonVisible: true
    nextButtonText: qsTr("Add goal")
    backButtonVisible: true
    nextButtonEnabled: cityComboBox.currentIndex > -1 && countryComboBox.currentIndex > -1 && dateField.fieldText != ""

    onNextButtonClicked: {
        goalsController.addGoal(countryComboBox.textAt(countryComboBox.currentIndex), cityComboBox.textAt(cityComboBox.currentIndex), dateField.depatureDate)
    }


    CountriesCitiesModel {
        id: countriesModel
        Component.onCompleted: getCountries()
    }

    CountriesCitiesModel {
        id: citiesModel
    }

    Connections {
        target: goalsController
        onGoalAdded : {
            loadToMainLoader(popup)
        }
    }

    ColumnLayout {
        anchors {
            fill: parent
            leftMargin: 32
            rightMargin: 32
            topMargin: 5
            bottomMargin: 80
        }
        spacing: 15

        PrimaryLabel {
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("Dream bravely")
        }

        Image {
            Layout.alignment: Qt.AlignHCenter
            source: "qrc:/images/assets/icons/Humans-11-11-512.png"
            sourceSize: Qt.size(160 * ScreenProperties.scaleRatioWidth, 145 * ScreenProperties.scaleRatioHeight)
            opacity: 0.4
        }


        ColumnLayout {
            spacing: 9

            DescriptionText {
                Layout.preferredHeight: 16
                font: Fonts.openSans(12, Font.MixedCase)
                text: qsTr("Country destination")
                horizontalAlignment: Text.AlignLeft
                color: Colors.descriptionTextColor
            }

            LocationComboBox {
                id: countryComboBox
                Layout.fillWidth: true
                Layout.preferredHeight: 30 * ScreenProperties.scaleRatioHeight
                currentIndex: -1

                model: countriesModel

                onActivated: {
                    currentIndex = index
                    cityComboBox.enabled = true
                    citiesModel.getCities(textAt(currentIndex))
                }

            }
        }

        ColumnLayout {
            spacing: 9

            DescriptionText {
                Layout.preferredHeight: 16 * ScreenProperties.scaleRatioHeight
                font: Fonts.openSans(12, Font.MixedCase)
                text: qsTr("City destination")
                horizontalAlignment: Text.AlignLeft
                color: Colors.descriptionTextColor
            }

            LocationComboBox {
                id: cityComboBox
                Layout.fillWidth: true
                Layout.preferredHeight: 30 * ScreenProperties.scaleRatioHeight
                currentIndex: -1
                enabled: false

                model: citiesModel

                onActivated: {
                    currentIndex = index
                }

            }
        }

        PopupActivationButton {
            id: dateField
            property date depatureDate
            fieldText: Qt.formatDate(depatureDate, "d MMMM yyyy")
            labelText: qsTr("Depature date")
            popupContentItem: TripCalendar {
                minimumDate: new Date()
                onPressAndHold: {
                    dateField.popupItem.close()
                    dateField.depatureDate = date
                }
            }
        }
    }

    Component {
        id: popup

        GeneralPopup {
            title.text: "Goal was succesfully added\n to your goals"
            title.color: Colors.descriptionTextColor
            title.font: Fonts.openSans(13, Font.MixedCase)
            popupColor: Colors.primaryColor
            height: 150
            width: 232

            Item{
                Layout.fillHeight: true
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
                onClicked: {
                    unloadFromMainLoader()
                    navigateToItem("qrc:/Pages/MainPage.qml")
                }
            }

        }
    }
}
