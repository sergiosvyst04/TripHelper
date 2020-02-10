import QtQuick 2.13
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import "../Singletons"
import "../Components"

RowLayout {
    property alias flag: flagImage.source
    property alias country: countryText.text

    spacing: 30

    Image {
        id: flagImage
        Layout.leftMargin: 30
        sourceSize: Qt.size(50, 40)
    }

    DescriptionText {
        id: countryText
        font: Fonts.openSansBold(15, Font.MixedCase)
    }

    Item {
        Layout.fillWidth: true
    }

    ColoredButton {
        Layout.rightMargin: 25
        Layout.preferredWidth: 85
        Layout.preferredHeight: 35

        color: Colors.primaryColor
        font: Fonts.openSans(12, Font.MixedCase)
        fontColor: Colors.white
        text: qsTr("See photos")
        layer.enabled: false
        onClicked: navigateToItem("qrc:/Pages/GalleryPage.qml", {location : country})
    }
}
