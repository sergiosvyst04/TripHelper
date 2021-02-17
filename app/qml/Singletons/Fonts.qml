import QtQuick 2.7

pragma Singleton

QtObject {

    readonly property string __openSans: "Open Sans"

    function openSans(size, capitalization){
        var font = Qt.font( {family: __openSans, pixelSize: size} )
        font.weight = Font.Normal
        if(capitalization !== undefined) {
            font.capitalization = capitalization;
        }

        return font
    }

    function openSansBold(size, capitalization) {
        var font = Qt.font( {family: __openSans, pixelSize: size})
        font.weight = Font.Bold
        if(capitalization !== undefined) {
            font.capitalization = capitalization;
        }
        return font
    }


}
