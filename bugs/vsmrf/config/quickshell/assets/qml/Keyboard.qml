// Generated from SVG file keyboard.svg
import QtQuick
import QtQuick.VectorImage
import QtQuick.VectorImage.Helpers
import QtQuick.Shapes

Item {
    id: __qt_toplevel
    property int iconSize: 24
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
            xScale: width / 24
            yScale: height / 24
        }
    ]
    Shape {
        id: _qt_node0
        preferredRendererType: Shape.CurveRenderer
        ShapePath {
            id: _qt_shapePath_0
            strokeColor: "transparent"
            fillColor: __qt_toplevel.fillColor
            fillRule: ShapePath.WindingFill
            PathSvg {
                path: "M 20 5 L 4 5 C 2.9 5 2.01 5.9 2.01 7 L 2 17 C 2 18.1 2.9 19 4 19 L 20 19 C 21.1 19 22 18.1 22 17 L 22 7 C 22 5.9 21.1 5 20 5 M 11 8 L 13 8 L 13 10 L 11 10 L 11 8 M 11 11 L 13 11 L 13 13 L 11 13 L 11 11 M 8 8 L 10 8 L 10 10 L 8 10 L 8 8 M 8 11 L 10 11 L 10 13 L 8 13 L 8 11 M 7 13 L 5 13 L 5 11 L 7 11 L 7 13 M 7 10 L 5 10 L 5 8 L 7 8 L 7 10 M 16 17 L 8 17 L 8 15 L 16 15 L 16 17 M 16 13 L 14 13 L 14 11 L 16 11 L 16 13 M 16 10 L 14 10 L 14 8 L 16 8 L 16 10 M 19 13 L 17 13 L 17 11 L 19 11 L 19 13 M 19 10 L 17 10 L 17 8 L 19 8 L 19 10 "
            }
        }
    }
}
