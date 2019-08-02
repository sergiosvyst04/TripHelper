import QtQuick 2.13
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0
import "../Singletons"
import "../Components"


ColoredButton {
    property alias tripName: tripName.text
    property alias dates: dates.text
    property alias flags: flagsListView.model
    property alias citiesCount: citiesCount.text
    property alias photoCount: photosCount.text
    property alias ideasCount: ideasCount.text

    layer.enabled: false
    background: Rectangle {
        id: back
        anchors.fill: parent
        radius: 28

        gradient: Gradient {
            GradientStop {position: 0.0; color: "#FD5454"}
            GradientStop {position: 0.6; color: Qt.rgba(255, 230, 0, .395833)}
            GradientStop {position: 1.0; color: Qt.rgba(0, 201, 245, 0.2)}
        }
    }

    ColumnLayout {
        spacing: 6
        anchors {
            fill: parent
            topMargin: 21
            bottomMargin: 10
            leftMargin: 18
            rightMargin: 25
        }

        DescriptionText {
            id: tripName
            Layout.alignment: Qt.AlignLeft
            Layout.leftMargin: 16
            color: Colors.grey
            font: Fonts.openSansBold(16, Font.MixedCase)
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 1
            color: Colors.tripItemLineColor
        }

        DescriptionText {
            id: dates
            Layout.alignment: Qt.AlignRight
        }

        ListView {
            id: flagsListView
            Layout.topMargin: 6
            Layout.fillWidth: true
            Layout.preferredHeight: 22

            highlightRangeMode: ListView.StrictlyEnforceRange
            preferredHighlightBegin: width / 2 - 10
            preferredHighlightEnd: width / 2 + 10

            currentIndex: count / 2

            spacing: 20
            orientation: ListView.Horizontal
            clip: true

            delegate: Image {
                source: modelData
                sourceSize: Qt.size(25, 20)
            }
        }

        RowLayout {
            Layout.topMargin: 7
            spacing: 15

            RowLayout {
                spacing: 4
                Image {
                    source: "qrc:/images/assets/icons/visitedCities.png"
                    sourceSize: Qt.size(30, 30)
                }

                DescriptionText {
                   id: citiesCount
                   color: Colors.grey
                }
            }

            RowLayout {
                spacing: 4
                Image {
                    source: "qrc:/images/assets/icons/photo.png"
                    sourceSize: Qt.size(23, 20)
                }

                DescriptionText {
                   id: photosCount
                   color: Colors.grey
                }
            }

            RowLayout {
                spacing: 4
                Image {
                    Layout.bottomMargin: 9
                    source: "qrc:/images/assets/icons/idea5.png"
                    sourceSize: Qt.size(25, 25)
                }

                DescriptionText {
                   id: ideasCount
                   color: Colors.grey
                }
            }

        }
    }


}
