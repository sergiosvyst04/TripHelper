import QtQuick 2.10
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5
import "../Components"
import "../Singletons"

BasePage {
    nextButtonVisible: true
    nextButtonText: qsTr("Next")
    onNextButtonClicked:  {
        navigateToItem("qrc:/Pages/NeedHelpPage.qml")
    }

    nextButtonEnabled: countryComboBox.currentIndex > -1 && cityComboBox.currentIndex > -1
                       && dateField.fieldText != "" && amountOfPersonsField.validated

    ColumnLayout {
        spacing: 70
        anchors {
            fill: parent
            topMargin: 5
            leftMargin: 32
            rightMargin: 32
            bottomMargin: 80
        }

        PrimaryLabel {
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("Specify the details,\n please")
        }

        ColumnLayout {
            spacing: 15
            ColumnLayout {
                spacing: 9

                DescriptionText {
                    font: Fonts.openSans(12, Font.MixedCase)
                    text: qsTr("Country destination")
                    horizontalAlignment: Text.AlignLeft
                }

                LocationComboBox {
                    id: countryComboBox
                    Layout.fillWidth: true
                    Layout.preferredHeight: 30
                    currentIndex: -1
                    onActivated: {
                        currentIndex = index
                    }
                }
            }

            ColumnLayout {
                spacing: 9

                DescriptionText {
                    font: Fonts.openSans(12, Font.MixedCase)
                    text: qsTr("City destination")
                    horizontalAlignment: Text.AlignLeft
                }

                LocationComboBox {
                    id: cityComboBox
                    Layout.fillWidth: true
                    Layout.preferredHeight: 30
                    currentIndex: -1
                    onActivated: currentIndex = index
                }
            }

            PopupActivationButton {
                id: dateField
                Layout.fillWidth: true
                Layout.preferredHeight: 35
                labelText: qsTr("Depature date")
                popupContentItem: TripCalendar {
                    minimumDate: new Date()
                    onPressAndHold: {
                        dateField.popupItem.close()
                        dateField.fieldText = Qt.formatDate(date, "d MMMM yyyy")
                    }
                }
            }

            LabeledTextEdit {
                id: amountOfPersonsField
                Layout.fillWidth: true
                Layout.preferredHeight: 35
                label: qsTr("Amount of persons")
                validator: Utils.validateIntegersOnly
                warningText: qsTr("Input integers only")
            }
        }
    }


}
