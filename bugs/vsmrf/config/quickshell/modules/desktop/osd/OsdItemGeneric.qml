import QtQuick
import qs.config.osd
import qs.services

Rectangle {
    // required property Loader ldr
    required property Loader loader
    implicitWidth: Osdcfg.width
    implicitHeight: Osdcfg.height + 2 * Osdcfg.padding
    radius: Osdcfg.radius
    color: Osdcfg.background
    opacity: 0
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            loader.impendingDoom();
        }
    }
    Component.onCompleted: opacity = 1
    Behavior on opacity {
        NumberAnimation {
            duration: Osdcfg.bornNDieDuration
        }
    }
}
