// Generated from SVG file free.svg
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
        ShapePath {
            id: _qt_shapePath_0
            strokeColor: "transparent"
            fillColor: __qt_toplevel.fillColor
            fillRule: ShapePath.WindingFill
            pathHints: ShapePath.PathQuadratic | ShapePath.PathNonIntersecting | ShapePath.PathNonOverlappingControlPointTriangles
            PathSvg {
                path: "M 128 160 Q 128 146.725 137.363 137.363 Q 146.725 128 160 128 L 320 128 Q 333.275 128 342.638 137.363 Q 352 146.725 352 160 L 352 448 L 448 448 L 448 320 Q 448 306.725 457.362 297.362 Q 466.725 288 480 288 L 544 288 Q 557.275 288 566.638 297.362 Q 576 306.725 576 320 Q 576 333.275 566.638 342.638 Q 557.275 352 544 352 L 512 352 L 512 480 Q 512 493.275 502.638 502.638 Q 493.275 512 480 512 L 320 512 Q 306.725 512 297.362 502.638 Q 288 493.275 288 480 L 288 192 L 192 192 L 192 320 Q 192 333.275 182.637 342.638 Q 173.275 352 160 352 L 96 352 Q 82.725 352 73.3625 342.638 Q 64 333.275 64 320 Q 64 306.725 73.3625 297.362 Q 82.725 288 96 288 L 128 288 L 128 160 "
            }
        }
    }
}
