import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import "../Components"
import "../Singletons"
import CountriesCitiesModel 1.0

BasePage {
    nextButtonText: qsTr("Start")
    nextButtonVisible: true
    backButtonVisible: false

    onNextButtonClicked: navigateToItem("qrc:/Pages/MainPage.qml")

    CountriesCitiesModel {
        id: countriesModel
        Component.onCompleted: getCountries()
    }

    Connections {
        target: visitedLocationsController
        onLocationAdded: loadToMainLoader(newCountryPopup)
    }

    ColumnLayout {
        spacing: 20
        anchors {
            fill: parent
            rightMargin: 25
            leftMargin: 25
        }

        Image {
            Layout.alignment: Qt.AlignHCenter
            source: "qrc:/images/assets/icons/globe.png"
            sourceSize: Qt.size(120 * ScreenProperties.scaleRatioWidth, 120 * ScreenProperties.scaleRatioHeight)
            opacity: 0.4
        }

        DescriptionText {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: parent.width
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            lineHeightMode: Text.FixedHeight
            lineHeight: 20
            text: qsTr("It is important for future application using to add locations, where you have already been.")
        }

        ColumnLayout {
            Layout.topMargin: 10
            spacing: 9

            DescriptionText {
                Layout.fillWidth: true
                Layout.preferredHeight: 16
                font: Fonts.openSans(12, Font.MixedCase)
                text: qsTr("Country")
                horizontalAlignment: Text.AlignLeft
                color: Colors.descriptionTextColor
            }

            RowLayout {
                spacing: 0
                LocationComboBox {
                    id: countryComboBox
                    Layout.preferredHeight: 30
                    currentIndex: -1
                    model: countriesModel

                    onActivated: {
                        currentIndex = index
                    }
                }

                Image {
                    Layout.leftMargin: -40
                    Layout.bottomMargin: 10
                    source: countryComboBox.currentIndex == -1 ? "" :  "qrc:/images/assets/icons/Flags/%1.png".arg(countryComboBox.textAt(countryComboBox.currentIndex))
                    sourceSize: Qt.size(30, 30)
                }

            }
        }

        LabeledTextEdit {
            id: cityField
            Layout.fillWidth: true
            label: qsTr("City")
        }

        ColoredButton {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredHeight: 30 * ScreenProperties.scaleRatioHeight
            Layout.preferredWidth: 100
            text: qsTr("Add")
            font: Fonts.openSans(13)
            color: Colors.addToListButtonColor
            fontColor: Colors.white
            enabled: cityField.text !== "" && countryComboBox.currentIndex !== -1
            opacity: enabled ? 1 : 0.4

            onClicked: visitedLocationsController.addLocation(countryComboBox.textAt(countryComboBox.currentIndex), cityField.text)
        }

        Item {
            Layout.fillHeight: true
        }
    }


    Component {
        id: newCountryPopup
        GeneralPopup {
            popupColor: Colors.primaryColor
            height: 250
            width: 232
            title.visible: false

            Image {
                id: addedCountryFlag
                Layout.alignment: Qt.AlignHCenter
                sourceSize: Qt.size(60, 60)
                source: "qrc:/images/assets/icons/Flags/%1.png".arg(countryComboBox.textAt(countryComboBox.currentIndex))
            }

            DescriptionText {
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: parent.width
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                textFormat: Text.PlainText
                text: qsTr("%1, %2 was succesfully added\n to your locations").arg(cityField.text).arg(countryComboBox.textAt(countryComboBox.currentIndex))
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
                    unloadFromMainLoader()
                    cityField.text = ""
                }
            }
        }
    }

}
