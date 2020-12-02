import QtQuick 2.10
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.0
import QtQml.Models 2.13
import PackService 1.0
import CheckListModel 1.0
import CheckListFilterModel 1.0
import "../Singletons"
import "../Components"


BasePage {

    footer: Item {}

    property PackService packer

    CheckListModel {
        id: checkListModel
    }

    CheckListFilterModel {
        id: checkListFilterModel
        sourceModel: checkListModel
        searchPattern: tabBar.currentIndex === 1
    }

    ColumnLayout {
        anchors.fill: parent

        spacing: 20

        TabBar {
            id: tabBar
            Layout.fillWidth: true

            contentHeight: 50 * ScreenProperties.scaleRatioHeight

            background: Rectangle {
                anchors.fill: parent
                color: Colors.white
                Rectangle {
                    width: parent.width
                    height: 2
                    color: Colors.primaryColor
                    anchors.bottom: parent.bottom
                    opacity: 0.6
                }
            }

            CountryTabButton {
                text: qsTr("What to do")
                tabText.font: checked ? Fonts.openSansBold(13, Font.MixedCase)
                                      : Fonts.openSans(13, Font.MixedCase)
                tabText.layer.enabled: false
            }

            CountryTabButton {
                text: qsTr("What to pack")
                tabText.font:  checked ? Fonts.openSansBold(13, Font.MixedCase)
                                       : Fonts.openSans(13, Font.MixedCase)
                tabText.layer.enabled: false
            }
        }

        DescriptionText {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: parent.width
            lineHeightMode: Text.FixedHeight
            lineHeight: 20
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            text: qsTr("It is important - to not forget something
before you start your
trip")
        }

        Image {
            Layout.alignment: Qt.AlignHCenter
            sourceSize: Qt.size(100 * ScreenProperties.scaleRatioWidth, 100 * ScreenProperties.scaleRatioHeight)
            opacity: 0.3
            source: "qrc:/images/assets/icons/idea5.png"
        }

        ListView {
            id: toDoList
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.rightMargin: 25
            Layout.leftMargin: 25
            spacing: 15

            model: checkListFilterModel

            delegate: CheckListItem {
                width : toDoList.width
                group: model.group
                things: model.things
                isPackItem: model.isPacked
            }
        }
    }
}

