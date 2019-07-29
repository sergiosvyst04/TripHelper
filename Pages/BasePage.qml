import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import "../Singletons"
import "../Components"

Page {
    id: root
    property bool backButtonVisible: rootStackView.depth > 1
    property bool nextButtonVisible: false
    property alias nextButtonEnabled: nextButton.enabled
    property string nextButtonText: qsTr("Next")
    property alias nextButton: nextButton
    property bool navigationBarVisible: false
    property color bgColor: Colors.white

    signal nextButtonClicked()

    background: Rectangle {
        color: bgColor
    }

    font: Fonts.openSansBold(16, Font.MixedCase)
    header: Rectangle {
        height: 52
        color: "transparent"
        ColoredButton {
            color: "transparent"
            layer.enabled: false
            Image {
                anchors.centerIn: parent
                source: "qrc:/images/assets/icons/backButton.png"
                sourceSize: Qt.size(40, 30)
            }

            visible: backButtonVisible
            anchors {
                verticalCenter: parent.verticalCenter
                left:  parent.left
                leftMargin: 20
            }
            onClicked: {
                navigateBack();
            }
        }
    }

    footer: Item {
        height: 100
        ColoredButton {
            id: nextButton
            width: 240
            height: 46
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            visible: nextButtonVisible
            color: enabled ? Colors.primaryColor : Colors.secondaryColor
            font: Fonts.openSans(16, Font.AllUppercase)
            fontColor:  nextButton.enabled ? Colors.white : Colors.primaryColor
            text: nextButtonText

            onClicked: {
                nextButtonClicked();
            }
        }
    }
}
