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
            bottomMargin: 8
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

        ColumnLayout {
            Layout.fillWidth: true

            DescriptionText {
                Layout.alignment: Qt.AlignLeft
                font: Fonts.openSans(12, Font.MixedCase)
                text: qsTr("Choose needed city")
            }

            LocationComboBox {
                id: cityComboBox
                Layout.preferredHeight: 30 * ScreenProperties.scaleRatioHeight

                currentIndex: -1
                model: citiesModel
                onActivated: {
                    currentIndex = index
                    travelAgentsModel.getTravelAgentsOfNeededCity(textAt(currentIndex))
                }
            }

        }

        ListView {
            id: travelAgentsListView
            clip: true
            Layout.fillHeight: true
            Layout.fillWidth: true
            model: travelAgentsModel
            spacing: 15
            delegate: TravelAgentItem {
                width: travelAgentsListView.width
                name: model.name
                address: model.address
            }
        }
    }
}
