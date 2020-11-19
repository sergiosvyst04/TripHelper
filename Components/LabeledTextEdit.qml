import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0
import "../Singletons"
import "../Components"

Column {
    id: root
    spacing: 10
    property alias label: label.text
    property alias text: textField.text
    property bool usePasswordMask: false
    
    property alias textField: textField
    property string approveText
    property string warningText

    property alias validator: textField.validator
    property alias validated: textField.validated
    property alias readOnly: textField.readOnly

    DescriptionText {
        id: label
        font: Fonts.openSans(12, Font.MixedCase)
        height: 16
    }

    Column {
        spacing: 7
        width: parent.width

        StyledTextEdit {
            id: textField
            width: parent.width
            height: 30
            isPassword: usePasswordMask

            onHasNotValidated: {
                additionalTextLabel.state = "rejected"
            }

            onValidatedChanged: {
                if(validated === true) {
                    additionalTextLabel.state = "approved"
                }
                else {
                    additionalTextLabel.state = ""
                }
            }

        }

        Label {
            id: additionalTextLabel
            property bool approved
            height: 18
            width: parent.width
            font: Fonts.openSans(11, Font.MixedCase)
            text: approved ? approveText : warningText
            color: state === "" ? "transparent" : approved ? Colors.approveTextColor : Colors.warningTextColor

            states: [
                State {
                    name: "rejected"
                    PropertyChanges {
                        target: additionalTextLabel
                        approved: false
                    }

                },
                State {
                    name: "approved"
                    PropertyChanges {
                        target: additionalTextLabel
                        approved: true
                    }
                }
            ]

//            transitions: [
//                Transition {
//                    to: "approved"
//                    reversible: true
//                    onRunningChanged: console.log("transition running changed to : ", running)

//                    ParallelAnimation {
//                        id: approveAnimation
//                        onRunningChanged: console.log("parallel animation running changed to : ", running)
//                        NumberAnimation {
//                            property: "opacity"
//                            to: 0
//                            duration: 1000
//                        }

//                        OpacityAnimator {
//                               from: 0;
//                               to: 1;
//                               duration: 1000
//                           }

//                        NumberAnimation {
//                            property: "width"
//                            from: width - 10
//                            to: width
//                            duration: 150
//                        }
//                    }
//                },
//                Transition {
//                    reversible: true
//                    to: "rejected"
//                    SequentialAnimation {
//                        id: warningAnim

//                        NumberAnimation {
//                            property: "width"
//                            from: width
//                            to: width + 10
//                            duration: 100
//                        }

//                        NumberAnimation {
//                            property: "width"
//                            from: width + 10
//                            to: width - 10
//                            duration: 100
//                        }

//                        NumberAnimation {
//                            property: "width"
//                            from: width - 10
//                            to: width
//                            duration: 100
//                        }
//                    }
//                }
//            ]
        }
    }
}
