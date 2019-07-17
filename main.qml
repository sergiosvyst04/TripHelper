import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.10
import QtQuick.Layouts 1.12
import QtQuick.Window 2.12

ApplicationWindow {
    visible: true
    width: 360
    height: 640
    title: qsTr("Trip Helper")

    StackView {
        id: rootStackView
        anchors.fill: parent
        initialItem: Qt.resolvedUrl("qrc:/Pages/StartedPage.qml")
        Keys.onBackPressed: {

        }
    }


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
}





