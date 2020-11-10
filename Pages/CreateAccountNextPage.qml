import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import "../Components"
import "../Singletons"
import CountriesCitiesModel 1.0

BasePage {
    nextButtonVisible: true
    nextButtonText: qsTr("Get started")
    onNextButtonClicked: {
        authService.saveUser(userData.email, userData.password)
    }

    property var userData

    Connections {
        target: authService
        onUserSaved: {
            userAccountController.saveUserInfo(userData.fullName, cityComboBox.currentText, countryComboBox.currentText)
            navigateToItem("qrc:/Pages/AddVisitedLocationsPage.qml")
        }
    }


    CountriesCitiesModel {
        id: countriesModel
        Component.onCompleted: getCountries()
    }

    CountriesCitiesModel {
        id: citiesModel
    }

    ColumnLayout {
        spacing: 35
        anchors{
            fill: parent
            topMargin: 5
            bottomMargin: 50
            leftMargin: 30
            rightMargin: 32
        }

        PrimaryLabel {
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("Create Account")
        }

        Item {
            Layout.fillHeight: true
        }

        ColumnLayout {
            spacing: 9

            DescriptionText {
                Layout.fillWidth: true
                Layout.preferredHeight: 16
                font: Fonts.openSans(12, Font.MixedCase)
                text: qsTr("Country of residence")
                horizontalAlignment: Text.AlignLeft
                color: Colors.descriptionTextColor
            }

            LocationComboBox {
                id: countryComboBox
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
                Layout.fillWidth: true
                Layout.preferredHeight: 16
                font: Fonts.openSans(12, Font.MixedCase)
                text: qsTr("City of residence")
                horizontalAlignment: Text.AlignLeft
                color: Colors.descriptionTextColor
            }

            LocationComboBox {
                id: cityComboBox
                Layout.preferredHeight: 30 * ScreenProperties.scaleRatioHeight

                enabled: false
                currentIndex: -1
                model: citiesModel
                onActivated: {
                    currentIndex = index
                }

            }
        }

        Item {
            Layout.fillHeight: true
        }

        DescriptionText {
            Layout.alignment: Qt.AlignHCenter
            font: Fonts.openSansBold(13, Font.MixedCase)
            textFormat: Text.PlainText
            text: qsTr("Some text with agreement with\n Privacy Policy and\n others")
        }
    }

}
