import QtQuick 2.7
import QtQuick.Window 2.2

pragma Singleton

QtObject {
    readonly property bool isMobile: Qt.platform.os == "ios" || Qt.platform.os == "android"

    readonly property int width : 360
    readonly property int height: 640

    readonly property real scaleRatioWidth: isMobile ? (Screen.desktopAvailableWidth / width)   : 1
    readonly property real scaleRatioHeight: isMobile ? (Screen.desktopAvailableHeight / height) : 1
}
