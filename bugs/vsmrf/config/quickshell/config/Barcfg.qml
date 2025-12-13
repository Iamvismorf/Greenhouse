pragma Singleton
import Quickshell
import qs.services
import QtQuick

Singleton {
    readonly property real width: 56
    readonly property real padding: 6
    readonly property Margin margin: Margin {}
    readonly property real spacing: 16
    readonly property color background: Colors.background
    component Margin: QtObject {
        readonly property real right: 12
        readonly property real left: 12
        readonly property real top: 56
        readonly property real bottom: 56
    }
}
