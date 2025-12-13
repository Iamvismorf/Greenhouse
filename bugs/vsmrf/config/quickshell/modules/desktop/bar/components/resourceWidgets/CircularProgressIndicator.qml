import QtQuick
import QtQuick.Shapes
import qs.services
import qs.custom

Item {
    id: root
    // should between 0 and 1
    required property real value // docs this because don't remember the required format
    Behavior on value {
        Anim {}
    }
    readonly property real uh: Math.max(left.strokeWidth, current.strokeWidth)
    property int size: 28
    property var iconSauce
    property int iconSize: 14
    property color iconColor: Colors.accent
    property real gap: 360 / 10
    implicitWidth: wrapper.implicitWidth
    implicitHeight: wrapper.implicitHeight
    SvgIcon {
        size: root.iconSize
        sauce: root.iconSauce
        fillColor: root.iconColor
        anchors.centerIn: parent
    }
    Item {
        id: wrapper
        anchors.centerIn: parent
        implicitWidth: root.size
        implicitHeight: root.size
        Shape {
            id: shapeRoot
            anchors.fill: parent
            preferredRendererType: Shape.CurveRenderer
            smooth: true
            antialiasing: true
            ThisShapePath {
                id: left
                property int leftGap: root.value == 0 ? 0 : 2
                Behavior on leftGap {
                    Anim {}
                }
                strokeWidth: 3
                strokeColor: Colors.darkerAccent
                ThisPathAngleArc {
                    startAngle: -90 - root.gap
                    sweepAngle: Math.min(0, -(360 - left.leftGap * root.gap - root.value * 360))
                }
            }
            ThisShapePath {
                id: current
                strokeWidth: 4
                strokeColor: Colors.accent
                ThisPathAngleArc {
                    startAngle: -90
                    sweepAngle: root.value * 360
                }
            }
        }
    }
    component ThisPathAngleArc: PathAngleArc {
        centerX: shapeRoot.width / 2
        centerY: shapeRoot.width / 2
        radiusX: shapeRoot.width / 2
        radiusY: shapeRoot.width / 2
    }
    component ThisShapePath: ShapePath {
        fillColor: "transparent"
        capStyle: ShapePath.RoundCap
    }
}
