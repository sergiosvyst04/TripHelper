import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import "../Components"
import "../Singletons"

BasePage {
    nextButtonVisible: true
    nextButtonText: qsTr("Get started")

    ColumnLayout {
        spacing: 35
        anchors{
            fill: parent
            topMargin: 5
            bottomMargin: 50
            leftMargin: 30
            rightMargin: 32
        }

        PrimaryLabel {
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("Create Account")
        }

        Item {
            Layout.fillHeight: true
        }

        ColumnLayout {
            spacing: 9

            DescriptionText {
                Layout.fillWidth: true
                Layout.preferredHeight: 16
                font: Fonts.openSans(12, Font.MixedCase)
                text: qsTr("Country of residence")
                horizontalAlignment: Text.AlignLeft
                color: Colors.descriptionTextColor
            }

            LocationComboBox {
                id: countryComboBox
                Layout.preferredHeight: 30
                currentIndex: -1
                onActivated: {
                    currentIndex = index
                }

            }
        }

        ColumnLayout {
            spacing: 9

            DescriptionText {
                Layout.fillWidth: true
                Layout.preferredHeight: 16
                font: Fonts.openSans(12, Font.MixedCase)
                text: qsTr("City of residence")
                horizontalAlignment: Text.AlignLeft
                color: Colors.descriptionTextColor
            }

            LocationComboBox {
                id: cityComboBox
                Layout.preferredHeight: 30
                currentIndex: -1
                onActivated: {
                    currentIndex = index
                }

            }
        }

        Item {
            Layout.fillHeight: true
        }

        DescriptionText {
            Layout.alignment: Qt.AlignHCenter
            font: Fonts.openSansBold(13, Font.MixedCase)
            text: qsTr("Some text with agreemt with\n Privacy Policy and\n others")
        }
    }

}
