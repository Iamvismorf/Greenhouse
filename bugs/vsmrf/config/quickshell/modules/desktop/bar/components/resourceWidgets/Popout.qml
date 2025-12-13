import QtQuick.Shapes
import qs.services
import QtQuick

Shape {
    id: root
    preferredRendererType: Shape.CurveRenderer
    required property Item wrapper
    readonly property int radius: 12
    readonly property bool flatten: wrapper.implicitWidth < radius * 2
    readonly property real radiusX: flatten ? wrapper.implicitWidth / 2 : radius
    clip: true
    ShapePath {
        strokeWidth: 0
        fillColor: Colors.background
        ThisPathArc {
            direction: PathArc.Counterclockwise
        }
        PathLine {
            relativeX: root.wrapper.implicitWidth - 2 * root.radiusX
            relativeY: 0
        }
        ThisPathArc {}
        PathLine {
            relativeX: 0
            relativeY: root.wrapper.implicitHeight - 2 * root.radius
        }
        ThisPathArc {
            relativeX: -root.radiusX
        }
        PathLine {
            relativeX: -(root.wrapper.implicitWidth - 2 * root.radiusX)
            relativeY: 0
        }
        ThisPathArc {
            relativeX: -root.radiusX
            direction: PathArc.Counterclockwise
        }
    }
    component ThisPathArc: PathArc {
        relativeX: root.radiusX
        relativeY: root.radius
        radiusX: Math.min(root.radius, root.wrapper.implicitWidth)
        radiusY: root.radius
    }
}
