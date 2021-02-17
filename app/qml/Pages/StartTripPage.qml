import QtQuick 2.10
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import "../Singletons"
import "../Components"
import StartTripController 1.0

BasePage {
    nextButtonVisible: true
    nextButtonText: qsTr("Start")
    backButtonVisible: true
    onNextButtonClicked: startTripController.startTrip(tripName.text, dateField.depatureDate)

    nextButtonEnabled: tripName.text != "" && dateField.fieldText != ""


    StartTripController {
        id: startTripController

        Component.onCompleted: intialize(appController)
    }

    Connections {
        target: startTripController
        onTripStarted: loader.active = true
    }

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
            sourceSize: Qt.size(175 * ScreenProperties.scaleRatioWidth, 165 * ScreenProperties.scaleRatioHeight)
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

    Loader {
        id: loader
        active:  false

        sourceComponent:  Component {
            id: addIdeaPopup
            Popup {
                anchors.centerIn: parent

                implicitHeight: 150
                implicitWidth: 232

                padding: 0

                parent: Overlay.overlay
                modal: true
                visible: true

                background: Rectangle {
                    radius: 28
                    gradient: Gradient {
                        GradientStop {position: 0.0; color: Colors.primaryColor }
                        GradientStop {position: 0.45; color: Colors.white }
                    }
                }

                onAboutToHide: loader.active = false

                ColumnLayout {
                    anchors{
                        fill: parent
                        topMargin: 20
                        bottomMargin: 20
                        leftMargin: 10
                        rightMargin: 10
                    }

                    DescriptionText {
                        Layout.alignment: Qt.AlignHCenter
                        Layout.preferredWidth: parent.width
                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                        textFormat: Text.StyledText
                        font: Fonts.openSans(13, Font.MixedCase)
                        text: qsTr("<b>%1</b> was succesfully added to your trips").arg(tripName.text)
                    }

                    Item {
                        Layout.fillHeight: true
                    }

                    ColoredButton {
                        Layout.preferredHeight: 40
                        Layout.preferredWidth: 100
                        Layout.alignment: Qt.AlignHCenter
                        fontColor: Colors.white
                        color: Colors.primaryColor
                        text: qsTr("Ok")
                        layer.enabled: false
                        onClicked: {
                            loader.active = false
                            navigateBack()
                        }
                    }
                }
            }


        }

    }
}
