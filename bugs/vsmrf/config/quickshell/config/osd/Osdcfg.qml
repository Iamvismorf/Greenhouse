pragma Singleton
import Quickshell
import qs.services
import QtQuick

Singleton {
    readonly property real width: 168
    readonly property real height: 40
    readonly property real padding: 6
    readonly property real radius: 14
    readonly property color background: Colors.background
    readonly property int lifeTime: 1500
    readonly property int bornNDieDuration: 250
    readonly property int textAnimation: 500
    readonly property int volumeAnimation: 250
}
