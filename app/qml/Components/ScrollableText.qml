import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import "../Singletons"
import "../Components"

ScrollView {
    property alias informationText : textComponent.text
    clip: true
    DescriptionText {
        id: textComponent
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        width: parent.width
        textFormat: Text.PlainText
        horizontalAlignment: Text.AlignLeft
    }
}
