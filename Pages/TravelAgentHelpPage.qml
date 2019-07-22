import QtQuick 2.10
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5
import "../Components"
import "../Singletons"

BasePage {


    ListModel {
        id: travelAgentsModel

        ListElement {name : "Loyal touristic"; address: "st.Saharova, 42"; phoneNumber : "+390634578863"}
        ListElement {name : "Coral Travel"; address: "st.Doroshenka, 52"; phoneNumber : "+390634578863"}
        ListElement {name : "TUI"; address: "st.Porichkova, 15"; phoneNumber : "+390634578863"}
        ListElement {name : "Akkord tour"; address: "st.Novy Svit, 101"; phoneNumber : "+390634578863"}
        ListElement {name : "Anex Tour"; address: "st.Volodymyra Velykoho, 42"; phoneNumber : "+390634578863"}
        ListElement {name : "Anro touristic"; address: "st.Danyla Halytskoho, 122"; phoneNumber : "+390634578863"}
        ListElement {name : "Anro touristic"; address: "st.Danyla Halytskoho, 122"; phoneNumber : "+390634578863"}
        ListElement {name : "Anro touristic"; address: "st.Danyla Halytskoho, 122"; phoneNumber : "+390634578863"}
        ListElement {name : "Anro touristic"; address: "st.Danyla Halytskoho, 122"; phoneNumber : "+390634578863"}
        ListElement {name : "Anro touristic"; address: "st.Danyla Halytskoho, 122"; phoneNumber : "+390634578863"}

    }

    ColumnLayout {
        spacing: 28
        anchors {
            fill: parent
            leftMargin: 40
            rightMargin: 45
            topMargin: 5
        }

        PrimaryLabel {
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("Best travel agents\n of your city")
        }

        DescriptionText {
            Layout.alignment: Qt.AlignHCenter
            font: Fonts.openSansBold(16, Font.MixedCase)
            text: qsTr("at one click distance")
        }

        ListView {
            clip: true
            Layout.topMargin: 25
            Layout.fillHeight: true
            Layout.fillWidth: true
            model: travelAgentsModel
            spacing: 15
            delegate: TravelAgentItem {
                width: parent.width
                name: model.name
                address: model.address
            }
        }
    }
}
