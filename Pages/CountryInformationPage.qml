import QtQuick 2.13
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import QtQuick.Controls.Material 2.0
import "../Components"
import "../Singletons"

BasePage {
    id: root
    backButtonVisible: true
    property var information : /*JSON.parse(CountriesModel.countries)*/

    ListModel {
        id: countryInformationModel

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
            Layout.fillHeight: true
            Layout.fillWidth: true


            Repeater {
                id: countryInformationRepeater

                DescriptionText {
                    font: Fonts.openSans(14, Font.MixedCase)
                }
            }

        }

    }
}
