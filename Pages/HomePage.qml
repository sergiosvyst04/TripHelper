import QtQuick 2.10
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import "../Singletons"
import "../Components"


ColumnLayout {
    spacing: 15
    anchors {
        fill: parent
        leftMargin: 40
        rightMargin: 40
    }

    Image {
        Layout.alignment: Qt.AlignHCenter
        source: "qrc:/images/assets/emblem.png"
        sourceSize: Qt.size(200, 165)
    }

    Flickable {
        id: flickable

        boundsBehavior: Flickable.StopAtBounds
        Layout.fillWidth: true
        Layout.fillHeight: true
        clip: true
        contentHeight: column.height
        contentWidth: column.width
        bottomMargin: 10

        ColumnLayout {
            id: column
            spacing: 15
            width: flickable.width

            Repeater {
                model: ListModel {
                    ListElement { actionText: "Start trip"; image: "qrc:/images/assets/white icons/startbtn.png"; navigationMethod: function(){navigateToItem("qrc:/Pages/StartTripPage.qml")}}
                    ListElement { actionText: "Add goal"; image: "qrc:/images/assets/white icons/goals.png"; navigationMethod: function(){navigateToItem("qrc:/Pages/AddGoalPage.qml")} }
                    ListElement { actionText: "Organization help"; image: "qrc:/images/assets/white icons/organizat help.png"; navigationMethod: function(){navigateToItem("qrc:/Pages/OrganizationHelpPage.qml")}}
                    ListElement { actionText: "Settings"; image: "qrc:/images/assets/white icons/settings.png"; navigationMethod: function(){navigateToItem("qrc:/Pages/SettingsPage.qml")}}
                    ListElement { actionText: "Sign Out"; image: "qrc:/images/assets/white icons/settings.png"; navigationMethod: function(){authService.signOut(), replaceView("qrc:/Pages/StartedPage.qml")}  }
                }

                HomeActionButton {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.minimumWidth: column.width - 10
                    Layout.minimumHeight: 105
                    opacity: enabled ? 1.0 : 0.3

                    enabled: index === 0 ? !tripsManager.waitingTripExists && !tripsManager.activeTripExists : true

                    image: model.image
                    actionText: model.actionText
                    onClicked: navigationMethod()
                }
            }
        }
    }
}
