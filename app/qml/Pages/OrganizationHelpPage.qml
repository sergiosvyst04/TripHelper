import QtQuick 2.10
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import "../Singletons"
import "../Components"

BasePage {

    nextButtonVisible: true
    nextButtonText: qsTr("Next")
    nextButtonEnabled: buttonsGroup.checkState === Qt.PartiallyChecked
    onNextButtonClicked: {
        if(buttonsGroup.buttons[0].checked)
            navigateToItem("qrc:/Pages/SelfOrganizePage.qml")
        else
            navigateToItem("qrc:/Pages/TravelAgentHelpPage.qml")
    }

    ColumnLayout {
        spacing: 25
        anchors {
            fill: parent
            topMargin: 5
            leftMargin: 30
            rightMargin: 30
            bottomMargin: 185
        }

        PrimaryLabel {
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("What method do you\n prefer?")
        }

        Image {
            Layout.alignment: Qt.AlignHCenter
            source: "qrc:/images/assets/icons/fly.png"
            opacity: 0.5
            sourceSize: Qt.size(160* ScreenProperties.scaleRatioWidth, 133 * ScreenProperties.scaleRatioHeight)
        }

        ButtonGroup {
            id: buttonsGroup
            buttons: buttonsColumn.children
            exclusive: true
        }

        ColumnLayout {
            id: buttonsColumn
            Layout.topMargin: 10
            spacing: 25


            CheckButton {
                Layout.fillWidth: true
                checkable: true
                buttonText: "I want to organizate myself"
            }

            CheckButton {
                Layout.fillWidth: true
                checkable: true
                buttonText: "Travel agent help"
            }

        }


    }
}
