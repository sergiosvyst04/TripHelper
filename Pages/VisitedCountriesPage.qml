import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import QtQuick.Controls.Material 2.0
import "../Components"
import "../Singletons"

BasePage {
    backButtonVisible: true
    footer: Item{}

    property var tabCurrentIndex

    ColumnLayout {
        spacing: 20
        anchors {
            fill: parent
        }

        DescriptionText {
            Layout.alignment: Qt.AlignLeft
            Layout.topMargin: -50
            Layout.leftMargin: 50
            font: Fonts.openSansBold(16, Font.MixedCase)
            text: qsTr("Sergio Svyst")
        }


        TabBar {
            id: tabBar
            Layout.fillWidth: true
            Material.accent: Colors.primaryColor
            contentHeight: 40

            currentIndex: swipeView.currentIndex

            onCurrentIndexChanged: {
                swipeView.currentIndex = tabBar.currentIndex
            }

            background: Rectangle {
                anchors.fill: parent
                color: Colors.white
                Rectangle {
                    width: parent.width
                    height: 2
                    color: Colors.primaryColor
                    anchors.bottom: parent.bottom
                    opacity: 0.6
                }
            }

            CountryTabButton {
                text: qsTr("Countries")
                tabText.font: checked ? Fonts.openSansBold(13, Font.MixedCase)
                                      : Fonts.openSans(13, Font.MixedCase)
                tabText.layer.enabled: false
            }

            CountryTabButton {
                text: qsTr("Cities")
                tabText.font:  checked ? Fonts.openSansBold(13, Font.MixedCase)
                                       : Fonts.openSans(13, Font.MixedCase)
                tabText.layer.enabled: false
            }
        }

        SwipeView {
            id: swipeView
            Layout.topMargin: -10
            Layout.fillHeight: true
            Layout.fillWidth: true

//            currentIndex: tabBar.currentIndex
            currentIndex:  tabCurrentIndex

            ListView {
                id: countriesListView
                Layout.fillHeight: true
                Layout.fillWidth: true
                spacing: 22
                model: 12
                clip: true


                delegate: VisitedCountryItem {

                    width: parent.width
                    height: 40
                    country: qsTr("Chile")
                    flag: "qrc:/images/assets/icons/Flags/%1.png".arg(country)
                }
            }

            ListView {
                id: citiesListView
                Layout.fillHeight: true
                Layout.fillWidth: true
                spacing: 22
                model: 24
                clip: true

                delegate: RowLayout {
                    width: parent.width
                    DescriptionText {
                        Layout.leftMargin: 45
                        font: Fonts.openSans(15, Font.MixedCase)
                        text: "Allesund"
                    }

                    Item {
                        Layout.fillWidth: true
                    }

                    ColoredButton {
                        Layout.rightMargin: 25
                        Layout.preferredWidth: 85
                        Layout.preferredHeight: 35

                        color: Colors.primaryColor
                        font: Fonts.openSans(12, Font.MixedCase)
                        fontColor: Colors.white
                        text: qsTr("See photos")
                        layer.enabled: false
                    }
                }
            }

        }
    }

    Rectangle {
        id: gradientSource
        anchors.bottom: parent.bottom
        width: parent.width
        height: 70
        gradient: Gradient {
            GradientStop { position: 0.0; color: Qt.rgba(45, 156, 219, 0) }
            GradientStop { position: 0.3; color: Qt.rgba(45, 156, 219, .6) }
            GradientStop { position: 1.0; color: Qt.rgba(45, 156, 219, 1) }
        }
    }

}
