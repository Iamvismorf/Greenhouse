// todo: imaage https://github.com/Nytril-ark/rumda/blob/main/quickshell/shell.qml
// todo: config
// todo: transition between pin and free
import Quickshell
import qs.services
import QtQuick
import QtQuick.VectorImage
import QtQuick.Shapes
import "components"
import "components/workspace"
import "components/resourceWidgets"
import QtQuick.Layouts
import qs.custom

// WrapperItem {
//     id: barWrapper
//     leftMargin: Barcfg.margin.left
//     rightMargin: Barcfg.margin.right
//     topMargin: Barcfg.margin.top
//     bottomMargin: Barcfg.margin.bottom
//     child: Rectangle {
//         implicitWidth: Barcfg.width + 2 * Barcfg.padding
//     }
// }
//
//

Rectangle {
    id: root
    property bool locked: false
    component Inbetween: Rectangle {
        id: sth
        property bool isShitAnchored: topr.state == ""
        width: isShitAnchored ? 16 : 8
        height: isShitAnchored ? 2 : 8
        color: isShitAnchored ? Colors.darkerForeground : Colors.foreground
        radius: isShitAnchored ? 0 : 100
        anchors.horizontalCenter: parent.horizontalCenter
    }
    component ThisBar: Rectangle {
        id: barcmp
        states: [
            State {
                name: "moveable"
                AnchorChanges {
                    target: barcmp
                    anchors.left: undefined
                    anchors.bottom: undefined
                }
            }
        ]
        implicitWidth: 64
        color: Colors.background
        Drag.active: draghandler.active
        DragHandler {
            id: draghandler
            enabled: !root.locked
            onActiveChanged: {
                topr.state = "moveable";
                btm.state = "moveable";
                if (!active) {
                    barcmp.Drag.drop();
                }
            }
            xAxis.minimum: 0
            xAxis.maximum: root.implicitWidth - parent.implicitWidth
        }
    }
    component ThisColumnLayout: ColumnLayout {
        anchors.fill: parent
        anchors.topMargin: 16
        anchors.bottomMargin: 16
        spacing: 16
    }
    implicitWidth: 96
    color: "transparent"
    ThisBar {
        id: topr
        Drag.keys: ["toprsender"]
        Drag.hotSpot.x: width / 2
        Drag.hotSpot.y: 59 * height / 60

        anchors.bottom: btm.top
        anchors.left: btm.left
        implicitHeight: 512
        Inbetween {
            anchors.verticalCenter: parent.bottom
        }
        ThisColumnLayout {

            Item {
                clip: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                implicitWidth: sth.implicitWidth
                implicitHeight: sth.implicitHeight
                MouseArea {
                    anchors.fill: parent
                    onPressed: root.locked = !root.locked
                    cursorShape: Qt.PointingHandCursor
                }
                SvgIcon {
                    size: 24
                    sauce: Quickshell.iconPath(Quickshell.shellPath("assets/pin"))
                    fillColor: Colors.accent
                    opacity: root.locked
                    y: opacity ? 0 : -24
                    Behavior on y {
                        NumberAnimation {
                            easing.bezierCurve: [0.547, -0.682, 0.246, 1.472, 1, 1]
                        }
                    }
                }
                SvgIcon {
                    id: sth
                    size: 24
                    sauce: Quickshell.iconPath(Quickshell.shellPath("assets/free"))
                    fillColor: Colors.blue
                    opacity: !root.locked
                    x: opacity ? 0 : 24
                    Behavior on opacity {
                        NumberAnimation {}
                    }
                    Behavior on x {
                        NumberAnimation {
                            easing.bezierCurve: [0.633, 0.009, 0.602, 0.987, 1, 1]
                            duration: 300
                        }
                    }
                }
            }
            Workspaces {
                Layout.fillHeight: true
                Layout.fillWidth: true
                // Layout.preferredWidth: parent.width
                barWidth: parent.width
                Layout.alignment: Qt.AlignHCenter
            }
            KeyboardLayout {
                Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            }
        }
    }
    Shape {
        preferredRendererType: Shape.CurveRenderer
        z: 100

        ShapePath {
            id: shapePath
            strokeColor: Colors.foreground
            strokeWidth: 3
            fillColor: "transparent"
            property point startPt: Qt.point(topr.x + topr.width / 2, topr.y + topr.height)
            property point endPt: Qt.point(btm.x + btm.width / 2, btm.y)
            property real length: Math.sqrt(Math.pow(endPt.x - startPt.x, 2) + Math.pow(endPt.y - startPt.y, 2))
            property real scaleFPath: length / 200

            startX: startPt.x
            startY: startPt.y

            PathCubic {
                control1X: shapePath.startPt.x + Math.min(50 * shapePath.scaleFPath, 75)
                control1Y: shapePath.startPt.y

                control2X: shapePath.endPt.x - Math.min(50 * shapePath.scaleFPath, 75)
                control2Y: shapePath.endPt.y

                x: shapePath.endPt.x
                y: shapePath.endPt.y
            }
        }
    }

    ThisBar {
        id: btm

        implicitHeight: col.implicitHeight + 16 * 2
        anchors.bottom: root.bottom
        anchors.left: root.left
        anchors.bottomMargin: 56
        anchors.leftMargin: 16
        Drag.keys: ["btmsender"]
        Drag.hotSpot.x: width / 2
        Drag.hotSpot.y: height / 60
        DropArea {
            anchors.fill: parent
            keys: ["toprsender", "toprreceiver"]
            onDropped: {
                topr.state = "";
            }
        }

        Inbetween {
            anchors.verticalCenter: parent.top
        }
        ThisColumnLayout {
            id: col
            Clock {
                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                Layout.fillWidth: true
            }
            Resource {
                id: resouce
                Layout.alignment: Qt.AlignHCenter
                Layout.fillHeight: true
                Layout.fillWidth: true
            }
            OsIcon {
                Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
                Layout.fillWidth: true
            }
        }
    }
}
