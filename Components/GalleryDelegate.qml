import QtQuick 2.13
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import "../Components"
import "../Singletons"


ColoredButton {
    id: btn
    checkable: editState

    color: "transparent"
    layer.enabled: editState

    onCheckedChanged:  {
        if(checked)
        {
            selectAnim.running = true
            amountOfSelectedImages += 1
        }
        else {
            amountOfSelectedImages -= 1
        }
    }

    NumberAnimation {
        id: selectAnim
        target: selectionRound
        properties: "opacity"
        from: 0
        to: 1
        duration: 200
        running: false
    }

    background:  MouseArea {
        anchors.fill: parent
        onPressAndHold: {
            editState = true
        }

        onClicked:{
            if(editState)
                parent.checked = !parent.checked
            else
            {
                swipeView.currentIndex = index
                stack.currentIndex = 1
            }

        }
    }

    Image {
        id: img
        anchors.fill: parent
        source : model.source
    }

    ColoredButton {
        id: raiseBtn
        color: "transparent"
        layer.enabled: false
        width: 20
        height: 20
        visible: editState

        Image {
            anchors.centerIn: parent
            source: "qrc:/images/assets/white icons/increaseArrows.png"
            sourceSize: Qt.size(18, 18)
        }

        anchors {
            left:  parent.left
            bottom: parent.bottom
            leftMargin: 10
            bottomMargin: 10
        }

        onClicked:{
            swipeView.currentIndex = index
            stack.currentIndex = 1
        }
    }

    Rectangle {
        id: selectionRound
        anchors {
            right: parent.right
            top: parent.top
            rightMargin: 10
            topMargin: 10
        }

        visible: editState
        height: 20
        width: 20

        color: btn.checked ? Colors.white : "transparent"
        radius: 20
        border.width: 2
        border.color: Colors.white

        Image {
            visible: btn.checked
            anchors.centerIn: parent
            source: "qrc:/images/assets/icons/apply.png"
            sourceSize: Qt.size(12, 12)
        }
    }
}
