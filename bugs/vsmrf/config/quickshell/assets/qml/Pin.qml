// Generated from SVG file pin.svg
import QtQuick
import QtQuick.VectorImage
import QtQuick.VectorImage.Helpers
import QtQuick.Shapes

Item {
    id: __qt_toplevel
    property int iconSize: 22
    property color fillColor
    implicitWidth: iconSize
    implicitHeight: iconSize
    component AnimationsInfo: QtObject {
        property bool paused: false
        property int loops: 1
        signal restart
    }
    property AnimationsInfo animations: AnimationsInfo {}
    transform: [
        Scale {
            xScale: width / 640
            yScale: height / 640
        }
    ]
    Shape {
        id: _qt_node0
        preferredRendererType: Shape.CurveRenderer
        // fillMode: Shape.PreserveAspectFit
        ShapePath {
            id: _qt_shapePath_0
            strokeColor: "transparent"
            fillColor: __qt_toplevel.fillColor
            fillRule: ShapePath.WindingFill
            PathSvg {
                path: "M 160 96 C 160 78.3 174.3 64 192 64 L 448 64 C 465.7 64 480 78.3 480 96 C 480 113.7 465.7 128 448 128 L 418.5 128 L 428.8 262.1 C 465.9 283.3 494.6 318.5 507 361.8 L 510.8 375.2 C 513.6 384.9 511.6 395.2 505.6 403.3 C 499.6 411.4 490 416 480 416 L 160 416 C 150 416 140.5 411.3 134.5 403.3 C 128.5 395.3 126.5 384.9 129.3 375.2 L 133 361.8 C 145.4 318.5 174 283.3 211.2 262.1 L 221.5 128 L 192 128 C 174.3 128 160 113.7 160 96 M 288 464 L 352 464 L 352 576 C 352 593.7 337.7 608 320 608 C 302.3 608 288 593.7 288 576 L 288 464 "
            }
        }
    }
}
