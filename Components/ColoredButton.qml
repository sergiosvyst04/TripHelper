import QtQuick 2.12
import QtQuick.Controls 2.5
import "../Singletons"

Button {
  id: root
  property alias color: back.color
  property alias fontColor: textItem.color
  property alias textAlignment: textItem.horizontalAlignment
  property alias corners: back.corners

  font: Fnrs
  background: RoundedRect {
      id: back
      anchors.fill: parent
      corners {
          topLeftRadius: 28
          topRightRadius: 28
          bottomLeftRadius: 28
          bottomRightRadius: 28
      }
  }

  contentItem: Text {
      id: textItem
      horizontalAlignment: Text.AlignHCenter
      verticalAlignment: Text.AlignVCenter
      text: root.text
      font: root.font
  }
}
