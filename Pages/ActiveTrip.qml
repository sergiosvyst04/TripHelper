import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.10
import "../Singletons"
import "../Components"

BasePage {
    backButtonVisible: true
    footer: Item{}

    ColoredButton {
        height: 80
        width: 60
        color: Colors.checkboxColor
        anchors {
            horizontalCenter: parent.left
            verticalCenter: parent.verticalCenter
        }

        Image {
            anchors {
                right: parent.right
                rightMargin: 3
                verticalCenter: parent.verticalCenter
            }

            source: "qrc:/images/assets/icons/front.png"
            sourceSize: Qt.size(25, 25)
            rotation: 90
            opacity: 0.6
        }
        onClicked: swipeView.currentIndex = 0
    }

    ColumnLayout{
        anchors {
            fill: parent
        }

        PrimaryLabel {
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("Trip Name")
        }

        ListView {
            Layout.fillWidth: true
            Layout.leftMargin: 13
            Layout.preferredHeight: 130

            model: 5
            spacing: 12
            orientation: ListView.Horizontal
            delegate: DayDelegate {
                width: 95
                height: parent.height
                dayNumber: qsTr("Day %1").arg(index + 1)
                date: Qt.formatDate(new Date(), "d MMM \n yyyy")
            }
        }


        ColumnLayout {

            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.rightMargin: 73
            Layout.leftMargin: 73
            spacing: 11

            ActiveTripActionItem {
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                image: "qrc:/images/assets/white icons/note.png"
                actionText: qsTr("Add note")
                onClicked: navigateToItem("qrc:/Pages/AddNotePage.qml")
            }

            ActiveTripActionItem {
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                image: "qrc:/images/assets/white icons/idea.png"
                actionText: qsTr("Add new idea")
                onClicked:{
                    loader.sourceComponent = addIdeaPopup
                    loader.active = true
                }
            }

            ActiveTripActionItem {
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                image: "qrc:/images/assets/white icons/place.png"
                actionText: qsTr("Add favourite place")
            }

            ColoredButton {
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                color: Colors.checkInColor
                text: qsTr("Check-In")
                font: Fonts.openSansBold(13, Font.MixedCase)
                fontColor: Colors.shadowColor
                layer.effect: DropShadow {
                    color: Colors.checkInColor
                    horizontalOffset: 0
                    verticalOffset: 5
                    radius: 7
                    samples: 10
                }
                onClicked: {
                    loader.sourceComponent = checkInPopup
                    loader.active = true
                }
            }

            ColoredButton {
                Layout.fillWidth: true
                Layout.topMargin: 20
                Layout.preferredHeight: 50
                color: Colors.redButtonColor
                text: qsTr("End of trip")
                fontColor: Colors.white
                font: Fonts.openSansBold(13, Font.MixedCase)

                onClicked: navigateToItem("qrc:/Pages/EndTripPage.qml")

                layer.effect: DropShadow {
                    color: Colors.redButtonColor
                    horizontalOffset: 0
                    verticalOffset: 5
                    radius: 7
                    samples: 10
                }
            }
        }
    }

    Loader {
        id: loader
        active: false

        Component {
            id: checkInPopup
            Popup {
                anchors.centerIn: parent

                implicitHeight: 435
                implicitWidth: 295

                padding: 0

                parent: Overlay.overlay
                modal: true
                visible: true

                background: Rectangle {
                    radius: 28
                    color: Colors.checkInPopupColor
                    border.width: 2
                    border.color: Colors.descriptionTextColor
                }

                onAboutToHide: loader.active = false

                ColumnLayout {
                    anchors{
                        topMargin: 20
                        bottomMargin: 20
                        leftMargin: 25
                        rightMargin: 25
                        fill: parent
                    }

                    DescriptionText {
                        Layout.alignment: Qt.AlignHCenter
                        textFormat: Text.PlainText
                        font: Fonts.openSansBold(16, Font.MixedCase)
                        text: qsTr("Welcome to %1\n %2").arg("Allesund").arg("UserName")
                    }

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
                        }

                        ColoredButton {
                            Layout.alignment: Qt.AlignHCenter
                            Layout.preferredHeight: 45
                            Layout.fillWidth: true
                            color: Colors.primaryColor
                            font: Fonts.openSansBold(13, Font.MixedCase)
                            fontColor: Colors.white
                            text: qsTr("Favourite places")
                        }

                        ColoredButton {
                            Layout.alignment: Qt.AlignHCenter
                            Layout.preferredHeight: 45
                            Layout.fillWidth: true
                            color: Colors.primaryColor
                            font: Fonts.openSansBold(13, Font.MixedCase)
                            fontColor: Colors.white
                            text: qsTr("Thanks")
                        }

                    }

                }
            }
        }

            Component {
                id: addIdeaPopup
                Popup {
                    anchors.centerIn: parent

                    implicitHeight: 315
                    implicitWidth: 232

                    padding: 0

                    parent: Overlay.overlay
                    modal: true
                    visible: true

                    background: Rectangle {
                        radius: 28
                    }

                    onAboutToHide: loader.active = false

                    ColumnLayout {
                        spacing: 20
                        anchors {
                            fill: parent
                            topMargin: 15
                            leftMargin: 24
                            rightMargin: 24
                            bottomMargin: 24
                        }

                        DescriptionText {
                            Layout.alignment: Qt.AlignHCenter
                            text: qsTr("Add new idea")
                            font: Fonts.openSansBold(16, Font.MixedCase)
                        }

                        DescriptionText {
                            Layout.alignment: Qt.AlignHCenter
                            textFormat: Text.PlainText
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

                        Item {
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
                            onClicked: loader.active = false
                        }
                    }
                }
            }


        }
    }


