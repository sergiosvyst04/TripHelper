import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.10
import QtQuick.Layouts 1.12
import QtQuick.Window 2.12
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
        initialItem: Qt.resolvedUrl("qrc:/Pages/MainPage.qml")
        Keys.onBackPressed: {

        }
    }


    Connections {
        target: tripController
        onCurrentTripStateChanged: {
            console.log("trip controller state changed")
            loader.active = true
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

    Loader {
        id: loader
        active: false

        sourceComponent: addIdeaPopup

        Component {
            id: addIdeaPopup
            Popup {
                anchors.centerIn: parent

                implicitHeight: 315
                implicitWidth: 232

                padding: 0

                parent: Overlay.overlay
                modal: true
                visible: true

                background: Rectangle {
                    radius: 28
                    gradient: Gradient {
                        GradientStop {position: 0.0; color: Colors.primaryColor }
                        GradientStop {position: 0.45; color: Colors.white }
                    }
                }

                onAboutToHide: loader.active = false

                ColumnLayout {
                    spacing: 20
                    anchors {
                        fill: parent
                        topMargin: 15
                        leftMargin: 24
                        rightMargin: 24
                        bottomMargin: 24
                    }

                    DescriptionText {
                        Layout.alignment: Qt.AlignHCenter
                        text: qsTr("Add new idea")
                        color: Colors.grey
                        font: Fonts.openSansBold(16, Font.MixedCase)
                    }

                    DescriptionText {
                        Layout.alignment: Qt.AlignHCenter
                        textFormat: Text.PlainText
                        color: Colors.grey
                        text: qsTr("Congratulations with first day \n of your trip")
                        font: Fonts.openSans(13, Font.MixedCase)
                    }

                    ScrollView {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 95
                        ScrollBar.vertical.policy: ScrollBar.AlwaysOff

                        TextArea {
                            id: textArea
                            height: parent.height
                            width: parent.width
                            clip: true

                            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                            color: Colors.grey
                            font: Fonts.openSans(13, Font.MixedCase)
                            padding: 10
                            placeholderText: qsTr("I want to...")

                            background: Rectangle {
                                anchors.fill: parent
                                radius: 10
                                color: Colors.textAreaColor
                                opacity: 0.4
                            }
                        }
                    }

                    Item {
                        Layout.fillHeight: true
                    }

                    ColoredButton {
                        Layout.alignment: Qt.AlignHCenter
                        Layout.preferredHeight: 36
                        Layout.preferredWidth: 86
                        color: Colors.primaryColor
                        layer.enabled: false
                        text: qsTr("Thanks")
                        fontColor: Colors.white
                        font: Fonts.openSansBold(13, Font.MixedCase)
                        onClicked: loader.active = false
                    }
                }
            }
        }
    }
}





