import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.10
import QtQuick.Layouts 1.12
import QtQuick.Window 2.12
import QtMultimedia 5.13
import "Components"
import "Singletons"

ApplicationWindow {
    visible: true
    width: 360
    height: 640
    title: qsTr("Trip Helper")

    StackView {
        id: rootStackView
        anchors.fill: parent
        initialItem: {
            if(authService.isSignedIn())
                Qt.resolvedUrl("qrc:/Pages/StartedPage.qml")
            else
                Qt.resolvedUrl("qrc:/Pages/StartedPage.qml")
        }
        Keys.onBackPressed: {

        }
    }

    //    Connections {
    //        target: locationController
    //        onCountryChanged : {
    //            navigateToItem("qrc:/Pages/CountryInformationPage.qml")
    //        }
    //    }


    //    Connections {
    //        target: tripController
    ////        onCurrentTripStateChanged: {
    ////            loader.sourceComponent = addIdeaPopup
    ////            loader.active = true
    ////        }

    //        onForgotToPack: {
    //            console.log("forgot to pack items")
    //            loader.sourceComponent = warningPopup
    //            loader.active = true
    //            player.play()
    //        }
    //    }


    function navigateBack() {
        rootStackView.pop();
    }

    function navigateToFirst() {
        rootStackView.pop(null)
    }

    function replaceItem(itemURL, properties) {
        rootStackView.replace(___maybeResolveUrl(itemURL), properties)
    }

    function replaceView(itemURL) {
        rootStackView.clear();
        navigateToItem(itemURL);
    }

    function navigateToItem(itemURL, properties) {
        rootStackView.push(___maybeResolveUrl(itemURL), properties);
    }

    function __isString(arg) {
        return typeof arg === 'string' || arg instanceof String
    }

    function ___maybeResolveUrl(itemURL){
        if(__isString(itemURL)) {
            return Qt.resolvedUrl(itemURL)
        }
        else {
            return itemURL;
        }
    }

    function loadToMainLoader(popup) {
        mainLoader.sourceComponent = popup
        mainLoader.active = true
    }

    function unloadFromMainLoader() {
        mainLoader.active = false
    }

    Audio {
        id: player
        source: "qrc:/images/assets/sounds/danger-alarm-23793.mp3"
    }

    Loader {
        id: mainLoader
        active: false
    }

    Component {
        id: warningPopup

        GeneralPopup {
            height: 230
            width: 230
            title.text: qsTr("We notice that you\n forgot to pack some\n items")
            title.font: Fonts.openSans(16, Font.MixedCase)
            title.color: Colors.white
            popupColor: "#BA0202"

            Item {
                Layout.fillHeight: true
            }

            ColoredButton {
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredHeight: 36
                Layout.preferredWidth: 100
                color: Colors.redButtonColor
                layer.enabled: false
                text: qsTr("Pack")
                fontColor: Colors.white
                font: Fonts.openSansBold(13, Font.MixedCase)
                onClicked: {
                    unloadFromMainLoader()
                    navigateToItem("qrc:/Pages/MakeListPage.qml")
                    player.stop()
                }
            }
        }
    }

}





