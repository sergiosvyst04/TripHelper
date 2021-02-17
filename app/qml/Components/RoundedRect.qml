import QtQuick 2.10
import QtQuick.Shapes 1.12
import "."


Canvas {
    id: control
    property Corners corners: Corners {
       topLeftRadius: 0
       topRightRadius: 0
       bottomLeftRadius: 0
       bottomRightRadius: 0
    }

    property color color: "#fff"
    property int borderWidth: 0
    property color borderColor: "#000"

    onColorChanged: {
        requestPaint()
    }

    onBorderWidthChanged: {
        requestPaint()
    }

    onBorderColorChanged: {
        requestPaint()
    }

    onCornersChanged: {
        requestPaint()
    }

    width: 200
    height: 150

    onPaint: {
        var ctx = getContext("2d");
        ctx.save();
        ctx.clearRect(0, 0, control.width, control.height);
        ctx.strokeStyle = control.borderColor;
        ctx.lineWidth = control.borderWidth;
        ctx.fillStyle = control.color;

        ctx.beginPath();
        ctx.moveTo(corners.topLeftRadius, 0);                 // top side
        ctx.lineTo(control.width - corners.topRightRadius, 0);

        // draw top right corner
        ctx.arcTo(control.width, 0, control.width, corners.topRightRadius, corners.topRightRadius);
        ctx.lineTo(control.width, control.height - corners.bottomRightRadius);    // right side
        // draw bottom right corner
        ctx.arcTo(control.width, control.height, control.width - corners.bottomRightRadius, control.height ,corners.bottomRightRadius);
        ctx.lineTo(corners.bottomLeftRadius, control.height);              // bottom side
        // draw bottom left corner
        ctx.arcTo(0, control.height, 0, control.height - corners.bottomLeftRadius, corners.bottomLeftRadius);
        ctx.lineTo(0, corners.topLeftRadius);                 // left side
        // draw top left corner
        ctx.arcTo(0, 0, corners.topLeftRadius, 0, corners.topLeftRadius);
        ctx.closePath();
        ctx.fill();
        if (control.borderWidth > 0)
            ctx.stroke();
        ctx.restore();
    }

}
