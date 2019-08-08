import QtQuick 2.10
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import "../Singletons"
import "../Components"

BasePage {
    nextButtonVisible: true
    nextButtonText: qsTr("Start")
    backButtonVisible: true
    onNextButtonClicked: {
        tripsModel.addTrip(tripName.text, dateField.depatureDate)
    }

    nextButtonEnabled: tripName.text != "" && dateField.fieldText != ""

    ColumnLayout {
        anchors {
            fill: parent
            leftMargin: 32
            rightMargin: 32
            bottomMargin: 165
        }


        Image {
            Layout.alignment: Qt.AlignHCenter
            source: "qrc:/images/assets/icons/start.png"
            sourceSize: Qt.size(175, 165)
            opacity: 0.4
        }

        LabeledTextEdit {
            id: tripName
            Layout.fillWidth: true
            label: qsTr("Trip Name")
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

}
