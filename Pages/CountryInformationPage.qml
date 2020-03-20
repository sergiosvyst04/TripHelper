import QtQuick 2.13
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import QtQuick.Controls.Material 2.0
import "../Components"
import "../Singletons"
import CountryInfoGenerator 1.0

BasePage {
    id: root
    backButtonVisible: true
    nextButtonVisible: false
    property var information : /*JSON.parse(CountriesModel.countries)*/

                               CountryInfoGenerator {
        id: infoGenerator

        Component.onCompleted: fetchNeededCountryInfo(neededCountry.text)
    }

    ColumnLayout {
        spacing: 50
        anchors {
            fill: parent
        }

        RowLayout {
            Layout.leftMargin: root.width / 8
            Layout.rightMargin: root.width / 8
            Layout.alignment: Qt.AlignHCenter

            DescriptionText {
                font: Fonts.openSansBold(24, Font.Mixed)
                text: qsTr("Chile")
                layer.enabled: true
                layer.effect: DropShadow {
                    color: "lightgrey"
                    horizontalOffset: 0
                    verticalOffset: 5
                    radius: 15
                    samples: 12
                }
            }

            Item {
                Layout.fillWidth: true
            }

            Image {
                source: "qrc:/images/assets/icons/Flags/Chile.png"
                sourceSize: Qt.size(140, 120)
                layer.enabled: true
                layer.effect: DropShadow {
                    color: "lightgrey"
                    horizontalOffset: 0
                    verticalOffset: 5
                    radius: 15
                    samples: 12
                }
            }
        }

        RowLayout {
            TextField {
                id: neededCountry
                Layout.topMargin: -45
                Layout.preferredWidth: 100
                Layout.preferredHeight: 40
                text: "sweden"
            }

            Button {
                height: 30
                width: 60
                text: "fetch"
                onClicked: infoGenerator.fetchNeededCountryInfo(neededCountry.text.toLowerCase())
            }

        }

        TabBar {
            id: tabBar
            Layout.fillWidth: true
            Material.accent: Colors.primaryColor

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
                text: qsTr("General\n Information")
            }

            CountryTabButton {
                text: qsTr("Interesting\nfacts")
            }

            CountryTabButton {
                text: qsTr("Celebrities")
            }

            CountryTabButton {
                text: qsTr("Biggest\ncities")
            }

            CountryTabButton {
                text: qsTr("Souvenirs")
            }

        }

        SwipeView {
            id: swipeView
            Layout.topMargin: -40
            Layout.bottomMargin: 10
            Layout.fillHeight: true
            Layout.fillWidth: true

            currentIndex: tabBar.currentIndex
            onCurrentIndexChanged: tabBar.currentIndex = currentIndex

            ScrollableText {
                contentWidth: root.width
                informationText: infoGenerator.generalInformation
            }

            ScrollableText {
                contentWidth: root.width
                informationText: infoGenerator.interestingFacts
            }

            ScrollableText {
                contentWidth: root.width
                informationText: infoGenerator.inventions
            }

            ScrollableText {
                contentWidth: root.width
                informationText: infoGenerator.kitchen
            }

            ScrollableText {
                contentWidth: root.width
                informationText: infoGenerator.souvenirs
            }

        }

    }
}
