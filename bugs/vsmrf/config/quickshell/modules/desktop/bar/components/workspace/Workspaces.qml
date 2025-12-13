import QtQuick
import QtQuick.Layouts
import qs.custom
import qs.services
import Quickshell
import qs.config.bar

ListView {
    id: root
    readonly property int arrowSize: 10
    property real barWidth
    // implicitWidth: Workspacescfg.cell.focusedTick
    // implicitHeight: contentHeight
    highlight: Hilight {}
    // highlight: Rectangle {}
    spacing: 4
    model: 6
    interactive: false
    currentIndex: (Landhypr.focusedWorkspace?.id - 1) % model ?? 0
    delegate: Cell {
        id: cell
        barWidth: root.barWidth
        offset: root.model * Math.floor((Landhypr.activeWsId - 1) / root.model)
        // anchors.horizontalCenter: parent.horizontalCenter
        implicitWidth: root.width
        arrowSize: root.arrowSize
    }
    highlightFollowsCurrentItem: false

    component Hilight: Item {
        y: root.currentItem.y
        width: root.currentItem.width
        height: root.currentItem.height
        Behavior on y {
            NumberAnimation {
                duration: 400
                easing.type: Easing.BezierSpline
                easing.bezierCurve: [0, 0, 0, 1, 1, 1]
            }
        }
        NerdFontText {
            id: arrow
            text: ""
            color: Colors.accent
            font.pointSize: root.arrowSize
            anchors.verticalCenter: parent.top
            anchors.left: parent.left
            anchors.leftMargin: root.currentItem?.mainPoint.x - arrow.width
            anchors.verticalCenterOffset: root.currentItem.mainPoint.y + 1
        }
    }
}
