import QtQuick 2.10
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.10
import "../Components"
import "../Singletons"

BasePage {
    nextButtonVisible: true
    nextButtonText: qsTr("Add note")

    ColumnLayout {
        spacing: 34
        anchors {
            fill: parent
            topMargin: 5
            leftMargin: 10
            rightMargin: 10
        }

        PrimaryLabel {
            Layout.fillWidth: true
            text: qsTr("Remember this day forever")
            textFormat: Text.PlainText
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font: Fonts.openSansBold(22, Font.MixedCase)
        }

        DescriptionText {
            Layout.alignment: Qt.AlignHCenter
            font: Fonts.openSansBold(14, Font.MixedCase)
            textFormat: Text.PlainText
            text: qsTr("Write something interesting\n about today")
        }


        ScrollView {
            Layout.topMargin: 10
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredHeight: 195
            Layout.preferredWidth: 280
            ScrollBar.vertical.policy: ScrollBar.AlwaysOff
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

            TextArea {
                width: 280
                height: 195
                clip: true
                color: Colors.grey

                leftPadding: 20
                topPadding: 15
                rightPadding: 20
                bottomPadding: 15

                wrapMode: Text.WrapAtWordBoundaryOrAnywhere

                placeholderText: qsTr("today...")
                background:  Rectangle {
                    anchors.fill: parent
                    color: Colors.textAreaColor
                    radius: 15
                    opacity: 0.4
                    layer.enabled: true
                    layer.effect: DropShadow {
                        color: "lightgrey"
                        horizontalOffset: 0
                        verticalOffset: 5
                        radius: 15
                        samples: 12
                    }
                }
                font: Fonts.openSans(13, Font.MixedCase)
            }

        }

        Item {
            Layout.fillHeight: true
        }
    }

}
