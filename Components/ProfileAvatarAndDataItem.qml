import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import "../Singletons"
import "../Components"

ColumnLayout {

    RowLayout {
        DescriptionText {
            text: qsTr("Sergio Svyst")
            font: Fonts.openSansBold(24, Font.MixedCase)
        }

        Item {
            Layout.fillWidth: true
        }

        Image {
            Layout.rightMargin: 25
            Layout.topMargin: 10
            source: "qrc:/images/assets/icons/avatar-372-456324.png"
            sourceSize: Qt.size(65, 65)
        }

    }

    RowLayout {
        Layout.leftMargin: 10
        spacing: 44

        ColoredButton {
            Layout.preferredWidth: 75
            Layout.preferredHeight: 47
            layer.enabled: false
            ColumnLayout {
                DescriptionText {
                    id: numberOfVisitedCountries
                    Layout.alignment: Qt.AlignHCenter
                    font: Fonts.openSansBold(18)
                    text: "16"
                }

                DescriptionText {
                    text: qsTr("Visited countries")
                    opacity: 0.8
                }
            }
            onClicked: navigateToItem("qrc:/Pages/VisitedCountriesPage.qml", {tabCurrentIndex : 0})

        }

        ColoredButton {
            Layout.preferredWidth: desctTxt.width
            Layout.preferredHeight: 47
            layer.enabled: false
            ColumnLayout {
                DescriptionText {
                    id: numberOFVisitedCities
                    Layout.alignment: Qt.AlignHCenter
                    font: Fonts.openSansBold(18)
                    text: "55"
                }

                DescriptionText {
                    id: desctTxt
                    text: qsTr("Visited cities")
                    opacity: 0.8
                }
            }
            onClicked: navigateToItem("qrc:/Pages/VisitedCountriesPage.qml", {tabCurrentIndex : 1})
        }
    }

    RowLayout{
        Layout.topMargin: 11

        Image {
            source: "qrc:/images/assets/icons/location.png"
            sourceSize: Qt.size(14, 14)
            opacity: 0.5
        }

        DescriptionText {
            text: qsTr("Current location : <b>%1</b>").arg("Sri Jayawardenapure Kotte")
        }
    }

}



