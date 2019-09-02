import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import "../Singletons"
import "../Components"
import ActiveTripController 1.0

BasePage {
    footer: Item{}
    header: Item{}
    backButtonVisible: true

    ActiveTripController {
        id: activeTripController
    }

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: 1


        TakePhotoPage {

        }

        ActiveTrip {
           visible: SwipeView.isCurrentItem
        }

    }


    Component.onCompleted:{
        activeTripController.intialize(appController)
    }
}
