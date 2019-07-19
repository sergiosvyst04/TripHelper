import QtQuick 2.10
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import "../Singletons"
import "../Components"

BasePage {
     nextButtonVisible: true
     nextButtonText: qsTr("Start")
     backButtonVisible: true

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
