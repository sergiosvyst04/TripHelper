import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.10
import "../Singletons"
import "../Components"

BasePage {
    header: Item {}

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: 2
        onCurrentIndexChanged: {

        }

        Item {
            id: scratchMap
            visible: SwipeView.isCurrentItem
            ScratchMapPage {
            }
        }

        Item {
            id: homePage
            visible: SwipeView.isCurrentItem
            Layout.fillWidth: true
            HomePage {
                id: home
            }
        }

        Item {
            id: profilePage
            visible: SwipeView.isCurrentItem
            ProfilePage{

            }
        }

    }



    footer:  PageIndicator {
        id: pageIndicator
        width: parent.width
        height: 50

        delegate: Image {
            opacity: index === pageIndicator.currentIndex ? 0.8 : 0.3
            source : {
                if(index === 0)
                    source = "qrc:/images/assets/icons/globe.png"
                else if (index === 1)
                    source = "qrc:/images/assets/icons/HOme.png"
                else
                    source = "qrc:/images/assets/icons/profile.png"
            }
            sourceSize: Qt.size(36, 36)

            //            Rectangle {
            //                id: rect

            //                anchors {
            ////                    horizontalCenter: parent.right
            //                    horizontalCenter: parent.horizontalCenter
            //                    verticalCenter: parent.verticalCenter
            //                }
            //                height: 45
            //                width: 85
            //                radius: 28
            //                color: index === pageIndicator.currentIndex ? Colors.primaryColor : "transparent"
            //                opacity: 0.4
            //                onColorChanged: {
            //                    if(index === pageIndicator.currentIndex)
            //                        anim.running = true
            //                }

            //                NumberAnimation {
            //                    id: anim
            //                    target: rect
            //                    property: "width"
            //                    from: 50
            //                    to : 85
            //                    duration: 250
            //                    running: false
            //                }
            //            }
        }

        anchors.bottom: parent.bottom
        leftPadding: parent.width / 7
        rightPadding: parent.width / 10
        bottomPadding: 10
        spacing: parent.width / 5
        count: swipeView.count
        currentIndex: swipeView.currentIndex
    }
}

