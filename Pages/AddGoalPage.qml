import QtQuick 2.10
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.12
import "../Singletons"
import "../Components"
//import GoalsModel 1.0

BasePage {
    nextButtonVisible: true
    nextButtonText: qsTr("Add goal")
    backButtonVisible: true
    onNextButtonClicked: {
        goalsModel.addGoal(countryComboBox.model[countryComboBox.currentIndex], cityComboBox.model[cityComboBox.currentIndex],
                           Date.fromLocaleString(Qt.locale(), dateField.text, "d MMMM yyyy"))
    }


//    GoalsModel {
//        id: goalsModel
//    }


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
            sourceSize: Qt.size(160, 145)
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
                Layout.preferredHeight: 16
                font: Fonts.openSans(12, Font.MixedCase)
                text: qsTr("City destination")
                horizontalAlignment: Text.AlignLeft
                color: Colors.descriptionTextColor
            }

            LocationComboBox {
                id: cityComboBox
                Layout.fillWidth: true
                Layout.preferredHeight: 30
                currentIndex: -1
                onActivated: {
                    currentIndex = index
                }

            }
        }

        PopupActivationButton {
            id: dateField
            labelText: qsTr("Depature date")
            popupContentItem: TripCalendar {
                minimumDate: new Date()
                onPressAndHold: {
                    dateField.popupItem.close()
                    dateField.fieldText = Qt.formatDate(date, "d MMMM yyyy")
                }

            }
        }
    }
}
