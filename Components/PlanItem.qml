import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import "../Singletons"
import "../Components"

Rectangle {
    property alias countryAndCity: cityCountryText.text
    property date depatureDate
    property int daysLeft: new Date().daysTo(depatureDate)
    color: Colors.primaryColor
    radius: 28

    function calculateTime(daysleft) {
        var dateArray = []
        var years = 0;
        var months = 0;
        var days = 0;

         years = daysleft / 365;
        if(years > 0)
        {
            daysleft -= 365 * years;
        }
        months = daysleft / 30;
        if(months > 0)
        {
            daysleft -= 30 * months;
        }
        days = daysleft;
        dateArray.push(years);
        dateArray.push(months);
        dateArray.push(days);
        console.log("years : ", years, ", months : ", months, ", days: ", days)
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

        DescriptionText {
            id: timeLeftText
            Layout.alignment: Qt.AlignLeft
            font: Fonts.openSansBold(11, Font.MixedCase)
            horizontalAlignment: Text.AlignLeft
            color: Colors.white
            textFormat: Text.PlainText
            text: qsTr("%1 years, %2 months, %3 days\n %4 hours, %5 minutes, %6 seconds left ")
        }
    }

}
