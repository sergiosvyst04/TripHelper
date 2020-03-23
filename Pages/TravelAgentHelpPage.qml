import QtQuick 2.10
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5
import "../Components"
import "../Singletons"
import CountriesCitiesModel 1.0
import TravelAgentsModel 1.0

BasePage {

    TravelAgentsModel {
        id: travelAgentsModel

    }

    CountriesCitiesModel {
        id: citiesModel

        Component.onCompleted: setCitiesWithTravelAgents(travelAgentsModel.citiesWithAgents)
    }


//===============================================================================================================


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

        LocationComboBox {
            id: cityComboBox
            Layout.preferredHeight: 30

            currentIndex: -1
            model: citiesModel
            onActivated: {
                currentIndex = index
                travelAgentsModel.getTravelAgentsOfNeededCity(textAt(currentIndex))
            }
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
