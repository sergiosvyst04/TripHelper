import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import "../Components"
import "../Singletons"
import CountriesCitiesModel 1.0


BasePage {
    nextButtonVisible: true
    nextButtonText: qsTr("Save")
    nextButtonEnabled: isDirty

    onNextButtonClicked: {
        userAccountController.name = fullNameField.text
        userAccountController.country = countryComboBox.textAt(countryComboBox.currentIndex)
        userAccountController.city = cityComboBox.textAt(cityComboBox.currentIndex)
    }

    property bool isDirty: false

    CountriesCitiesModel {
        id: countriesModel
        Component.onCompleted: {
            getCountries()
            countryComboBox.currentIndex = countryComboBox.find(userAccountController.country)
            citiesModel.getCities(countryComboBox.textAt(countryComboBox.currentIndex))
            cityComboBox.currentIndex = cityComboBox.find(userAccountController.city)
        }
    }

    CountriesCitiesModel {
        id: citiesModel

    }

    Connections {
        target:  userAccountController
        onUserInfoUpdated: {
            loadingImage.visible = true
            loadingEffect.start()
        }
    }

    ColumnLayout {
        anchors {
            fill: parent
            leftMargin: 20
            rightMargin: 20
        }

        spacing: 20

        DescriptionText {
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("Personal details")

        }

        LabeledTextEdit {
            id: fullNameField
            Layout.fillWidth: true
            label: qsTr("Full name")
            text: userAccountController.name
            onTextChanged: {
                if(text !== userAccountController.name)
                    isDirty = true
            }
        }

        LabeledTextEdit {
            id: emailField
            Layout.fillWidth: true
            Layout.topMargin: -15
            label: qsTr("Email")
            text: qsTr("therealsvyst04@ukr.net")
        }

        ColumnLayout {
            Layout.topMargin: -15
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
                Layout.preferredHeight: 30
                currentIndex: -1
                model: countriesModel

                onCurrentIndexChanged: {
                    if(textAt(currentIndex) !== userAccountController.country)
                        isDirty = true
                }

                onActivated: {
                    currentIndex = index
                    cityComboBox.enabled = true
                    citiesModel.getCities(textAt(currentIndex))
                }
            }
        }

        ColumnLayout {
            Layout.topMargin: 10
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
                Layout.preferredHeight: 30
                currentIndex: -1
                model: citiesModel
                onActivated: {
                    currentIndex = index
                }

                onCurrentIndexChanged: {
                    if(textAt(currentIndex) !== userAccountController.city)
                        isDirty = true
                }
            }
        }

        Item {
            Layout.fillHeight: true
        }
    }

    Image {
        id: loadingImage
        anchors.centerIn: parent
        visible: false
        sourceSize: Qt.size(80, 80)
        source: "qrc:/images/assets/icons/loading.png"
    }

    NumberAnimation {
        id: loadingEffect
        target: loadingImage
        property: "rotation"
        from: 0
        to: 99
        duration: 500
        running: false
        onStopped: {
            navigateBack();
        }
    }


}
