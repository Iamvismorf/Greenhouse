pragma Singleton
import Quickshell
import QtQuick

Singleton {
    function toQtHsv(h, s, v, a = 1.0) {
        return Qt.hsva(h / 360, s / 100, v / 100, a);
    }
    readonly property color background: toQtHsv(206, 10, 12)
    // 2 54 94
    readonly property color lighterBackground: toQtHsv(205, 10, 20)
    readonly property color foreground: toQtHsv(220, 7, 95)
    readonly property color darkerForeground: toQtHsv(224, 11, 48)
    // readonly property color accent: toQtHsv(360, 59, 88)
    readonly property color accent: toQtHsv(15, 71, 88)
    // readonly property color accent: "#E5421C"
    readonly property color darkerAccent: toQtHsv(360, 59, 88, 0.4)
    //#EB756E
    //#E76D57
    readonly property color blue: toQtHsv(215, 61, 83)
    readonly property color orange: toQtHsv(25, 64, 79)
}
