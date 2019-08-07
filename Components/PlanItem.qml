import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import "../Singletons"
import "../Components"

import com.plm.utils 1.0


Rectangle {
    property alias countryAndCity: cityCountryText.text
    property date depatureDate
    color: Colors.primaryColor
    radius: 28

//    onDepatureDateChanged: console.log(Qt.formatDateTime(depatureDate, "d M yy !!! hh mm "))

    Item {
        Timer {
            interval: 500; running: true; repeat: true
            onTriggered:{
                repeater.itemAt(0).timeLeft = Utils.calculateRemainigTime(depatureDate)[0];
                repeater.itemAt(1).timeLeft = Utils.calculateRemainigTime(depatureDate)[1];
                repeater.itemAt(2).timeLeft = Utils.calculateRemainigTime(depatureDate)[2];
                repeater.itemAt(3).timeLeft = Utils.calculateRemainigTime(depatureDate)[3];
            }
        }
    }


    ColumnLayout {
        anchors {
            fill: parent
            topMargin: 13
            leftMargin: 31
            bottomMargin: 15
        }

        DescriptionText {
            id: cityCountryText
            Layout.alignment: Qt.AlignLeft
            font: Fonts.openSansBold(16, Font.MixedCase)
            color: Colors.white
        }

        RowLayout {
            Repeater {
                id: repeater
                model: ["Days", "Hours", "Minutes", "Seconds"]

                delegate:   ColumnLayout {
                    property alias timeLeft: left.text
                    DescriptionText {
                        id: left
                        Layout.alignment: Qt.AlignHCenter
                        font: Fonts.openSans(11, Font.MixedCase)
                        color: Colors.white
                    }

                    DescriptionText {
                        font: Fonts.openSans(11, Font.MixedCase)
                        color: Colors.white
                        text: modelData
                    }
                }
            }
        }

        //        RowLayout {
        //            spacing: 12
        //            Layout.fillWidth: true
        //            ColumnLayout {
        //                DescriptionText {
        //                    id: daysLeft
        //                    Layout.alignment: Qt.AlignHCenter
        //                    font: Fonts.openSans(11, Font.MixedCase)
        //                    color: Colors.white
        //                }

        //                DescriptionText {
        //                    font: Fonts.openSans(11, Font.MixedCase)
        //                    color: Colors.white
        //                    text: qsTr("Days")
        //                }
        //            }

        //            ColumnLayout {
        //                DescriptionText {
        //                    id: hoursLeft
        //                    Layout.alignment: Qt.AlignHCenter
        //                    font: Fonts.openSans(11, Font.MixedCase)
        //                    color: Colors.white
        //                }

        //                DescriptionText {
        //                    font: Fonts.openSans(11, Font.MixedCase)
        //                    color: Colors.white
        //                    text: qsTr("Hours")
        //                }
        //            }

        //            ColumnLayout {
        //                DescriptionText {
        //                    id: minutesLeft
        //                    Layout.alignment: Qt.AlignHCenter
        //                    font: Fonts.openSans(11, Font.MixedCase)
        //                    color: Colors.white
        //                }

        //                DescriptionText {
        //                    font: Fonts.openSans(11, Font.MixedCase)
        //                    color: Colors.white
        //                    text: qsTr("Minutes")
        //                }
        //            }

        //            ColumnLayout {
        //                DescriptionText {
        //                    id: secondsLeft
        //                    Layout.alignment: Qt.AlignHCenter
        //                    font: Fonts.openSans(11, Font.MixedCase)
        //                    color: Colors.white
        //                }

        //                DescriptionText {
        //                    font: Fonts.openSans(11, Font.MixedCase)
        //                    color: Colors.white
        //                    text: qsTr("Seconds")
        //                }
        //            }
        //        }
    }

}
