import QtQuick 2.10
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import "../Singletons"
import "../Components"

//BasePage {
//    footer: Item{}
//    header: Item {}

    ColumnLayout {
        spacing: 34
        anchors{
            fill: parent
            topMargin: 10
            rightMargin: 14
            leftMargin: 14
        }

        ProfileAvatarAndDataItem {
            Layout.fillWidth: true
            Layout.minimumHeight: 135
        }

        GridLayout {

            Layout.alignment: Qt.AlignHCenter
            columns: 2
            columnSpacing: 24
            rowSpacing: 22
            ProfileButton {
                Layout.minimumWidth: 138
                Layout.minimumHeight: 168
                color: Colors.primaryColor
                background : Rectangle {
                    radius: 28
                    gradient: Gradient {
                        GradientStop {position: 0.0; color: "#53A7D7" }
                        GradientStop {position: 1.0; color: "#51F5FF" }
                    }
                }
            }

            ProfileButton {
                Layout.minimumWidth: 138
                Layout.minimumHeight: 168
                color: Colors.greenButtonColor
                image: "qrc:/images/assets/white icons/active.png"
                buttonText: qsTr("Active trip")
                onClicked: navigateToItem("qrc:/Pages/ActiveTripPage.qml")
                background : Rectangle {
                    radius: 28
                    gradient: Gradient {
                        GradientStop {position: 0.0; color: "#60FFE2" }
                        GradientStop {position: 1.0; color: "#7EFF1A" }
                    }
                }
            }

            ProfileButton {
                Layout.minimumWidth: 138
                Layout.minimumHeight: 168
                color: Colors.redButtonColor
                image: "qrc:/images/assets/white icons/completed.png"
                buttonText: qsTr("Completed trips")
                onClicked: navigateToItem("qrc:/Pages/CompletedTripsPage.qml")
                background : Rectangle {
                    radius: 28
                    gradient: Gradient {
                        GradientStop {position: 0.0; color: Colors.redButtonColor }
                        GradientStop {position: 1.0; color: "#752424" }
                    }
                }
            }

            ProfileButton {
                Layout.minimumWidth: 138
                Layout.minimumHeight: 168
                color: Colors.yellowButtonColor
                image: "qrc:/images/assets/white icons/goal.png"
                buttonText: qsTr("My goals")
                background : Rectangle {
                    radius: 28
                    gradient: Gradient {
                        GradientStop {position: 0.0; color: "#EA6317"}
                        GradientStop {position: 1.0; color: "#FFC000" }
                    }
                }
                onClicked: navigateToItem("qrc:/Pages/PlansPage.qml")
            }
        }

        Item {
            Layout.fillHeight: true
        }
    }
//}
