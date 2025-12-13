pragma Singleton
import QtQuick
import qs.services
import Quickshell

Singleton {
    id: root
    // readonly property real width: Barcfg.width - 2 * Barcfg.padding
    readonly property Cell cell: Cell {}
    component Cell: QtObject {
        readonly property real focusedTick: 32
        readonly property color focusedTickColor: Colors.accent

        readonly property real unfocusedTick: 16
        readonly property color unfocusedTickColor: Colors.foreground

        readonly property real regularTick: 8
        readonly property color regularTickColor: Colors.darkerForeground
    }
}
