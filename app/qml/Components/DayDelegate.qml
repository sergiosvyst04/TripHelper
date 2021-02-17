import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import "../Singletons"
import "../Components"

ColoredButton {
    id: root
    property alias countOfCities: countOfCities.text
    property alias countOfPhotos: countOfPhotos.text
    property alias dayNumber: dayText.text
    property alias date: dateText.text
    property color gradColor: "#DEFF5C"

    layer.enabled: false

    background: Rectangle {
        radius: 28
        gradient: Gradient {
            id: gradientt
            GradientStop {position: 0.0; color: Qt.rgba(0, 240, 255, 0.65) }
            GradientStop {position: 0.86; color: root.gradColor }
        }
    }

    ColumnLayout {
        spacing: 10
        anchors {
            fill: parent
            topMargin: 12
            bottomMargin: 25
            leftMargin: 7
            rightMargin: 10
        }

        DescriptionText {
            id: dayText
            color: Colors.grey
            Layout.alignment: Qt.AlignHCenter
            font: Fonts.openSansBold(15, Font.Mixed)
        }

        DescriptionText {
            id: dateText
            Layout.alignment: Qt.AlignHCenter
            textFormat: Text.PlainText
            font: Fonts.openSans(13, Font.MixedCase)
        }

        Item {
            Layout.fillHeight: true
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: 20

            RowLayout {
                spacing: 4

                Image {
                    source: "qrc:/images/assets/icons/photo.png"
                    sourceSize: Qt.size(15, 15)
                }

                DescriptionText {
                    id: countOfPhotos
                    font: Fonts.openSans(11, Font.MixedCase)
                }
            }

            RowLayout {
                spacing: 4

                Image {
                    source: "qrc:/images/assets/white icons/place.png"
                    sourceSize: Qt.size(15, 15)
                }

                DescriptionText {
                    id: countOfCities
                    font: Fonts.openSans(11, Font.MixedCase)
                }
            }
        }
    }
}
